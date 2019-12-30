locals {
  stripped_domain_name = "${replace("devops.care", "/[.]$/", "")}"
}

data "aws_route53_zone" "devops_care" {
  name = "devops.care."
}

resource "aws_ses_domain_identity" "main" {
  domain = "${local.stripped_domain_name}"
}

resource "aws_ses_domain_dkim" "main" {
  domain = "${aws_ses_domain_identity.main.domain}"
}

# resource "aws_route53_record" "ses_verification" {
#   zone_id = "${data.aws_route53_zone.devops_care.zone_id}"
#   name    = "_amazonses.${aws_ses_domain_identity.main.id}"
#   type    = "TXT"
#   ttl     = "600"
#   records = ["${aws_ses_domain_identity.main.verification_token}"]
# }


# resource "aws_route53_record" "dkim" {
#   count   = 3
#   zone_id = "${data.aws_route53_zone.devops_care.zone_id}"
#   name    = "${format("%s._domainkey.%s", element(aws_ses_domain_dkim.main.dkim_tokens, count.index), "devops.care")}"
#   type    = "CNAME"
#   ttl     = "600"
#   records = ["${element(aws_ses_domain_dkim.main.dkim_tokens, count.index)}.dkim.amazonses.com"]
# }

# resource "aws_route53_record" "spf_domain" {
#   zone_id = "${data.aws_route53_zone.devops_care.zone_id}"
#   name    = "${"devops.care"}"
#   type    = "TXT"
#   ttl     = "600"
#   records = ["v=spf1 include:amazonses.com -all"]
# }

# resource "aws_route53_record" "txt_dmarc" {
#   zone_id = "${data.aws_route53_zone.devops_care.zone_id}"
#   name    = "_dmarc.${"devops.care"}"
#   type    = "TXT"
#   ttl     = "600"
#   records = ["v=DMARC1; p=none; rua=mailto:dmarc@devops.care;"]
# }

resource "aws_iam_user" "ses" {
  name = "ses-smtp-user"
}

resource "aws_iam_access_key" "ses" {
  user = "${aws_iam_user.ses.name}"
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
  user = "${aws_iam_user.ses.name}"

  policy = "${data.aws_iam_policy_document.ses.json}"
}
