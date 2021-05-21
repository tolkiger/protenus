resource "aws_cloudwatch_log_group" "app" {
  name = local.full_ecs_name

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "app_log" {
  name = "${local.full_app_name}-app"

  tags = {
    Environment = var.environment
  }
}
