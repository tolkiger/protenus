resource "aws_cloudwatch_event_rule" "codecommit" {
  name = "${var.pipeline_name}-er"
  is_enabled = true
  event_pattern = <<EOF
{
  "source": [
    "aws.codecommit"
  ],
  "detail-type": [
    "CodeCommit Repository State Change"
  ],
  "resources": [
    "arn:aws:codecommit:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.source_repo}"
  ],
  "detail": {
    "event": [
      "referenceCreated",
      "referenceUpdated"
    ],
    "referenceType": [
      "branch"
    ],
    "referenceName": [
      "${var.source_branch}"
    ]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "codecommit_pipeline" {
  count = var.deploy_approval_enabled == 0 ? 1 : 0

  target_id = "${var.pipeline_name}-et"
  rule = aws_cloudwatch_event_rule.codecommit.name
  arn = aws_codepipeline.pipeline.*.arn[count.index]
  role_arn = aws_iam_role.cloudwatch_event_role.arn
}

resource "aws_cloudwatch_event_target" "codecommit_pipeline_approval" {
  count = var.deploy_approval_enabled

  target_id = "${var.pipeline_name}-et"
  rule = aws_cloudwatch_event_rule.codecommit.name
  arn = aws_codepipeline.pipeline_approval.*.arn[count.index]
  role_arn = aws_iam_role.cloudwatch_event_role.*.arn[count.index]
}
