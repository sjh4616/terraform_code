// 단일 WEB Server 구축
resource "aws_instance" "user00-web" {
                               # data.aws_ami.amazon_linux.id
  ami                         = "ami-077ad873396d76f6a" // Amazon Linux 2023 kernel-6.1
  instance_type               = "t2.micro"
  subnet_id                   = element(var.private_subnet_id, 0)
  vpc_security_group_ids      = ["sg-0437bf0ffdc6637c3",
                                 "sg-0a40f39963b28a706",
                                 "sg-0f4501a07d7c152dd"]
  key_name                    = "user00-key" // Replace with your key pair name
  tags = {
    Name = "user00-web"
  }   
}