resource "aws_route53_zone_association" "assoc" {
  zone_id = var.private_hosted_zone_id
  vpc_id  = aws_vpc.main.id
}
