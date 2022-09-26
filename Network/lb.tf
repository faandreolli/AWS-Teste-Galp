resource "aws_lb" "lb" {
  name               = var.aws_lb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.bastion_lb_sg, var.instance-lb-sg]
  subnets            = [aws_subnet.private-subnet.*.id, aws_subnet.public-subnet.*.id]
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
  protocol = "http"
  vpc_id   = aws_vpc.vpc

  # lifecycle {
  #   ignore_changes = [name] # This will not let change the target group with
  #   # new uuid number and structure will remain intact.
  #   create_before_destroy = true
  # }

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