resource "aws_instance" "app_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id
  key_name               = var.key_pair

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
    create_before_destroy = true

  }

  user_data = <<-EOF
    #!/bin/bash
    STAGING_FLAG=""
    if [ "${var.use_staging_cert}" = "true" ]; then
      STAGING_FLAG="--staging"
    fi
    sudo certbot --nginx $STAGING_FLAG \
      -d ${var.jenkins_domain} \
      --non-interactive \
      --agree-tos \
      -m ${var.admin_email}

    sudo systemctl reload nginx
  EOF
}

data "aws_eip" "latest_eip" {
  filter {
    name   = "tag:Name"
    values = ["Jenkins"]
  }
}

resource "aws_eip_association" "jenkins_eip_assoc" {
  instance_id   = aws_instance.app_instance.id
  allocation_id = data.aws_eip.latest_eip.id
}



