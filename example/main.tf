provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "public_subnet_ids" {
  vpc_id = "${data.aws_vpc.default.id}"
}

module "alb_sg" {
  source      = "github.com/tieto-cem/terraform-aws-sg?ref=v0.1.0"
  name        = "alb-example-sg"
  vpc_id      = "${data.aws_vpc.default.id}"
  allow_cidrs = {
    "80" = ["0.0.0.0/0"]
  }
}

module "cert" {
  source = "github.com/tieto-cem/terraform-aws-self-signed-cert?ref=v0.1.0"
  name   = "myexample-cert"
}

module "alb" {
  source                 = "github.com/tieto-cem/terraform-aws-alb?ref=v0.1.2"
  name                   = "alb-example"
  lb_internal            = false
  lb_subnet_ids          = "${data.aws_subnet_ids.public_subnet_ids.ids}"
  lb_security_group_ids  = ["${module.alb_sg.id}"]
  tg_vpc_id              = "${data.aws_vpc.default.id}"
  http_listener_enabled  = true
  https_listener_enabled = true
  https_listener_certificate_arn = "${module.cert.arn}"
}


module "path_mapping" {
  source              = ".."
  listener            = {
    "arns"  = "${module.alb.https_listener_arn},${module.alb.http_listener_arn}"
    "count" = 2
  }
  path_patterns       = ["/api/*"]
  create_target_group = true
  tg_name             = "test-tg"
  tg_vpc_id           = "${data.aws_vpc.default.id}"
}
