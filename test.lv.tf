module "dmitrijsv" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.15.0"
  namespace   = "dmitrijsv"
  environment = "test.lv"
}

resource "cloudflare_zone" "test_lv" {
  zone = "test.lv"
  plan = "free"
  type = "full"
}

resource "cloudflare_record" "test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = cloudflare_zone.test_lv.zone
  value   = local.mikakosha
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www_test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = "www.${cloudflare_zone.test_lv.zone}"
  value   = local.mikakosha
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "mx_test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = cloudflare_zone.test_lv.zone
  value   = "mail.kid.lv."
  type    = "MX"
  ttl     = 86400
}