# TASK #1: TERRAFORM
### Terraform infrastructure code that provisions the necessary AWS infrastructure to build and deploy a Docker container. 

---
![Terraform](https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg)

## How it works
1. This project will provision a CICD pipeline using AWS Development tools:

    * CodeCommit
    * CodeBuild
    * CodePipeline

2. The pipeline is triggered when a user commits their code within the CodeCommit Repo. This creates an event that triggers CodePipeline.
3. Once the pipeline has been triggered, the first stage of the pipeline is to pull the source code from CodeCommit. This stage is called "Source".
4. The Source stage will create an artifact that will be passed to the next stage called Build.
5. The Build stage will take the artifact and run the commands listed in the buildspec.yml file (this file can be found on the root of this repo)
6. The Build stage will build, tag and push the Docker image to AWS ECR and create a file called imagedefinitions.json as an artifact that will be passed to the Deploy stage.
7. The Deploy stage will update the ECS service's task-definition and trigger a Task depoyment. This allows the ECS Fargate to run a Task so the Docker Image can run. 

## Assumptions
* This project is not using real naming conventions nor accurate data. This was made on purpose.
* AWS account information is not valid.
* All network configuration has been set with dummy subnets. 
* The project code returns a successful `Terraform Plan` output. However, this does not mean that the code will work when doing an `Terraform apply`. To successfully provision this code, real network configuration is required.

#### Author
* Gerardo Castaneda - 05/2021