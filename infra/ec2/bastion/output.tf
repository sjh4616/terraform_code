output "user00-public-ip" {
  value = aws_instance.user00-bastion.public_ip
}