variable region {
    default="eu-east-1"
}

variable "project" {
  type = string
  default = "Galp"
}

variable "CreateBy" {
  type = string
  default = "Terraform"
}

variable "ubuntu-ami" {
  type = string
  default = "ami-08c40ec9ead489470"
}

variable "public_subnet_id" {
  type = string 
}

variable "bastion_sg" {
  type = string
}

variable "instance-sg" {
  type = string
}

variable "mykeypair" {
  type = string
}
