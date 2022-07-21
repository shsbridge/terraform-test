resource "aws_launch_configuration" "webcluster" {
  image_id = data.aws_ami.ubuntu.id
  key_name = var.dev_key
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, world!" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "dev_asg" {
  launch_configuration = aws_launch_configuration.webcluster.name
  vpc_zone_identifier = [data.terraform_remote_state.vpc.outputs.subnet_id_mdw_dev1,data.terraform_remote_state.vpc.outputs.subnet_id_mdw_dev2]

  target_group_arns = [aws_lb_target_group.dev_asg_tg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 3

  tag {
    key = "Name"
    value = "terraform-dev-asg"
    propagate_at_launch = true
  }
}

resource "aws_lb" "dev_alb" {
  name = "dev-asg-alb"
  internal = true
  load_balancer_type = "application"
  subnets = [data.terraform_remote_state.vpc.outputs.subnet_id_mdw_dev1,data.terraform_remote_state.vpc.outputs.subnet_id_mdw_dev2]
  security_groups = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http_lsn" {
  load_balancer_arn = aws_lb.dev_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page not found"
      status_code = 404
    }
  }
}

resource "aws_lb_listener_rule" "http_lsn_rule" {
  listener_arn = aws_lb_listener.http_lsn.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.dev_asg_tg.arn
  }
}

resource "aws_lb_target_group" "dev_asg_tg" {
  name = "dev-asg-tg"
  port = var.server_port
  protocol = "HTTP"
  vpc_id = data.aws_vpc.dev_vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

