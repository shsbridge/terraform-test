resource "aws_security_group" "instance" {
  name = "terraform-test-sg"
  vpc_id = data.aws_vpc.dev_vpc.id

  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["100.112.165.0/24"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["100.112.165.0/24"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb" {
  name = "terraform-alb-sg"
  vpc_id = data.aws_vpc.dev_vpc.id

  ingress {
    from_port = var.http_port
    to_port = var.http_port
    protocol = "tcp"
    cidr_blocks = ["100.112.165.0/24"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

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