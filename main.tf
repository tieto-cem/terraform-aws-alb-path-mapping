
resource "aws_lb_target_group" "target_group" {
  count                = "${var.create_target_group ? 1 : 0}"
  name                 = "${var.tg_name}"
  vpc_id               = "${var.tg_vpc_id}"
  port                 = "${var.tg_port}"
  protocol             = "${var.tg_protocol}"
  deregistration_delay = "${var.tg_deregistration_delay}"

  health_check {
    interval            = "${var.tg_health_check_interval}"
    path                = "${var.tg_health_check_path}"
    port                = "${var.tg_health_check_port}"
    protocol            = "${var.tg_protocol}"
    healthy_threshold   = "${var.tg_health_check_healthy_threshold}"
    unhealthy_threshold = "${var.tg_health_check_unhealthy_threshold}"
    timeout             = "${var.tg_health_check_timeout}"
    matcher             = "${var.tg_health_check_matcher}"
  }

}

resource "aws_lb_listener_rule" "listener_rule" {
  count        = "${(var.listener["count"])}"
  listener_arn = "${element(split(",", var.listener["arns"]), count.index)}"
  priority     = "${var.mapping_priority}"

  action {
    type             = "forward"
    target_group_arn = "${join("", concat(aws_lb_target_group.target_group.*.arn, list(var.tg_arn)))}"
  }

  condition {
    field  = "path-pattern"
    values = "${var.path_patterns}"
  }
}
