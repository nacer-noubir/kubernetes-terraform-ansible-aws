output "eip" {
  value = ["$aws_instance.controller.*.public_ip"]
}