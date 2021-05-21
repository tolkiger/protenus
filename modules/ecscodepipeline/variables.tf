variable "aws_region" {}
variable "vpc_name" {}

variable "build_name" {description = "CodeBuild Project Name"}
variable "build_timeout" {description = "CodeBuild's project timeout"}
variable "build_compute_type" {description = "CodeBuild Compute Type"}
variable "build_image" {description = "Docker Image to use for CodeBuild project"}
variable "build_environment_type" {description = "CodeBuild Environment Type"}
variable "build_environment_privileged" {description = "Docker Image can run as root"}
variable "build_vpc_id" {description = "VPC ID to use for CodeBuild"}

variable "build_subnets" {
  description = "CodeBuild Subnets to use"
  type = list(string)
}

variable "build_security_groups" {
  description = "CodeBuild Security Groups to use"
  type = list(string)
}

variable "deploy_approval_enabled" {
  description = "Is this is true, a pipeline with an approval stage will be created. Default: No approval stage provisioned"
  default = 0
}

variable "pipeline_name" {description = "Pipeline's name"}
variable "ecs_cluster_name" {description = "ECS Cluster's Name"}
variable "ecs_container_name" {description = "Container's name"}
variable "ecs_service_name" {description = "ECS Service's Name"}
variable "s3_artifact_kms_key" {description = "KMS CMK key for S3 encrypted artifact bucket"}
variable "source_owner" {description = "Caller Identity"}
variable "source_repo" {description = "Repo to use for CodePipeline Source stage"}
variable "source_branch" {description = "Branch name to trigger pipeline"}

