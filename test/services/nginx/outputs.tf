output "nginx_http_private_ip" {
  value = aws_instance.nginx_http.private_ip
}