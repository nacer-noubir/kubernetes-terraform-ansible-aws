resource "aws_security_group" "allow_tls_http_ssh" {
  name        = "k8s-sg-blog"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

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

resource "aws_instance" "controller" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [ aws_security_group.allow_tls_http_ssh.id ]
  subnet_id = var.subnet_id
  associate_public_ip_address = true


  tags = {
    terraform = "true"
    project = "kube-auto"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file(var.private_key_path)}"
    host = "${self.public_ip}"
  }

  provisioner "file" {
    source      = "./ansible/playbook.yaml"
    destination = "/home/ubuntu/playbook.yaml"
  }

  provisioner "file" {
    source      = "./ansible/install.sh"
    destination = "/home/ubuntu/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /home/ubuntu/install.sh",
        "/home/ubuntu/install.sh"
    ]
  }
  root_block_device {
    delete_on_termination = true
    volume_size = 8
  }
}