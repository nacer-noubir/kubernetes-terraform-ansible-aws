resource "aws_instance" "controller" {
  ami           = var.default_ami_id
  instance_type = var.instance_type
  key_name = var.key_pair_name
  security_groups = [ var.security_group_id ]
  subnet_id = data.aws_subnets.default_subnets.ids[0]

  associate_public_ip_address = true

  tags = {
    terraform = "true"
    project = "kube-auto"
  }

  root_block_device {
    delete_on_termination = true
    volume_size = 8
  }
}