module "ennoiart" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.15.0"
  namespace   = "ennoiart"
  environment = "ennoiart.com"
}

resource "cloudflare_zone" "ennoiart_com" {
  zone = "ennoiart.com"
  plan = "free"
  type = "full"
}

resource "cloudflare_record" "ennoiart_com" {
  zone_id = cloudflare_zone.ennoiart_com.zone
  name    = module.ennoiart.environment
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
  ttl     = 86400
}

resource "cloudflare_record" "www_ennoiart_com" {
  zone_id = cloudflare_zone.ennoiart_com.zone
  name    = "www.${module.ennoiart.environment}"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
  ttl     = 86400
}