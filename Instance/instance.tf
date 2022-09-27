resource "aws_instance" "bastion-instance" {
  ami           = var.ubuntu-ami
  instance_type = "t2.micro"

  subnet_id = var.public_subnet_id 

  vpc_security_group_ids = [var.bastion_sg] 

  key_name = var.key_name 

  tags = {
    "Name"     = "bastion-instance"
    "Project"  = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_instance" "private-instance" {
  count         = var.instance_count
  ami           = var.instance-ami 
  instance_type = "t2.micro"

  subnet_id = var.private_subnet_id[count.index]

  vpc_security_group_ids = ["${var.instance-sg}", "${var.bastion_sg}"] 

  key_name = var.key_name 

  tags = {
    "Name"     = "nginx-instance"
    "Project"  = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_lb_target_group_attachment" "mtc_target_attach" {
  count            = var.instance_count
  target_group_arn = var.lb_target_group_arn
  target_id        = aws_instance.private-instance[count.index].id
  port             = 80
}