resource "aws_instance" "bastion-instance" {
  ami           = var.ubuntu-ami
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public-subnet.id

  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  key_name = aws_key_pair.mykeypair.key_name

  tags = {
    "Name" = "bastion-instance"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_instance" "private-instance" {
  count = var.instance_count
  ami           = var.instance-ami
  instance_type = "t2.micro"

  subnet_id = aws_subnet.private-subnet.id

  vpc_security_group_ids = [aws_security_group.instance-sg.id,aws_security_group.allow-ssh.id]

  key_name = aws_key_pair.mykeypair.key_name
  
  tags = {
    "Name" = "nginx-instance"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}