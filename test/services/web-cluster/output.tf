output "dev_alb_dns_name" {
  value = aws_lb.dev_alb.dns_name
  description = "The DNS name for load balancer"
}