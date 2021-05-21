terraform {
  required_version = ">= 0.12"
  backend "local" {
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {
}

locals {
  full_ecs_name = "prod-${var.aws_region}-${var.cluster_name}-ecs"
}

