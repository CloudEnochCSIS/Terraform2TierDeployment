resource "aws_key_pair" "ec2_key" {
    key_name = "ec2_key"
    public_key = file ("../modules/key-pair/id_rsa.pub")
  
}