output "vpc_id" {
  value = aws_vpc.vpc.id
}


output "bastion-sg" {

  value = aws_security_group.bastion-sg["public"].id

}

output "public_subnet_group" {

  value = aws_subnet.public-subnet.*.id

}

output "bastion_subnet_group" {

  value = aws_subnet.public-subnet[0].id

}

output "private_subnet_group" {

  value = aws_subnet.private-subnet.*.id

}

output "aws_lb_target_group_arn" {
  value = aws_lb_target_group.mtc_tg.arn

}

output "lb_endpoint" {
  value = aws_lb.mtc_lb.dns_name
}