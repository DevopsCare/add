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
  zone_id = cloudflare_zone.test_lv.zone
  name    = module.dmitrijsv.environment
  value   = local.mikakosha
  type    = "A"
  ttl     = 86400
  proxied = true
}

resource "cloudflare_record" "www_test_lv" {
  zone_id = cloudflare_zone.test_lv.zone
  name    = "www.${module.dmitrijsv.environment}"
  value   = local.mikakosha
  type    = "A"
  ttl     = 86400
  proxied = true
}

resource "cloudflare_record" "mx_test_lv" {
  zone_id = cloudflare_zone.test_lv.zone
  name    = module.dmitrijsv.environment
  value   = "mail.kid.lv"
  type    = "MX"
  ttl     = 86400
}