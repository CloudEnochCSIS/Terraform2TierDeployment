output "application_load_balancer_sg" {
    value = aws_security_group.alb_sg.id 
  
}

output "client_security_group" {
    value = aws_security_group.client_sg.id
  
}

output "database_security_group" {
    value = aws_security_group.db_sg.id
  
}
output "bastion_host_security_group" {
    value = aws_security_group.bastion_sg.id   
}