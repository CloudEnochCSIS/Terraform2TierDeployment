variable "project_name" {}

variable "ami" {
  default = "ami-04e5276ebb8451442"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {}

variable "private_subnet_3" {}

variable "private_subnet_4" {}

variable "alb_target_group_arn" {}

variable "client_security_group" {}

variable "maximum_size" {
  default = 6
}
variable "minimum_size" {
  default = 2
}
variable "desired_capacity" {
  default = 3
}
variable "asg_health_check_type" {
  default = "ELB"
}