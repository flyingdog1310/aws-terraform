resource "aws_instance" "vpn" {
  count         = var.vpn_enabled ? 1 : 0
  ami           = "ami-0eba6c58b7918d3a1"
  instance_type = "t3a.micro"
  subnet_id     = aws_default_subnet.ap-northeast-1a.id

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.004500
    }
  }
  user_data            = file("${path.module}/src/user_data/vpn.sh")
  security_groups      = [aws_security_group.vpn_sg[0].id]
  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name
  key_name             = data.aws_key_pair.aws_ec2.key_name

  tags = {
    Name = "vpn"
    Env  = "general"
  }
}

resource "aws_security_group" "vpn_sg" {
  count       = var.vpn_enabled ? 1 : 0
  name        = "allow_vpn_udp"
  description = "Allow http inbound traffic"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
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
    Name = "vpn-ec2-security-group"
  }
}
