data "aws_iam_policy_document" "cloudwatch_event_policy" {
  count = var.deploy_approval_enabled == 0 ? 1 : 0

  statement {
    effect = "Allow"
    resources = aws_codepipeline.pipeline.*.arn
    actions = ["codepipeline:StartPipelineExecution"]
  }
}

data "aws_iam_policy_document" "cloudwatch_event_policy_approval" {
  count = var.deploy_approval_enabled

  statement {
    effect = "Allow"
    resources = aws_codepipeline.pipeline_approval.*.arn
    actions = ["codepipeline:StartPipelineExecution"]
  }
}

data "aws_iam_policy_document" "cloudwatch_event_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

//data "aws_kms_alias" "pandocxm_build_sm_key" {
//  name = "alias/${var.vpc_name}-pandocxm-build-sm-key"
//}
//
//data "aws_kms_alias" "pandohr_build_sm_key" {
//  name = "alias/${var.vpc_name}-pandohr-build-sm-key"
//}
//
//data "aws_kms_alias" "reputationpro_build_sm_key" {
//  name = "alias/${var.vpc_name}-reputationpro-build-sm-key"
//}
//
//data "aws_kms_alias" "pando_key" {
//  name = "alias/${var.vpc_name}-pando-key"
//}

data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    effect = "Allow"
    resources = ["*"]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:GetAuthorizationToken",
      "ecr:DescribeRepositories",
      "ecr:UploadLayerPart",
      "ecr:ListImages",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetRepositoryPolicy",
      "ecr:PutImage"
    ]
  }

  statement {
    effect = "Allow"
    resources = [
      "arn:aws:s3:::codepipeline-${var.aws_region}-*"
    ]

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:List*",
      "s3:PutObject"
    ]
  }

  statement {
    effect = "Allow"
    actions = ["secretsmanager:GetSecretValue"]
    resources = [
      "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:${var.vpc_name}-secret-name*",
    ]
  }

  statement {
    effect = "Allow"
    actions = ["kms:Decrypt"]
    resources = [
      "arn:aws:kms:${var.aws_region}:${data.aws_caller_identity.current.account_id}:key/12345678-1234-1234-123456789123"
    ]
  }

  statement {
    effect = "Allow"
    actions = ["ec2:CreateNetworkInterfacePermission"]
    resources = ["arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:network-interface/*"]
    condition {
      test = "StringEquals"
      variable = "ec2:Subnet"
      values = [
        "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:subnet/${var.build_subnets[0]}",
        "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:subnet/${var.build_subnets[1]}",
        "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:subnet/${var.build_subnets[2]}"
      ]
    }
    condition {
      test = "StringEquals"
      variable = "ec2:AuthorizedService"
      values = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codebuild_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"
    resources = [
      "arn:aws:s3:::codepipeline-${var.aws_region}-*"
    ]

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:List*",
      "s3:PutObject"
    ]
  }

  statement {
    effect = "Allow"
    resources = ["*"]
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:UploadArchive",
      "ecs:*",
      "events:DescribeRule",
      "events:DeleteRule",
      "events:ListRuleNamesByTarget",
      "events:ListTargetsByRule",
      "events:PutRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfiles",
      "iam:ListRoles",
      "logs:CreateLogGroup",
      "logs:DescribeLogGroups",
      "logs:FilterLogEvents"
    ]
  }

  statement {
    effect = "Allow"
    resources = ["*"]
    actions = ["iam:PassRole"]
    condition {
      test = "StringLike"
      variable = "iam:PassedToService"
      values = ["ecs-tasks.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    resources = ["arn:aws:iam::*:role/ecsInstanceRole*"]
    actions = ["iam:PassRole"]
    condition {
      test = "StringLike"
      variable = "iam:PassedToService"
      values = ["ec2.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    resources = ["arn:aws:iam::*:role/ecsAutoscaleRole*"]
    actions = ["iam:PassRole"]
    condition {
      test = "StringLike"
      variable = "iam:PassedToService"
      values = ["application-autoscaling.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    resources = ["*"]
    actions = ["iam:CreateServiceLinkedRole"]
    condition {
      test = "StringLike"
      variable = "iam:AWSServiceName"
      values = [
        "ecs.amazonaws.com",
        "spot.amazonaws.com",
        "spotfleet.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "codepipeline_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}
