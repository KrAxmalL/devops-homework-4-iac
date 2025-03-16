data "template_file" "ansible_vars_template" {
  template = file("./templates/vars_template.tpl")
  vars = {
    pssql_master_address = aws_instance.server[local.master_index].public_ip
    pssql_replica_address = aws_instance.server[local.replica_index].public_ip
  }
}

resource "local_file" "ansible_vars" {
  content  = data.template_file.ansible_vars_template.rendered
  filename = "../ansible/vars/main.yml"
}