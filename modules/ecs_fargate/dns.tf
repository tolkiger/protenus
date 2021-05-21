resource "aws_route53_zone" "hellotest_com" {
  name          = "hello.test.com."
  comment       = "Managed by Terraform"
  force_destroy = false
}

resource "aws_route53_record" "lb_web" {
  count = var.lb_enabled > 0 ? length(var.route53_name) : 0
  zone_id = aws_route53_zone.hellotest_com.zone_id
  name = var.route53_name[count.index]
  type = "A"

  alias {
    name = var.route53_alias_name[count.index]
    zone_id = aws_route53_zone.hellotest_com.zone_id
    evaluate_target_health = true
  }
}
