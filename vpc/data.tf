data "aws_caller_identity" "current" {}
#
#output "account_id" {
#  value = data.aws_caller_identity.current.account_id
#}

data "aws_vpc" "default" {
  id = var.default_vpc
}

output "vpc" {
  value = data.aws_vpc.default.main_route_table_id
}
