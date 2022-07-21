resource "aws_subnet" "mdw_dev1" {
  vpc_id = data.aws_vpc.dev_vpc.id
  cidr_block = "100.112.165.128/27"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "sub-a-mdw-dev-app-1"
  }
}

resource "aws_subnet" "mdw_dev2" {
  vpc_id = data.aws_vpc.dev_vpc.id
  cidr_block = "100.112.165.160/27"
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "sub-c-mdw-dev-app-2"
  }
}