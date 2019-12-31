provider "aws" {
}

module "label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace   = "devopscare"
  environment = "add"
  name        = "wordpress"
}

module "label_ip" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  context    = module.label.context
  attributes = ["static_ip"]
}