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
/*

resource "cloudflare_record" "ennoiart_com" {
  zone_id = cloudflare_zone.ennoiart_com.id
  name    = "@"
  type    = "A"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www_ennoiart_com" {
  zone_id = cloudflare_zone.ennoiart_com.id
  name    = "www"
  type    = "A"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  ttl     = 1
  proxied = true
}
*/

output "ennoiart_com" {
  value = cloudflare_zone.ennoiart_com.name_servers
}