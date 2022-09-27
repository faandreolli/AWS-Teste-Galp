output "instanceBastion" { 

  value     = aws_instance.bastion-instance[*] 
  sensitive = true
}

output "instancePrivate" { 

  value     = aws_instance.private-instance[*] 
  sensitive = true
}


output "instance_port" {
  value = aws_lb_target_group_attachment.mtc_target_attach[0].port
}

