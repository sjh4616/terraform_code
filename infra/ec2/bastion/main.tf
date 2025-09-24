// Basten Server 구축
resource "aws_instance" "user00-bastion" {
  ami                         = "ami-077ad873396d76f6a" // Amazon Linux 2023 kernel-6.1
  instance_type               = "t2.micro"
  subnet_id                   = element(var.public_subnet_id, 0)
  vpc_security_group_ids      = ["sg-0f4501a07d7c152dd"] // ssh-accept
  key_name                    = "user00-key" // Replace with your key pair name
  associate_public_ip_address = true
  tags = {
    Name = "user00-bastion"
  }   
}