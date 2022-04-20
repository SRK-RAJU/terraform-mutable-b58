output "INTERNAL_LB_NAME" {
  value = aws_lb.internal.dns_name
}

output "PUBLIC_LB_NAME" {
  value = aws_lb.public.dns_name
}

output "PUBLIC_LB_ARN" {
  value = aws_lb.public.arn
}

output "INTERNAL_LISTENER" {
  value = aws_lb_listener.internal.arn
}
