resource "aws_codecommit_repository" "protenus" {
  repository_name = "protenus-app"
  description     = "Git repository for protenus-app artifacts"
}