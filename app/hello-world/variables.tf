variable "aws_region" {
  description = "Deploy to this AWS region"
}

variable "environment" {
  description = "The name of the environment that the cluster is launched in"
}

variable "cluster_name" {
  description = "Cluster's name"
}

variable "stage" {
  description = "Environment Name: dev/test/prod"
}

variable "app_name" {
  description = "The name of the app"
}

variable "asg_min_capacity" {
  description = "AutoScaling Group Min Capacity"
}

variable "asg_max_capacity" {
  description = "AutoScaling Group Max Capacity"
}

variable "build_compute_type" {
  description = "CodeBuild Compute Type"
}

variable "build_image" {
  description = "CodeBuild Docker Image to use"
}

variable "build_timeout" {
  description = "Build timeout in minutes"
}

variable "environment_type" {
  description = "CodeBuild Environment type"
}

variable "ecs_container_image" {
  description = "The Docker image to run"
}

variable "source_repo" {description = "Repo to use for CodePipeline Source stage"}

variable "source_branch" {description = "Branch name to trigger pipeline"}

variable "lb_hc_path" {
  description = "ALB HealthCheck Path"
}

variable "lb_internal" {
  description = "Defines ALB internal or public"
}

variable "lb_tg_deregistration_delay" {
  description = "Target Group Deregistration Delay"
}

variable "lb_ssl_cert" {
}

variable "route53_name" {
  type = string
}

variable "group_tag" {
}

variable "role_tag" {
}

variable "team_tag" {
}

variable "host_port" {}

variable "container_port" {}

variable "ecs_memory" {}

variable "ecs_cpu" {}

variable "deployment_maximum_percent" {}

variable "deployment_minimim_percent" {
  default = 50
}

variable "ecs_desired_count" {
  default = 2
}
variable "protocol" {}
variable "container_memory" {}
variable "container_cpu" {}
variable "vpc_name" {}