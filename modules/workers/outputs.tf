output "workers_public_ips" {
    value = aws_instance.workers.*.public_ip
}