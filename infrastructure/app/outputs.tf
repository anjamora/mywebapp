#ec2 public ip
output "instance_ip_addr" {
  value = aws_instance.webapp.public_ip
}
