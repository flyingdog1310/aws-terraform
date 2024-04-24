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
