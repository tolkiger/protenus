output "lb_dns_name" {
  description = "ALB DNS"
  value = element(concat(aws_lb.web.*.dns_name),0,)
}

output "lb_dns_zone_id" {
  description = "ALB DNS Zone ID"
  value = element(concat(aws_lb.web.*.zone_id),0,)
}

output "cw_log_group" {
  value = aws_cloudwatch_log_group.app.name
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_group" {
  value = [aws_subnet.main_1.id,aws_subnet.main_2.id,aws_subnet.main_3.id,]
}

output "sec_group" {
  value = aws_security_group.sec_group.id
}
