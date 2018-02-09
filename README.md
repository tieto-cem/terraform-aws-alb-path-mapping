[![CircleCI](https://circleci.com/gh/tieto-cem/terraform-aws-alb-tg-path-mapping.svg?style=shield&circle-token=19370e6a9018d2d0710bdceb95bf830eeff58b42)](https://circleci.com/gh/tieto-cem/terraform-aws-alb-tg-path-mapping)

Terraform ALB Target Group path mapping module
==============================================

Terraform module for mapping ALB listener(s) to either existing or new target group.


Usage
-----

```hcl

provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet_ids" "public_subnet_ids" {
  vpc_id = "${data.aws_vpc.default_vpc.id}"
}

module "alb" {
  source                 = "github.com/tieto-cem/terraform-aws-alb?ref=v0.1.0"
  name                   = "alb-example"
  lb_internal            = false
  lb_subnet_ids          = "${data.aws_subnet_ids.public_subnet_ids.ids}"
  lb_security_group_ids  = ["sg-12345678"]
  tg_vpc_id              = "${data.aws_vpc.default_vpc.id}"
  http_listener_enabled  = true
  https_listener_enabled = false
}
```

Resource naming
---------------

This module names AWS resources as follows:

| Name                               | Type           | 
|------------------------------------|----------------|
|${var.tg_name}                      | Target Group   |


Example
-------

* [Simple example](https://github.com/tieto-cem/terraform-aws-alb-tg-path-mapping/tree/master/example)