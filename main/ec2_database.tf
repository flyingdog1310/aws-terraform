resource "aws_instance" "database" {
  count         = var.database_enabled ? 1 : 0
  ami           = "ami-0eba6c58b7918d3a1"
  instance_type = "t3a.micro"
  subnet_id     = aws_default_subnet.ap-northeast-1a.id

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.004000
    }
  }

  user_data            = file("${path.module}/src/database.sh")
  security_groups      = [aws_security_group.ec2_sg[0].id]
  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name

  tags = {
    Name = "database"
    Env  = "general"
  }
}

resource "aws_security_group" "ec2_sg" {
  count       = var.database_enabled ? 1 : 0
  name        = "allow_redis_mysql"
  description = "Allow http inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg[0].id]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg[0].id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-ec2-security-group"
  }
}
