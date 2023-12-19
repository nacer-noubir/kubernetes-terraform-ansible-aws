variable "allowed_cidr" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
}

data "aws_vpc" "default_vpc"{
  default = true
}