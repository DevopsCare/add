module "devopcare" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace   = "devopcare"
  environment = "devops.care"
}

resource "cloudflare_zone" "devops_care" {
  zone = "devops.care"
  plan = "free"
  type = "full"
}

#### web site
resource "cloudflare_record" "devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "@"
  value   = "www231.wixdns.net."
  type    = "CNAME"
  ttl     = 86400
}

resource "cloudflare_record" "www_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "www"
  value   = "www231.wixdns.net."
  type    = "CNAME"
  ttl     = 86400
}

#### ADDъ
resource "cloudflare_record" "add-hosting_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "add-hosting"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
  proxied = true
}

# Eventually disable and switch to per-host proxied domains
resource "cloudflare_record" "wld-add-hosting_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "*.add-hosting"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
}

#### MX and related
resource "cloudflare_record" "mx1_devops_care" {
  zone_id  = cloudflare_zone.devops_care.id
  name     = "@"
  value    = "mail.protonmail.ch."
  type     = "MX"
  priority = 10
}

resource "cloudflare_record" "mx2_devops_care" {
  zone_id  = cloudflare_zone.devops_care.id
  name     = "@"
  value    = "mailsec.protonmail.ch."
  type     = "MX"
  priority = 20
}

resource "cloudflare_record" "pm_verify_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "@"
  value   = "protonmail-verification=d8a092ba0016b1c5c2b74ba276566ed5820780d7"
  type    = "TXT"
}

resource "cloudflare_record" "spf_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "@"
  value   = "v=spf1 include:_spf.protonmail.ch mx ~all"
  type    = "TXT"
}

resource "cloudflare_record" "dmarc_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "_dmarc"
  value   = "v=DMARC1; p=quarantine; rua=mailto:vermut@pm.me"
  type    = "TXT"
}

resource "cloudflare_record" "dkim_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "protonmail._domainkey"
  value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDxfKfxwWYAVvMhdmzJ1Icc8NfNEi+muj8OlCzBRc7GvCVwTcNjVkvKruCP91KEwf/NvnGovNGnpaCqqiPavpJmU2bOKZrFYZHgmZGEEI0yLLQzBar3fgXjM9of6f87OhuwcUm0zOd3QvbuVN7NPAknHMvK5ZVVpz+DbZ5pRv9EwIDAQAB"
  type    = "TXT"
}

#### misc
resource "cloudflare_record" "github_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "_github-challenge-devopscare"
  value   = "49419b1831"
  type    = "TXT"
}


#### new hosting
resource "cloudflare_record" "new_devops_care" {
  zone_id = cloudflare_zone.devops_care.id
  name    = "new"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
  ttl     = 1
  proxied = true
}