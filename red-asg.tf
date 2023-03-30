resource "aws_launch_template" "red_template" {
  name_prefix   = "red_template"
  image_id      = "data.aws_ami.server.id"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]

}

resource "aws_autoscaling_group" "red" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}