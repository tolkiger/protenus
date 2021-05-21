resource "aws_ecs_cluster" "app" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "app_task" {
  family = local.full_app_name
  container_definitions = var.container_definition
  requires_compatibilities = ["FARGATE"]
  network_mode = var.ecs_network_mode
  cpu = var.ecs_cpu
  memory = var.ecs_memory
  execution_role_arn = aws_iam_role.ecs_task_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn
}

resource "aws_ecs_service" "app" {
  name = local.full_ecs_name
  cluster = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count = var.ecs_desired_count
  launch_type = "FARGATE"
  depends_on = [aws_iam_role_policy.ecs_service_role_policy, aws_lb_target_group.web_http]
  deployment_minimum_healthy_percent = var.deployment_minimim_percent
  deployment_maximum_percent = var.deployment_maximum_percent

  lifecycle {
    ignore_changes = [task_definition]
  }

  network_configuration {
    security_groups = [aws_security_group.sec_group.id]
    subnets = [aws_subnet.main_1.id,aws_subnet.main_2.id,aws_subnet.main_3.id,]
//    assign_public_ip = False
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.web_http.*.arn[0]
    container_name = local.full_app_name
    container_port = var.container_port
  }
}
