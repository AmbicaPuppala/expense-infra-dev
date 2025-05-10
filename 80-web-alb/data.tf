data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids"{
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "web_alb_sg_id" {
  name = "/${var.project}/${var.environment}/web_alb_sg_id"
}

data "aws_ssm_parameter" "web_alb_certificate_arn" {
  name = "/${var.project}/${var.environment}/web_alb_certificate_arn"
}