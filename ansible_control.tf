resource "aws_instance" "ansible_control" {
  instance_type          = var.instance_type
  key_name               = var.key_name
  ami                    = var.aws_ami # default: ami-08c40ec9ead489470 Ubuntu ami
  vpc_security_group_ids = [aws_security_group.ansible_access.id]
  user_data              = file("userdata-ansible-control.sh")

  # create inventory and the ansible.cfg on the ansible-control
  provisioner "remote-exec" {
    inline = [
      "echo '[myself]' >> /home/ubuntu/inventory",
      "echo 'ansible-control ansible_host=${aws_instance.ansible_control.public_ip} ansible_connection=local' >> /home/ubuntu/inventory",
      "echo '[nodes]' >> /home/ubuntu/inventory",
      "echo 'node1 ansible_host=${aws_instance.ansible_nodes[0].public_ip}' >> /home/ubuntu/inventory",
      "echo 'node2 ansible_host=${aws_instance.ansible_nodes[1].public_ip}' >> /home/ubuntu/inventory",
      "echo ' ' >> /home/ubuntu/inventory",
      "echo '[all:vars]' >> /home/ubuntu/inventory",
      "echo 'ansible_user=root' >> /home/ubuntu/inventory",
      "echo 'ansible_connection=ssh' >> /home/ubuntu/inventory",
      "echo '[defaults]' >> /home/ubuntu/ansible.cfg",
      "echo 'inventory = ./inventory' >> /home/ubuntu/ansible.cfg",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("loginkey.pem")
      host        = self.public_ip
    }

  }

  tags = {
    "project" = "ansible_control"
  }
}