data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.vpc.id]
  }

  depends_on = [
    aws_vpc.vpc,
    aws_subnet.private-subnet,
    aws_subnet.public-subnet
  ]
}

resource "aws_lb" "lb" {
  name               = var.aws_lb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.public-sg.id, aws_security_group.bastion-sg.id, aws_security_group.instance-sg.id]
  subnets            =  data.aws_subnets.subnets.ids
 
  idle_timeout       = 400
  tags = {
    "Name"     = "LoadBalancer"
    "Project"  = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }

 

}

resource "aws_lb_target_group" "lb_tg" {
  name     = "galp-teste"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {

    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 3

  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}