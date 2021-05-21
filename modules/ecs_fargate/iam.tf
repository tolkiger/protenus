resource "aws_iam_role" "ecs_autoscale_role" {
  name = "${local.full_ecs_name}-autoscale"
  assume_role_policy = data.aws_iam_policy_document.ecs_autoscale_role.json
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${local.full_ecs_name}-task"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_role.json
}

resource "aws_iam_role" "ecs_role" {
  name = "${local.full_ecs_name}-ecs"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json
}

resource "aws_iam_role_policy" "ecs_autoscale_role_policy" {
  name = "${local.full_ecs_name}-autoscale"
  policy = data.aws_iam_policy_document.ecs_autoscale_role_policy.json
  role = aws_iam_role.ecs_autoscale_role.id
}

resource "aws_iam_role_policy" "ecs_task_role_policy" {
  name = "${local.full_ecs_name}-task"
  policy = data.aws_iam_policy_document.ecs_task_role_policy.json
  role = aws_iam_role.ecs_task_role.id
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name = "${local.full_ecs_name}-service"
  policy = data.aws_iam_policy_document.ecs_service_policy.json
  role = aws_iam_role.ecs_role.id
}
