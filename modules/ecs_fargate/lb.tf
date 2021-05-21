resource "aws_lb_target_group" "web_http" {
  count = var.lb_enabled
  name = "${local.full_app_name}-tg"
  port = var.lb_tg_port
  protocol = var.lb_tg_protocol
  vpc_id = aws_vpc.main.id
  target_type = "ip"
  deregistration_delay = var.lb_tg_deregistration_delay

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    interval = var.lb_hc_interval
    path = "/${var.lb_hc_path}"
    port = var.lb_hc_port
    protocol = var.lb_hc_protocol
    timeout = var.lb_hc_timeout
    healthy_threshold = var.lb_hc_healthy_threshold
    unhealthy_threshold = var.lb_hc_unhealthy_threshold
    matcher = var.lb_hc_matcher
  }
}

resource "aws_lb" "web" {
  count = var.lb_enabled
  name = local.full_alb_name
  subnets = var.lb_subnets
  security_groups = [aws_security_group.sec_group_alb.id]

  internal = var.lb_internal

  access_logs {
    bucket = var.lb_s3_log_bucket_name
    prefix = "alb-logs/${local.full_alb_name}"
    enabled = true
  }

  tags = {
    Environment = var.environment
    Group = var.group_tag
    Role = var.role_tag
    Team = var.team_tag
  }
}

resource "aws_lb_listener" "web_https" {
  count = var.lb_enabled
  load_balancer_arn = aws_lb.web.*.id[count.index]
  port = 443
  protocol = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.lb_ssl_cert

  default_action {
    target_group_arn = aws_lb_target_group.web_http.*.id[count.index]
    type = "forward"
  }
}
