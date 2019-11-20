provider "aws" {
}

module "label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.15.0"
  namespace   = "devopscare"
  environment = "add"
  name        = "wordpress"
}