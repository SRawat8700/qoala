resource "aws_security_group" "alb_sg" {
  name        = "example-alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "example_alb" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public[0].id, aws_subnet.public[1].id]  # Include subnets from different Availability Zones# Include subnets from different Availability Zones

  tags = {
    Name = "example-alb"
  }
}

resource "aws_lb_target_group" "example_target_group" {
  name     = "example-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.example_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "example_attachment" {
  target_group_arn = aws_lb_target_group.example_target_group.arn
  target_id        = aws_instance.example.id
  port             = 80
}
