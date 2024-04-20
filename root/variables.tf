
variable "project_name" {
  description = "The name of the project"
}

variable "region_name" {
  description = "The name of the region"

}

#variable "region" {}
variable "vpc_cidr" {}

variable "public_subnet_1_cidr" {}

variable "public_subnet_2_cidr" {}

variable "private_subnet_3_cidr" {}

variable "private_subnet_4_cidr" {}

variable "private_subnet_5_cidr" {}

variable "private_subnet_6_cidr" {}

variable "database_username" {}

variable "database_password" {}

variable "certificate_domain_name" {}

variable "additional_domain_name" {}