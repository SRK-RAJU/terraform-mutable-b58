locals {
  default_vpc_cidr = tolist([data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR, ""])
  all_cidr_vpc     = compact(concat(data.terraform_remote_state.vpc.outputs.VPC_CIDR, local.default_vpc_cidr))
  all_instance_ip  = concat(aws_instance.on-demand.*.private_ip, aws_spot_instance_request.spot.*.private_ip)
  all_instance_id  = concat(aws_instance.on-demand.*.id, aws_spot_instance_request.spot.*.spot_instance_id)
}
