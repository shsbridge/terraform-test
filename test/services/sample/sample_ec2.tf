resource "aws_instance" "gcc-ec2-sample" {
  ami = data.aws_ami.ubuntu.id
  key_name = var.dev_key
  instance_type = "t2.micro"
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id_mdw_dev1
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"
      
#!/bin/bash
echo "Hello, world!" > index.html
nohup busybox httpd -f -p ${var.server_port} &
--//--
EOF

  tags = {
    Name = "terraform-test"
  }
}


