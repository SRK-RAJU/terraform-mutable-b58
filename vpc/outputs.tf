output "VPC_ID" {
  value = aws_vpc.main.id
}

output "PUBLIC_SUBNET_IDS" {
  value = aws_subnet.public.*.id
}

output "PRIVATE_SUBNET_IDS" {
  value = aws_subnet.private.*.id
}

output "VPC_CIDR" {
  value = local.all_cidr_vpc
}

output "PUBLIC_SUBNET_CIDR" {
  value = aws_subnet.public.*.cidr_block
}

output "PRIVATE_SUBNET_CIDR" {
  value = aws_subnet.private.*.cidr_block
}

output "DEFAULT_VPC_ID" {
  value = var.default_vpc
}

output "DEFAULT_VPC_CIDR" {
  value = var.default_vpc_cidr
}

output "PRIVATE_HOSTED_ZONE_ID" {
  value = var.private_hosted_zone_id
}

output "PUBLIC_HOSTED_ZONE_ID" {
  value = var.public_hosted_zone_id
}