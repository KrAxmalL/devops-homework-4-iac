resource "tls_private_key" "root_generated_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key to local machine
resource "local_sensitive_file" "root_private_key_file" {
  filename             = "../keys/private/devops-homework-4-root-keypair.pem"
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.root_generated_keypair.private_key_pem
}

resource "aws_key_pair" "root_aws_keypair" {
  key_name   = "devops-homework-4-root-keypair"
  public_key = tls_private_key.root_generated_keypair.public_key_openssh
}