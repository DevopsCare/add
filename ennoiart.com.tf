module "ennoiart" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.15.0"
  namespace = "ennoiart"
}

resource "aws_route53_zone" "ennoiart_com" {
  name = "ennoiart.com"
  tags = module.ennoiart.tags
}

resource "aws_route53_record" "ennoiart_com" {
  zone_id = aws_route53_zone.ennoiart_com.id
  name    = aws_route53_zone.ennoiart_com.name
  type    = "A"
  ttl     = "86400"

  records = [aws_lightsail_static_ip.wordpress.ip_address]
}

resource "aws_route53_record" "www_ennoiart_com" {
  zone_id = aws_route53_zone.ennoiart_com.id
  name    = "www.${aws_route53_zone.ennoiart_com.name}"
  type    = "A"
  ttl     = "86400"

  records = [aws_lightsail_static_ip.wordpress.ip_address]
}