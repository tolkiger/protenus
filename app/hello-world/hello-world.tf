
module "hello-world" {
  source = "../../modules/ecs_fargate"

  ecs_cluster_name = local.full_ecs_name
  lb_hc_path            = var.lb_hc_path
  lb_internal           = var.lb_internal
  lb_s3_log_bucket_name = "protenus-access-log-bucket"
  lb_ssl_cert                = var.lb_ssl_cert
  lb_subnets                 = ["172.19.2.0/24"]
  lb_tg_deregistration_delay = var.lb_tg_deregistration_delay
  vpc_id   = module.hello-world.vpc_id
  vpc_name = var.vpc_name

  aws_region  = var.aws_region
  environment = var.environment
  stage       = var.stage

  app_name                   = var.app_name
  asg_max_capacity           = var.asg_max_capacity
  asg_min_capacity           = var.asg_min_capacity
  container_definition       = module.container_definition.json
  container_port             = var.container_port
  deployment_maximum_percent = var.deployment_maximum_percent
  deployment_minimim_percent = var.deployment_minimim_percent
  ecs_container_image        = var.ecs_container_image
  ecs_cpu                    = var.ecs_cpu
  ecs_desired_count          = var.ecs_desired_count
  ecs_memory                 = var.ecs_memory
  host_port                  = var.host_port
  route53_alias_name         = [var.route53_name]
  route53_name               = [var.route53_name]

  group_tag = var.group_tag
  role_tag  = var.role_tag
  team_tag  = var.team_tag
}

module "container_definition" {
  source = "../../modules/ecs_container_definition"

  container_cpu    = var.container_cpu
  container_image  = var.ecs_container_image
  container_memory = var.container_memory
  container_name   = "hello-world"

  log_options = {
    awslogs-group         = module.hello-world.cw_log_group
    awslogs-region        = var.aws_region
    awslogs-stream-prefix = "hello-world-test"
  }

  environment = [
    {
      name  = "stage"
      value = var.stage
    },
    {
      name  = "DEPLOYMENT_ENVIRONMENT"
      value = var.stage
    },
  ]

  port_mappings = [
    {
      containerPort = var.container_port
      hostPort      = var.host_port
      protocol      = var.protocol
    },
  ]
}

module "images_pipeline" {
  source = "../../modules/ecscodepipeline"

  aws_region = var.aws_region
  vpc_name   = var.vpc_name

  deploy_approval_enabled      = 1
  build_name                   = "${var.app_name}-cb"
  build_timeout                = var.build_timeout
  build_compute_type           = var.build_compute_type
  build_image                  = var.build_image
  build_environment_type       = var.environment_type
  build_environment_privileged = true
  build_vpc_id                 = module.hello-world.vpc_id
  build_subnets                = module.hello-world.subnet_group
  build_security_groups = [
    module.hello-world.sec_group
  ]

  pipeline_name       = "${var.app_name}-cp"
  ecs_cluster_name    = local.full_ecs_name
  ecs_container_name  = var.app_name
  ecs_service_name    = "${var.app_name}-ecs"
  s3_artifact_kms_key = "arn:aws:kms:${var.aws_region}:${data.aws_caller_identity.current.account_id}:alias/aws/s3"
  source_owner        = data.aws_caller_identity.current.account_id
  source_repo         = var.source_repo
  source_branch       = var.source_branch
}
