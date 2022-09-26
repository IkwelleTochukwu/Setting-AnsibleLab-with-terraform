output "ansible_control_public_ip" {
  value = aws_instance.ansible_control.public_ip
}

output "ansible_node-1_public_ip" {
  value = aws_instance.ansible_nodes[0].public_ip
}

output "ansible_node-2_public_ip" {
  value = aws_instance.ansible_nodes[1].public_ip
}