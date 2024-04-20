#Create an elastic ip to be used for the Natgetway in public subnet 1

resource "aws_eip" "eip_natgateway_1" {
  vpc = true

  tags = {
    Name : "Elastic-IP-NatGateway_1"
  }
}

#CREATE an elastic ip to be used for Nat gateway in the public subnet 2

resource "aws_eip" "eip_natgateway_2" {
  vpc = true

  tags = {
    Name : "Elastic-IP-NatGateway_2"
  }
}

#create a nat gateway in the first public subnet
resource "aws_nat_gateway" "for_public_subnet_1" {
  allocation_id = aws_eip.eip_natgateway_1.id
  subnet_id     = var.public_subnet_1

  tags = {
    Name = "NatGateway_Public_Subnet_1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.internet_gateway]
}

#create a nat gateway in the second public subnet
resource "aws_nat_gateway" "for_public_subnet_2" {
  allocation_id = aws_eip.eip_natgateway_2.id
  subnet_id     = var.public_subnet_2

  tags = {
    Name = "NatGateway_Public_Subnet_2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.internet_gateway]
}

#create a private route table and add route to the nat gateway for public subnet 1 
resource "aws_route_table" "private_route_table_1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.for_public_subnet_1.id
  }
  tags = {
    Name = "Private_Route_Table_1"
  }
}
#Associate the private subnet 3 to the private route table 1
resource "aws_route_table_association" "private_subnet_3_with_private_route_table_1" {
  subnet_id      = var.private_subnet_3
  route_table_id = aws_route_table.private_route_table_1.id
}

#Associate the private subnet 5 with the private route table 1
resource "aws_route_table_association" "private_subnet_5_with_private_route_table_1" {
  subnet_id      = var.private_subnet_5
  route_table_id = aws_route_table.private_route_table_1.id
}

#Create private route table 2 and add route to the nat gateway in the public subnet 2
resource "aws_route_table" "private_route_table_2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.for_public_subnet_2.id
  }
  tags = {
    Name = "Private_Route_Table_2"
  }
}
#Associate the private subnet 4 with the private route table 2
resource "aws_route_table_association" "private_subnet_4_with_private_route_table_2" {
  subnet_id      = var.private_subnet_4
  route_table_id = aws_route_table.private_route_table_2.id
}

#Associate the private subnet 6 with the private route table 2
resource "aws_route_table_association" "private_subnet_6_with_private_route_table_2" {
  subnet_id      = var.private_subnet_6
  route_table_id = aws_route_table.private_route_table_2.id
}