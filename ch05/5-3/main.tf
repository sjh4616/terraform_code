resource "aws_instance" "web" {
  ami           = "ami-02835aed2a5cb1d2a"
  instance_type = "t2.micro"

  tags = {
    Name = "user00-web-server"
  }
  
}