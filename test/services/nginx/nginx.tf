resource "aws_instance" "nginx_http" {
  ami = data.aws_ami.gcc_rh8_nginx.id
  key_name = var.dev_key
  instance_type = "t2.micro"
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id_mdw_dev1
  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "nginx-http"
  }
}


