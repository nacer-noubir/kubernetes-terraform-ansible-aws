resource "aws_instance" "workers" {
  ami             = var.default_ami_id
  count           = var.worker_count
  instance_type   = var.instance_type
  key_name        = "nacerkey"
  security_groups = [ var.security_group_id ]
  subnet_id       = data.aws_subnets.default_subnets.ids[0]

  associate_public_ip_address = true

  tags = {
    Name = "worker_${count.index}"
    terraform = "true"
    project = "kube-auto"
  }

  root_block_device {
    delete_on_termination = true
    volume_size = 8
  }
}