locals {
  ami_id               = "ami-03fd334507439f4d1" # Free tier eligible Ubuntu Server 24.04 LTS
  instance_type        = "t2.micro"
  instance_name_prefix = "devops-homework-4-pssql"
  instance_roles = ["master", "replica"]
  volume_size          = 8
  volume_type          = "gp3"
}

resource "aws_instance" "server" {
  count         = local.server_amount
  ami           = local.ami_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.root_aws_keypair.key_name # Root keypair - used to add other public keys to the server
  vpc_security_group_ids = [
    aws_security_group.server_security_group.id
  ]
  tags = {
    Name = "${local.instance_name_prefix}-${local.instance_roles[count.index]}" # Name in the EC2 Dashboard
  }

  # Free tier eligible Storage
  root_block_device {
    volume_size = local.volume_size
    volume_type = local.volume_type
  }

  # Add public keys to the server for SSH access
  provisioner "remote-exec" {
    inline = [
      "sudo -u ubuntu bash -c 'echo \"${data.local_file.my_public_key.content}\" >> ~/.ssh/authorized_keys'",
      "sudo -u ubuntu bash -c 'echo \"${data.local_file.teacher_public_key.content}\" >> ~/.ssh/authorized_keys'"
    ]

    connection {
      type        = "ssh"
      host        = self.public_dns
      port        = 22
      user        = "ubuntu"
      private_key = tls_private_key.root_generated_keypair.private_key_pem
    }
  }
}