terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
    profile = var.profile
    region = var.region
}

module "ec2-create" {
    source = "./modules/ec2"
}