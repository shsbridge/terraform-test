data "aws_ami" "gcc_rh8_nginx" {
  most_recent = true

  filter {
    name   = "name"
    values = ["GT_GCCS_StandardBuild_RHEL_8_Nginx_on*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["272677769750"] # Canonical
}

data "aws_vpc" "dev_vpc" {
  id = "vpc-067dd34cd32d9461c"
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    
    config = {
        bucket = "winsdevopsinternalstorage"
        key    = "terraform/test/vpc/terraform.tfstate"
        region = "ap-southeast-1"
        profile = "uat-wins"
    }
}