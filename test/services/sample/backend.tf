terraform {
  backend "s3" {
    bucket = "winsdevopsinternalstorage"
    key = "terraform/test/services/sample/terraform.tfstate"
    profile = "uat-wins"
    region = "ap-southeast-1"

    dynamodb_table = "wins-terraform-uat"
    encrypt = true
  }
}