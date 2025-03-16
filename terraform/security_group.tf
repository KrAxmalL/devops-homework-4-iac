locals {
  security_group_name = "devops-homework-4-security-group"
}

resource "aws_security_group" "server_security_group" {
  name = local.security_group_name
  tags = {
    Name = local.security_group_name
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_output_traffic" {
  security_group_id = aws_security_group.server_security_group.id
  ip_protocol       = "-1" # Allow all protocols, IPs and ports
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tcp_input_traffic_for_ssh_port_IPv4" {
  security_group_id = aws_security_group.server_security_group.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
}

# 'count' is used to create this rule for every server IP
resource "aws_vpc_security_group_ingress_rule" "allow_tcp_input_traffic_for_server_IPv4" {
  count             = local.server_amount
  security_group_id = aws_security_group.server_security_group.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "${aws_instance.server[count.index].public_ip}/32"
  from_port         = 5432
  to_port           = 5433
}