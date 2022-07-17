output "gcc_ec2_sample_private_ip" {
  value = aws_instance.gcc-ec2-sample.private_ip
  description = "The private ip address fo the web server"
}

output "dev_alb_dns_name" {
  value = aws_lb.dev_alb.dns_name
  description = "The DNS name for load balancer"
}