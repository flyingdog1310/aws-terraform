resource "aws_instance" "bastion" {
  count         = var.bastion_enabled ? 1 : 0
  ami           = "ami-01bef798938b7644d"
  instance_type = "t3a.micro"
  subnet_id     = aws_default_subnet.ap-northeast-1a.id

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.005000
    }
  }
  user_data            = file("${path.module}/src/server.sh")
  security_groups      = [aws_security_group.bastion_sg[0].id]
  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name
  key_name             = data.aws_key_pair.aws_ec2.key_name

  tags = {
    Name = "bastion"
    Env  = "general"
  }
}

resource "aws_security_group" "bastion_sg" {
  count       = var.bastion_enabled ? 1 : 0
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
    Name = "bastion-ec2-security-group"
  }
}
