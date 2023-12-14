resource "aws_key_pair" "k8s_cluster_key" {
    key_name = var.key_pair_name
    public_key = "${file(var.public_key_path)}"
    tags = {
        Name        = "k8s-key"
        Environment = "test"
        Terraform   = "true"
    }
}