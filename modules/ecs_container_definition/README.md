# ECS Container Definition Module
Terraform module to generate well-formed JSON documents that are passed to the `aws_ecs_task_definition` Terraform resource as [container definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definitions).

---
![Terraform](https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg)

## Usage
This module is meant to be used as output only, meaning it will be used to create outputs which are consumed as a parameter by Terraform resources or other modules.


## Outputs

| Name | Description |
|------|-------------|
| json | JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition. |
| json_map | JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition. |
