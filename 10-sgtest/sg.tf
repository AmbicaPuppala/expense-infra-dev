module "mysql_sg" {
  source = "git::https://github.com/AmbicaPuppala/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "mysql"
  sg_description = "created for mysql instances in expense dev infra"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
}


module "backend_sg" {
  source = "git::https://github.com/AmbicaPuppala/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "backend"
  sg_description = "created for backend instances in expense dev infra"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
}

module "frontend_sg" {
  source = "git::https://github.com/AmbicaPuppala/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "frontend"
  sg_description = "created for frontend instances in expense dev infra"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
}

module "bastion_sg" {
  source = "git::https://github.com/AmbicaPuppala/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "bastion"
  sg_description = "created for bastion instances in expense dev infra"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
}