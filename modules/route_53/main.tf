
data "aws_route53_zone" "public-zone" {
  name         = var.hosted_zone_name
  private_zone = false
}
resource "aws_route53_record" "cloudfront_record" {
  zone_id = data.aws_route53_zone.public-zone.zone_id
  name    = "2Tier.${data.aws_route53_zone.public-zone.name}"
  type    = "A"

  alias {
    name                   = var.cdf_domain_name
    zone_id                = var.cdf_hosted_zone_id
    evaluate_target_health = false
  }
}