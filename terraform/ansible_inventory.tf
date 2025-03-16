data "template_file" "ansible_inventory_template" {
  template = file("./templates/hosts_template.tpl")
  vars = {
    pssql_master_address = aws_instance.server[local.master_index].public_ip
    pssql_replica_address = aws_instance.server[local.replica_index].public_ip
  }
}

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory_template.rendered
  filename = "../ansible/inventory/hosts.ini"
}