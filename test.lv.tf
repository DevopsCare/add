module "dmitrijsv" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
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
  name    = "@"
  value   = local.mikakosha
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www_test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = "www"
  value   = local.mikakosha
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "new_test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = "new"
  value   = aws_lightsail_static_ip.wordpress.ip_address
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "ns1_cadmium_test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = "cadmium"
  value   = "ns-1382.awsdns-44.org"
  type    = "NS"
  ttl     = 86400
}

resource "cloudflare_record" "ns2_cadmium_test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = "cadmium"
  value   = "ns-15.awsdns-01.com"
  type    = "NS"
  ttl     = 86400
}

resource "cloudflare_record" "ns3_cadmium_test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = "cadmium"
  value   = "ns-1873.awsdns-42.co.uk"
  type    = "NS"
  ttl     = 86400
}

resource "cloudflare_record" "ns4_cadmium_test_lv" {
  zone_id = cloudflare_zone.test_lv.id
  name    = "cadmium"
  value   = "ns-521.awsdns-01.net"
  type    = "NS"
  ttl     = 86400
}
