resource "aws_route53_zone" "this" {
  name = var.domain_name

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.name}-dns-zone"
  }
}