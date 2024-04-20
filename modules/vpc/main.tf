
#Create a new VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

#create an internet gateway and attache it to the vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Getting all the availabilty zones in the region using data source
data "aws_availability_zones" "available_zones" {

}

#Create the first public subnet 7
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true
  

  tags = {
    Name = "public_subnet_1"
  }
}


#Create the second public subnet
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true
  

  tags = {
    Name = "public_subnet_2"
  }
}

#Create a route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "Public_route_table"
  }
}

#associate the first public subnet to the public route table 
resource "aws_route_table_association" "for_public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id 
}

#assocate the second public subnet to the public route table 
resource "aws_route_table_association" "for_public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id 
}

#create the first private subnet 
resource "aws_subnet" "private_subnet_3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_3_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false 
  

  tags = {
    Name = "private_subnet_3"
  }
}

#create the second private subnet 
resource "aws_subnet" "private_subnet_4" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_4_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false
  

  tags = {
    Name = "private_subnet_4"
  }
}

#create the third private subnet
resource "aws_subnet" "private_subnet_5" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_5_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false
  

  tags = {
    Name = "private_subnet_5"
  }
}

#create the final private subnet
resource "aws_subnet" "private_subnet_6" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_6_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false
  

  tags = {
    Name = "private_subnet_6"
  }
}