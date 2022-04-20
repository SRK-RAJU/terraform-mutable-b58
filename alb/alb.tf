resource "aws_lb" "internal" {
  name               = "backend-${var.env}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal-lb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Environment = "backend-${var.env}"
  }
}

resource "aws_lb" "public" {
  name               = "public-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public-lb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS

  tags = {
    Environment = "internal-${var.env}"
  }
}

resource "aws_lb_listener" "internal" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }
}
