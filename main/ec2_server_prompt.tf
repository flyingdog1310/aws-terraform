resource "aws_instance" "server_prompt" {
  count         = var.server_prompt_enabled ? 1 : 0
  ami           = var.ubuntu_ami
  instance_type = "t3a.micro"
  subnet_id     = aws_default_subnet.ap-northeast-1a.id

  user_data              = file("${path.module}/src/user_data/all_in_one.sh")
  vpc_security_group_ids = [aws_security_group.server_prompt_sg[0].id]
  iam_instance_profile   = aws_iam_instance_profile.dev-resources-iam-profile.name
  key_name               = data.aws_key_pair.aws_ec2.key_name

  tags = {
    Name = "prompt-server"
    Env  = "general"
  }
}

resource "aws_security_group" "server_prompt_sg" {
  count       = var.server_prompt_enabled ? 1 : 0
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "prompt-server-ec2-security-group"
  }
}
