resource "aws_instance" "bastion-instance" {
  ami           = var.ubuntu-ami
  instance_type = "t2.micro"

  subnet_id = var.public_subnet_id #[count.index]   #aws_subnet.public-subnet.id

  vpc_security_group_ids = [var.bastion_sg] #aws_security_group.allow-ssh.id

  key_name = var.key_name #aws_key_pair.key_name.key_name

  tags = {
    "Name"     = "bastion-instance"
    "Project"  = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_instance" "private-instance" {
  count         = local.count_instance
  ami           = var.instance-ami # colocar packer ip
  instance_type = "t2.micro"

  subnet_id = aws_subnet.private-subnet.id

  vpc_security_group_ids = [var.instance-sg, var.bastion_sg] #[aws_security_group.instance-sg.id,
  #aws_security_group.allow-ssh.id]

  key_name = var.key_name #aws_key_pair.key_name.key_name

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
  port             = var.tg_port
}