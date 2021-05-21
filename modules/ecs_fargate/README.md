# ECS Fargate Module
Terraform module to setup and configure all the necessary components to create ECS Fargate infrastructure

---
![Terraform](https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg)

## Usage
This module will provision the following AWS resources:

* AutoScaling Group
* CloudWatch Log Group
* DNS A Record and Hosted Zone
* ECS Fargate:
  * Cluster
  * Service
* All the necessary IAM Permissions
* Security Groups
* LoadBalancing:
    * Listener
    * Target Groups
* All network components needed:
    * VPC
    * Subnets


## Outputs

| Name | Description |
|------|-------------|
| lb_dns_name | ALB's name
| lb_dns_zone_id | ALB DNS Zone ID
| cw_log_group | CloudWatch LogGroup to push logs to
| vpc_id | The VPC's ID
| subnet_group | Collection of subnets. One subnet per AZ
| sec_group | Security Group used for ECS Service |
