output "public_ip" {
  description = "The public IPv4 address of the web server"
  value       = aws_instance.example.public_ip
}

output "instance_id" {
  description = "The Instance ID"
  value       = aws_instance.example.id
}

output "alb_dns_name" {
  description = "The domain name of the load balancer"
  value       = aws_lb.example.dns_name
}
