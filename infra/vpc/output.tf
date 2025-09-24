output "vpc_id" {
  value = aws_vpc.user00-vpc.id
}
output "user00_public01_id" {
  value = aws_subnet.user00-public01.id
}
output "user00_public02_id" {
  value = aws_subnet.user00-public02.id
}
output "user00_private01_id" {
  value = aws_subnet.user00-private01.id
}
output "user00_private02_id" {
  value = aws_subnet.user00-private02.id
}