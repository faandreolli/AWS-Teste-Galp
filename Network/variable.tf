variable "region" {
  default = "eu-east-1"
}

variable "project" {
  type    = string
  default = "Galp"
}

variable "CreateBy" {
  type    = string
  default = "Terraform"
}

variable "ubuntu-ami" {
  type    = string
  default = "ami-08c40ec9ead489470"
}

#variable "instance_count" {
#  type = number
#}

variable "cidr_block" {
  type = string
}

variable "public_Network_CID" {
  type = list(any)
}

variable "private_Network_CID" {
  type = list(any)
}

variable "public_sn_count" {
  type = number
}

variable "private_sn_count" {
  type = number
}

variable "max_subnets" {
  type = number
}

#variable "security_groups" {}

variable "aws_lb_name" {
  type = string
}

variable "load_balancer_type" {
  type = string
}

#variable "bastion_lb_sg" {
#  type = string
#}

#variable "instance-lb-sg" {
#  type = string
#}

#variable "lb_subnets" {}

#variable "tg_port" {
#  type = number
#}
#
#variable "tg_protocol" {
#  type = string
#}

#variable "vpc_id" {
#  type = string
#}