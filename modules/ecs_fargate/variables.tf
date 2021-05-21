variable "aws_region" {}
variable "environment" { description = "The name of the environment that the app is launched in" }
variable "vpc_id" { description = "The id of the VPC the app is launched in" }
variable "vpc_name" { description = "The name of the VPC the app is launched in" }
variable "app_name" { description = "The name of the app" }

variable "ecs_cluster_name" {description = "ECS Cluster Name"}
variable "ecs_container_image" { description = "The Docker image to run" }
variable "stage" {description = "Environment: dev/test/prod"}
variable "group_tag" {description = "Value for Tag named group"}
variable "role_tag" {description = "Value for Tag named group"}
variable "team_tag" {description = "Value for Tag named group"}

variable "lb_internal" {description = "Defines if ALB is internal or public"}
variable "lb_s3_log_bucket_name" {
  type = string
  description = "S3 bucket name for load balancer access logs"
}
variable "lb_ssl_cert" {description = "ALB ACM certificate ARN"}

variable "lb_enabled" {
  description = "ALB Target Group Count"
  default = "1"
}

variable "lb_tg_port" {
  description = "ALB Target Group Port"
  default = 80
}

variable "lb_tg_protocol" {
  description = "Target group protocol to use"
  default = "HTTP"
}

variable "lb_tg_deregistration_delay" {
  description = "ALB target deregistration delay"
  default = "300"
}

variable "lb_hc_interval" {
  description = "HealthCheck Interval"
  default = 10
}
variable "lb_hc_path" {
  description = "ALB HealthCheck Path"
  default = "Healthz"
}
variable "lb_hc_port" {
  description = "ALB HealthCheck Port"
  default = "traffic-port"
}

variable "lb_hc_protocol" {
  default = "HTTP"
  description = "ALB HealCheck Protocol. Default = HTTP"
}

variable "lb_hc_timeout" {
  description = "HealthCheck Timeout"
  default = 3
}

variable "lb_hc_healthy_threshold" {
  description = "HealthCheck Healthy Threshold"
  default = 2
}

variable "lb_hc_unhealthy_threshold" {
  description = "HealthCheck UnHealthy Threshold"
  default = 2
}

variable "lb_hc_matcher" {
  description = "HealthCheck Matcher"
  default = "200"
}

variable "route53_name" {
  description = "A Record Name List"
  type = list(string)
}

variable "route53_alias_name" {
  description = "A Record Alias Name List"
  type = list(string)
}

variable "asg_min_capacity" {
  description = "AutoScaling Group Minimum Capacity"
  default = "2"
}

variable "asg_max_capacity" {
  description = "AutoScaling Group Maximum Capacity"
  default = "4"
}

variable "lb_subnets" {
  type = list(string)
  description = "The subnets available to the app load balancer"
}

variable "host_port" {
  default = "80"
  description = "Host Port"
}

variable "container_port" {
  default = 80
  description = "Container Port"
}
variable "ecs_network_mode" {
  description = "ECS Network mode"
  default = "awsvpc"
}

variable "ecs_memory" {
  default = "512"
  description = "Task RAM Memory"
}

variable "ecs_cpu" {
  default = "256"
  description = "Task CPU"
}

variable "deployment_maximum_percent" {
  description = "ECS Service Deployment Max Percent"
  default = "100"
}

variable "deployment_minimim_percent" {
  description = "ECS Service Deployment Min Percent"
  default = "50"
}

variable "ecs_desired_count" {
  description = "ECS Task desired Count"
  default = "2"
}
variable "container_definition" {description = "The Container Definition to use for the Task Definition"}
