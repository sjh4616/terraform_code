// 시작 템플릿
resource "aws_launch_template" "launch_template" {
  name          = "${var.prefix}-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.ssh_sg_id,
                            data.terraform_remote_state.sg.outputs.http_sg_id,
                            data.terraform_remote_state.sg.outputs.https_sg_id]

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.prefix}-launch-template"
    }
  }
}

// 오토스케일링 그룹 생성
resource "aws_autoscaling_group" "asg" {
  name = "${var.prefix}-autoscaling-group"
  desired_capacity = 1
  max_size         = 2
  min_size         = 1
  vpc_zone_identifier = [data.terraform_remote_state.vpc.outputs.private01_id,
                         data.terraform_remote_state.vpc.outputs.private02_id]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  
  target_group_arns = [ data.terraform_remote_state.lb.outputs.target_group_arn]

  tag {
    key                 = "Name"
    value               = "${var.prefix}-autoscaling-group"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
  health_check_type         = "ELB"
  health_check_grace_period = 300
  force_delete              = true
}