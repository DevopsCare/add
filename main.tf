provider "aws" {
  region = "us-east-1"
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

/*
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "devopslv"

    workspaces {
      name = "devopscare_add"
    }
  }
}*/
