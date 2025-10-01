// Application Load Balancer
resource "aws_lb" "alb" {
  name               = "${var.prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [data.terraform_remote_state.sg.outputs.http_sg_id,
  data.terraform_remote_state.sg.outputs.https_sg_id]

  subnets = [data.terraform_remote_state.vpc.outputs.public01_id,
  data.terraform_remote_state.vpc.outputs.public02_id]
  enable_deletion_protection = false

  tags = {
    Name = "${var.prefix}-alb"
  }
}
// 리스너 규칙
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

// 대상 그룹
resource "aws_lb_target_group" "app_tg" {
  name     = "${var.prefix}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.prefix}-app-tg"
  }
}
