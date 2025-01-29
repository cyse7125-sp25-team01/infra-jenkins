resource "aws_instance" "app_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id
  key_name              = var.key_pair

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  iam_instance_profile = var.iam_instance_profile
  tags = {
    Name = var.instance_name
  }

  lifecycle {
    prevent_destroy = false
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo certbot --nginx \
      -d jenkins.csye7125-team01.xyz \
      --non-interactive \
      --agree-tos \
      -m manas.gourabathini@gmail.com

    sudo systemctl reload nginx
  EOF
}

# Allocate Elastic IP
data "aws_eip" "latest_eip" {
  filter {
    name   = "tag:Name"
    values = ["Jenkins"]
  }
}

# Associate Elastic IP with Jenkins Instance
resource "aws_eip_association" "jenkins_eip_assoc" {
  instance_id   = aws_instance.app_instance.id
  allocation_id = data.aws_eip.latest_eip.id
}

# Disassociate Elastic IP on Termination
resource "null_resource" "disassociate_eip" {
  triggers = { instance_id = aws_instance.app_instance.id }

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]
    command = <<EOT
    $assocId = (aws ec2 describe-addresses --filters Name=instance-id,Values=${aws_instance.app_instance.id} --query Addresses[0].AssociationId --output text)
    if ($assocId -ne 'None' -and $assocId -ne '') {
        aws ec2 disassociate-address --association-id $assocId
    }
    EOT
  }

  depends_on = [aws_instance.app_instance]
}