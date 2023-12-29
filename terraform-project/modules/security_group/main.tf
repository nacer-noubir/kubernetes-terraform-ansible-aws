resource "aws_security_group" "allow_tls_http_ssh" {
  name        = "k8s-sg-blog"
  description = "Allow all inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress = [
    {
      description      = "TLS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = var.allowed_cidr
      ipv6_cidr_blocks = [ "::/0" ]
      self = false
      security_groups = []
      prefix_list_ids = []
    },
    {
      description      = "TLS"
      from_port        = 6443
      to_port          = 6443
      protocol         = "tcp"
      cidr_blocks      = var.allowed_cidr
      ipv6_cidr_blocks = [ "::/0" ]
      self = false
      security_groups = []
      prefix_list_ids = []
    },
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = var.allowed_cidr
      ipv6_cidr_blocks = [ "::/0" ]
      self = false
      security_groups = []
      prefix_list_ids = []
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = var.allowed_cidr
      ipv6_cidr_blocks = [ "::/0" ]
      self = false
      security_groups = []
      prefix_list_ids = []
    }
  ]

  egress = [
    {
      description = "Allow All for Egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = [ "0.0.0.0/0" ]
      ipv6_cidr_blocks = [ "::/0" ]
      self = false
      security_groups = []
      prefix_list_ids = []
    }
  ]
  tags = {
      Name = "k8s-sg-blog"
      Environment = "test"
      Terraform = "true"
    }
}