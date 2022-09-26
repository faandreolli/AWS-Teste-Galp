variable "aws_region" {
  type = string
}

######### Network #########
variable "max_subnets" {
  type = number
}

variable "private_sn_count" {
  type = number
}

variable "public_sn_count" {
  type = number
}

variable "load_balancer_type" {
  type = string
}

variable "aws_lb_name" {
  type = string
}
######### Instance #########

variable "ubuntu-ami" {
  type = string
}
