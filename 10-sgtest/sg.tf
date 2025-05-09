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

# ports 22, 443, 1194, 943 --> VPN ports
module "vpn_sg" {
  source = "git::https://github.com/AmbicaPuppala/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "vpn"
  sg_description = "created for vpn in expense dev infra"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
}

module "app_alb_sg"{
  source = "git::https://github.com/AmbicaPuppala/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "app-alb"
  sg_description = "created for app-alb in expense dev infra"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
}

resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    source_security_group_id = module.bastion_sg.sg_id
    security_group_id = module.app_alb_sg.sg_id
}

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = module.bastion_sg.sg_id
    
}


resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks       = ["0.0.0.0/0"] #it should be static ip of the user who is going to connect to the VPN
    security_group_id = module.vpn_sg.sg_id
    
}


resource "aws_security_group_rule" "vpn_443" {
  type              = "ingress"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks       = ["0.0.0.0/0"] #it should be static ip of the user who is going to connect to the VPN
    security_group_id = module.vpn_sg.sg_id
    
}


resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
    from_port        = 943
    to_port          = 943
    protocol         = "tcp"
    cidr_blocks       = ["0.0.0.0/0"] #it should be static ip of the user who is going to connect to the VPN
    security_group_id = module.vpn_sg.sg_id
    
}


resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
    from_port        = 1194
    to_port          = 1194
    protocol         = "tcp"
    cidr_blocks       = ["0.0.0.0/0"] #it should be static ip of the user who is going to connect to the VPN
    security_group_id = module.vpn_sg.sg_id
    
}

resource "aws_security_group_rule" "app_alb_vpn" {
  type              = "ingress"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    source_security_group_id = module.vpn_sg.sg_id
    security_group_id = module.app_alb_sg.sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    source_security_group_id = module.bastion_sg.sg_id
    security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "mysql_vpn" {
  type              = "ingress"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    source_security_group_id = module.vpn_sg.sg_id
    security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "backend_vpn" {
  type              = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    source_security_group_id = module.vpn_sg.sg_id
    security_group_id = module.backend_sg.sg_id
}

resource "aws_security_group_rule" "backend_vpn_http" {
  type              = "ingress"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    source_security_group_id = module.vpn_sg.sg_id
    security_group_id = module.backend_sg.sg_id
}

resource "aws_security_group_rule" "mysql_backend" {
  type              = "ingress"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    source_security_group_id = module.backend_sg.sg_id
    security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "backend_app-alb" {
  type              = "ingress"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    source_security_group_id = module.app_alb_sg.sg_id
    security_group_id = module.backend_sg.sg_id
}

