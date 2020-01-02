locals {
  stripped_domain_name = "${replace("devops.care", "/[.]$/", "")}"
}

resource "aws_ses_domain_identity" "main" {
  domain = local.stripped_domain_name
}

resource "aws_ses_domain_dkim" "main" {
  domain = aws_ses_domain_identity.main.domain
}

resource "cloudflare_record" "devops_care_dkim" {
  count   = 3
  zone_id = cloudflare_zone.devops_care.id
  name    = format("%s._domainkey.%s", aws_ses_domain_dkim.main.dkim_tokens[count.index], "devops.care")
  value   = "${aws_ses_domain_dkim.main.dkim_tokens[count.index]}.dkim.amazonses.com"
  type    = "CNAME"
  ttl     = 600
  proxied = false
}

resource "cloudflare_record" "devops_care_spf" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "devops.care"
  value   = "v=spf1 include:amazonses.com -all"
  type    = "TXT"
  ttl     = 600
}

resource "cloudflare_record" "devops_care_dmarc" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "_dmarc.devops.care"
  value   = "v=DMARC1; p=none; rua=mailto:dmarc@devops.care;"
  type    = "TXT"
  ttl     = 600
}

resource "aws_iam_user" "ses" {
  name = "ses-smtp-user"
}

resource "aws_iam_access_key" "ses" {
  user = aws_iam_user.ses.name
}

data "aws_iam_policy_document" "ses" {
  statement {
    actions = [
        "ses:SendRawEmail",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "ses" {
  name = "AmazonSesSendingAccess"
  user = aws_iam_user.ses.name

  policy = data.aws_iam_policy_document.ses.json
}
