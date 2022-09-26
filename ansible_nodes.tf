resource "aws_instance" "ansible_nodes" {
  count                  = var.ansible_node_count
  instance_type          = var.instance_type
  key_name               = var.key_name
  ami                    = var.aws_ami # default: ami-08c40ec9ead489470 Ubuntu ami
  vpc_security_group_ids = [aws_security_group.ansible_access.id]
  user_data              = file("userdata-ansible-nodes.sh")

  tags = {
    "project" = "ansible_nodes ${count.index}"
  }
}