variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "key_name" {
  description = "instance key name"
  default     = "loginkey"
}

variable "aws_ami" {
  default = "ami-08c40ec9ead489470" # ubuntu ami
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ansible_node_count" {
  description = "number of the managed nodes"
  default     = 2
}

