resource "aws_instance" "bastion_host" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_1
  vpc_security_group_ids = [var.bastion_host_security_group]
  key_name               = var.key_name

  tags = {
    Name = "Bastion Host"
  }
}