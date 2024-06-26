
output "region_name" {
    value = var.region_name
}

output "project_name" {
    value = var.project_name
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "public_subnet_1" {
  value = aws_subnet.public_subnet_1.id 
}

output "public_subnet_2" {
    value = aws_subnet.public_subnet_2.id
  
}
output "internet_gateway" {
    value = aws_internet_gateway.internet_gateway 
  
}

output "private_subnet_3" {
    value = aws_subnet.private_subnet_3.id
}

output "private_subnet_4" {
   value = aws_subnet.private_subnet_4.id 
}

output "private_subnet_5" {
     value = aws_subnet.private_subnet_5.id  
}
output "private_subnet_6" {
    value = aws_subnet.private_subnet_6.id 
  
}