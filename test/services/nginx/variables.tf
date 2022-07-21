variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type = number
  default = 8080
}
variable "http_port" {
  description = "The port the alb will use for HTTP requests"
  type = number
  default = 80
}

variable "profile_name" {
    description = "we have uat-wins, prd-wins,uat-fdw,prd-fdw"
    type = string
    default = "uat-wins"
}

variable "dev_key" {
    type = string
    default = "dev-keypair"
}