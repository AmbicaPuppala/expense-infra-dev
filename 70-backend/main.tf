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

resource "null_resource" "expense" {

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host        = aws_instance.backend.private_ip
    type        = "ssh"
    user       = "ec2-user"
    password  = "DevOps321"
  }
  provisioner "file" {
    source      = "backend.sh"
    destination = "/tmp/backend.sh "
  }


  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/backend.sh",
      "sudo sh /tmp/backend.sh ${var.environment}"
    ]
  }
}

