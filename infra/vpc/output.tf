output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public01_id" {
  value = aws_subnet.public01.id
}
output "public02_id" {
  value = aws_subnet.public02.id
}
output "private01_id" {
  value = aws_subnet.private01.id
}
output "private02_id" {
  value = aws_subnet.private02.id
}