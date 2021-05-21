resource "aws_codebuild_project" "build" {
  name = var.build_name
  build_timeout = var.build_timeout
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = var.build_compute_type
    image = var.build_image
    type = var.build_environment_type
    privileged_mode = var.build_environment_privileged

    environment_variable {
      name = "BUILD_BRANCH"
      value = var.source_branch
    }

    environment_variable {
      name = "CONTAINER_NAME"
      value = var.ecs_container_name
    }

    environment_variable {
      name = "VPC_NAME"
      value = var.vpc_name
    }
  }

  source {
    type = "CODEPIPELINE"
  }

  vpc_config {
    vpc_id = var.build_vpc_id
    subnets = var.build_subnets
    security_group_ids = var.build_security_groups
  }
}
