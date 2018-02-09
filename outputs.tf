
output "target_group_arn" {
  value = "${join("", concat(aws_lb_target_group.target_group.*.arn, list(var.tg_arn)))}"
}