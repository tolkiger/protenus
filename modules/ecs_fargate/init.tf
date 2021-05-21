locals {
  full_app_name = "${var.vpc_name}-${var.app_name}"
  full_ecs_name = "${var.vpc_name}-${var.app_name}-ecs"
  full_alb_name = "${var.vpc_name}-${var.app_name}-alb"
}
