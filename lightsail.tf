resource "aws_lightsail_key_pair" "pveretennikovs" {
  name       = "PVeretennikovs"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAqr5YHPYgJJwHRfw1+ySMoees2KAj4o3JCSc66PR1p8iZaAMAKNn7Z5XP03KLiu0UKZx8ceLWMY+fy7kE5pEVAjhqHxwBUjbdj32gDbTqX059dTF+UzTFZNxpZNA1nU9p5f4YqJeLrxLL0I7P/LVYLTaFTQYDwMYRBLmk3X3kQFyRLF6bKHrTkW8dBQeHPxhCdqlupj3uLyBcTR2qBaQrfCPvYP+9Bu2QfgMA8ex9YHfAzM8mAsgn1OxPEXe2KRIZZYo0vS3vLBRm7mmscWv6jxsw/GJd/0awKUyh6Yfw9U5Jry3neH7vuO7L6rmpPn3r3sTlLtijMfCUGCzDO2Vr+w== PVeretennikovs@Deadpool"
}

resource "aws_lightsail_static_ip_attachment" "wordpress" {
  static_ip_name = aws_lightsail_static_ip.wordpress.name
  instance_name  = aws_lightsail_instance.wordpress.name
}

resource "aws_lightsail_static_ip" "wordpress" {
  name = module.label_ip.id
}

resource "aws_lightsail_instance" "wordpress" {
  name              = module.label.id
  availability_zone = "us-east-1a"
  blueprint_id      = "wordpress_multisite"
  bundle_id         = "nano_2_0"
  key_pair_name     = aws_lightsail_key_pair.pveretennikovs.name
  tags              = module.label.tags
}