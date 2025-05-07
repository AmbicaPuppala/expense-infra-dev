resource "aws_instance" "backend" {
    ami                    = data.aws_ami.joindevops.id
    vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
    instance_type         = "t3.micro"
    subnet_id = local.private_subnet_id

    tags = merge(
      var.common_tags,
      {
        Name = "${var.project}-${var.environment}-backend"        
    }    
    )
}

resource "null-resource" "expense" {
  
  triggers = {
    instance_id = aws_instance.backend.id
  }
  connection {
    host        = aws_instance.backend.private_ip
    type        = "ssh"
    user       = "ec2-user"
    password  = "DevOps321"
  }
 