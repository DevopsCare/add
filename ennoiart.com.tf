module "ennoiart" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
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
  proxied = true
}

resource "cloudflare_record" "www_ennoiart_com" {
  zone_id = cloudflare_zone.ennoiart_com.zone
  name    = "www.${module.ennoiart.environment}"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
  proxied = true
}

output "ennoiart_com" {
  value = cloudflare_zone.ennoiart_com.name_servers
}