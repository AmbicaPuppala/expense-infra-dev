module "alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = true

  name    = "${var.project}-${var.environment}-app-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.private_subnets_ids
  create_security_group = false
  security_groups = [local.app_alb_sg_id]

  tags = merge(
    var.common_tags,
    {
      name ="${var.project}-${var.environment}-app-alb"
    }
  )
  
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  
  default_action {
    type             = "fixed-response"

  fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from backend APP ALB</h1>"
      status_code  = "200"
    }
}
}