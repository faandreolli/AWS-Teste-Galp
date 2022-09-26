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
  type= string
  default = "ami-08c40ec9ead489470"
}

variable "instance_count" {
  type = number
}

variable "cidr_block" {
  type = string
}

variable "public_Network_CID" {
  type = string
}

variable "private_Network_CID" {
  type = string
}