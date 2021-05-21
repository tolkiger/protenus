resource "aws_iam_role" "cloudwatch_event_role" {
  name = "${var.build_name}-cloudwatch-event"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_event_role.json
}

resource "aws_iam_role_policy" "cloudwatch_event_policy" {
  count = var.deploy_approval_enabled == 0 ? 1 : 0

  name = "${var.build_name}-cloudwatch-event"
  role = aws_iam_role.cloudwatch_event_role.id
  policy = data.aws_iam_policy_document.cloudwatch_event_policy.*.json[count.index]
}

resource "aws_iam_role_policy" "cloudwatch_event_policy_approval" {
  count = var.deploy_approval_enabled

  name = "${var.build_name}-cloudwatch-event"
  role = aws_iam_role.cloudwatch_event_role.id
  policy = data.aws_iam_policy_document.cloudwatch_event_policy_approval.*.json[count.index]
}

resource "aws_iam_role" "codebuild_role" {
  name = "${var.build_name}-codebuild"
  assume_role_policy = data.aws_iam_policy_document.codebuild_role.json
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${var.build_name}-codebuild"
  role = aws_iam_role.codebuild_role.id
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

resource "aws_iam_role" "codepipeline_role" {
  name = "${var.build_name}-codepipeline"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_role.json
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.build_name}-codepipeline"
  role = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}
