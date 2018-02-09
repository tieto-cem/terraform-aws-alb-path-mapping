variable "listener" {
  description = <<EOF
The listners that are mapped to the target group.
Example value:

{
  "arns" = "$${aws_lb_listener.a.arn},$${aws_lb_listener.b.arn}"
  "count" = 2
}
EOF
  type = "map"
}

variable "path_patterns" {
  description = "The path patterns to match."
  type        = "list"
}

variable "mapping_priority" {
  description = "The priority for the rule."
  default     = 101
}

variable "create_target_group" {
  description = "Whether target group should be created or not"
  default     = true
}

variable "tg_name" {
  description = "The name of the target group. Required if create_target_group is true."
  default     = ""
}

variable "tg_vpc_id" {
  description = "The identifier of the VPC in which to create the target group. Required if create_target_group is true."
  default     = ""
}

variable "tg_port" {
  description = "The port on which targets receive traffic. Overridden when registering a specific target."
  default     = 80   # doesn't matter since overridden when target is registered
}

variable "tg_protocol" {
  description = "The protocol to use for routing traffic to the targets."
  default     = "HTTP"
}

variable "tg_arn" {
  description = "The arn of existing target group. Required if create_target_group if false"
  default     = ""
}

variable "tg_deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds."
  default     = 5
}

variable "tg_health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  default     = 5
}

variable "tg_health_check_port" {
  description = "The port to use to connect with the target. Valid values are either ports 1-65536, or traffic-port. Defaults to traffic-port."
  default     = "traffic-port"
}
variable "tg_health_check_path" {
  description = "The destination for the health check request"
  default     = "/"
}

variable "tg_health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  default     = 2
}
variable "tg_health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  default     = 3
}

variable "tg_health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  default     = 3
}

variable "tg_health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target"
  default     = "200"
}