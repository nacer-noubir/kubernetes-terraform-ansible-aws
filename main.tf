module "sg-create" {
  source = "./modules/security_group"
}

module "key-pair-create" {
  source = "./modules/ssh_key_pair"
  key_pair_name = var.key_pair_name
  public_key_path = var.public_key_path
}

module "controller" {
    source = "./modules/controller"
    default_ami_id = data.aws_ami.default_ami.id
    security_group_id = module.sg-create.sg_id
    key_pair_name = var.key_pair_name
}

module "workers" {
    source = "./modules/workers"
    security_group_id = module.sg-create.sg_id
    default_ami_id = data.aws_ami.default_ami.id
    worker_count = var.worker_count
    key_pair_name = var.key_pair_name
}

resource "local_file" "ansible-inventory" {
  depends_on = [
    module.controller,
    module.workers
  ]
    content = templatefile(
      "hosts.ini",
      {
        workers = module.workers.workers_public_ips
        master  = module.controller.controller_public_ip
      })
      filename = "ansible_inventory.ini"
}