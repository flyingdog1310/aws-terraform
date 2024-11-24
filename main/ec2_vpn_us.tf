data "aws_ami" "us_ubuntu" {
  provider = aws.us-east
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-*"]
  }
}


resource "aws_instance" "us_vpn" {
  count         = var.us_vpn_enabled ? 1 : 0
  provider      = "aws.us-east"
  ami           = data.aws_ami.us_ubuntu.id
  instance_type = "t3a.micro"
  subnet_id     = aws_default_subnet.us-east-1a.id

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.004500
    }
  }
  user_data              = file("${path.module}/src/user_data/vpn.sh")
  vpc_security_group_ids = [aws_security_group.us_vpn_sg[0].id]
  iam_instance_profile   = aws_iam_instance_profile.dev-resources-iam-profile.name
  key_name               = data.aws_key_pair.aws_ec2.key_name

  tags = {
    Name = "vpn"
    Env  = "general"
  }
}

resource "aws_security_group" "us_vpn_sg" {
  count       = var.us_vpn_enabled ? 1 : 0
  provider    = "aws.us-east"
  name        = "allow_vpn_udp"
  description = "Allow http inbound traffic"
  vpc_id      = aws_default_vpc.default_us_east.id
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
