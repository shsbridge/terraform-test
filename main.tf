provider "aws" {
  region = "ap-southeast-1"
  profile = "uat-wins"
}

resource "aws_instance" "gcc-redhat" {
  ami = "ami-0002790b218518d76"
  instance_type = "t2.micro"
}
