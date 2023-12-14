variable "profile" {}

variable "region" {
  type        = string
  description = "AWS Infra Region"
  default     = "eu-west-3"
}

variable "worker_count" {
  type    = string
  default = "1"
}

variable "public_key_path" {
  default = "/home/ec2-user/.ssh/id_rsa.pub"
}

variable "key_pair_name" {
  default = "cluster_key"
}

data "aws_ami" "default_ami" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}