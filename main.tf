resource "aws_launch_template" "saturday_app_ha" {
  name_prefix   = "saturday-app-ha-"
  description   = "Launch template for web servers"

  image_id      = var.ami
  instance_type = var.instance_type
   user_data              = filebase64("userdata.sh")
iam_instance_profile {
  name = aws_iam_instance_profile.satrurdsay_instance_profile.id
}

  # Optional: root volume configuration
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  # Optional: network settings
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.saturday_ha_sg.id]
  }

  # Optional: tags
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "saturday-app-ha"
      Env  = "dev"
    }
  }
}

resource "aws_autoscaling_group" "saturday_app_asg" {
  name                      = "saturday-app-asg"
  max_size                  = 6
  min_size                  = 3
  desired_capacity          = 3
  vpc_zone_identifier       = var.subnet_ids

  launch_template {
    id      = aws_launch_template.saturday_app_ha.id
    version = "$Latest"
  }
}