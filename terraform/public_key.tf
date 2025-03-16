data "local_file" "my_public_key" {
  filename = "../keys/public/my_id_ed25519.pub"
}

data "local_file" "teacher_public_key" {
  filename = "../keys/public/teacher_id_ed25519.pub"
}