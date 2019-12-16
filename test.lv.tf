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
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
  ttl     = 86400
}

resource "cloudflare_record" "www_ennoiart_com" {
  zone_id = cloudflare_zone.test_lv.zone
  name    = "www.${module.dmitrijsv.environment}"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
  ttl     = 86400
}