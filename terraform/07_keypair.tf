# resource "aws_key_pair" "production" {
#   key_name   = "${var.ecs_cluster_name}_key_pair"
#   public_key = file(var.ssh_pubkey_file)
# }

resource "aws_key_pair" "telecom_key_pair" {
  key_name   = "telecom_key_pair"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "telecom_key_pair" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "telecom_key_pair"
}