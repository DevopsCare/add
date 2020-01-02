locals {
  stripped_domain_name = "${replace("devops.care", "/[.]$/", "")}"
}

resource "aws_ses_domain_identity" "main" {
  domain = local.stripped_domain_name
}

resource "aws_ses_domain_dkim" "main" {
  domain = aws_ses_domain_identity.main.domain
}

resource "cloudflare_record" "ses_dkim_devops_care" {
  count   = 3
  zone_id = cloudflare_zone.devops_care.id
  name    = format("%s._domainkey", aws_ses_domain_dkim.main.dkim_tokens[count.index])
  value   = "${aws_ses_domain_dkim.main.dkim_tokens[count.index]}.dkim.amazonses.com"
  type    = "CNAME"
  ttl     = 600
  proxied = false
}
