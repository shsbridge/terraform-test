provider "aws" {
  region = "ap-southeast-1"
  profile = "uat-wins"
}

resource "aws_instance" "gcc-redhat" {
  ami = "ami-068144e64145464fe"
  key_name = "dev-keypair"
  instance_type = "t2.micro"
  subnet_id = "subnet-0364665748d5b37ad"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<EOF
    #!/bin/bash
    echo "Hello, world" > index.html
    nohup busybox httpd -f -p 8080 &
  EOF

  tags = {
    Name = "terraform-test"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-test-sg"
  vpc_id = "vpc-067dd34cd32d9461c"

  ingress {
    from_port = 8080
    to_port = 8080
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