output "vpc_id" {
  value = aws_vpc.vpc.id
}


output "bastion-sg" {

  value = aws_security_group.bastion-sg["public"].id

}

output "public_subnet_group" {

  value = aws_subnet.public-subnet.*.id

}


output "private_subnet_group" {

  value = aws_subnet.private-subnet.*.id

}