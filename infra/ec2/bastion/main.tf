// Basten Server 구축
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public02_id
  vpc_security_group_ids      = [data.terraform_remote_state.sg.outputs.ssh_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = {
    Name = "${var.prefix}-bastion"
  }
}