resource "aws_security_group" "public-sg" {
  vpc_id      = aws_vpc.main.id
  name        = "public-sg"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress = {
    ssh = {
        description = "SSH"
        from        = 22
        to          = 22
        protocol    = "tcp"
        cidr_blocks = [var.access_ip]
    }
    http = {
        description = "HTTP"
        from        = 80
        to          = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  } 
  tags = {
    "Name" = "bastion connection"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_security_group" "bastion-sg" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "bastion connection"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_security_group" "instance-sg" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [ "${aws_security_group.bastion-sg.id}" ]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [ "${aws_security_group.loadBalancer-sg.id}" ]
  }

  tags = {
    "Name" = "bastion connection"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}