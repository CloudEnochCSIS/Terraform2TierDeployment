resource "aws_db_subnet_group" "private-subnets" {
  name       = var.database_subnet_name
  subnet_ids = [var.private_subnet_5, var.private_subnet_6] # Replace with your private subnet IDs
}

resource "aws_db_instance" "private-db" {
  identifier              = "private-db"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = var.database_username
  password                = var.database_password
  db_name                 = var.database_name
  multi_az                = true
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0

  vpc_security_group_ids = [var.database_security_group] # Replace with your desired security group ID

  db_subnet_group_name = aws_db_subnet_group.private-subnets.name

  tags = {
    Name = "Wedding-db"
  }
}