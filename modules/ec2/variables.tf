variable "allowed_cidr" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
}

variable "subnet_id" {
  default = "subnet-09ff62dd2fb642629"
}

variable "vpc_id" {
  default = "vpc-03641f1a92228b77f"
}

variable "private_key_path" {
  default = "/home/ec2-user/.ssh/id_rsa"
}

variable "instance_type" {
    default = "t2.medium"
}
variable "ami" {
    type = string
    default = "ami-0c03e02984f6a0b41"
}