resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "ap-northeast-1a" {
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "Default subnet for ap-northeast-1a"
  }
}

resource "aws_default_subnet" "ap-northeast-1c" {
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "Default subnet for ap-northeast-1c"
  }
}

resource "aws_default_subnet" "ap-northeast-1d" {
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "Default subnet for ap-northeast-1d"
  }
}

resource "aws_default_vpc" "default_us_east" {
  provider = aws.us-east
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "us-east-1a" {
  provider = aws.us-east
  availability_zone = "us-east-1a"

  tags = {
    Name = "Default subnet for us-east-1a"
  }
}

resource "aws_default_subnet" "us-east-1b" {
  provider = aws.us-east
  availability_zone = "us-east-1b"

  tags = {
    Name = "Default subnet for us-east-1b"
  }
}

resource "aws_default_subnet" "us-east-1c" {
  provider = aws.us-east
  availability_zone = "us-east-1c"

  tags = {
    Name = "Default subnet for us-east-1c"
  }
}
