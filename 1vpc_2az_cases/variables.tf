variable "region" {
  default = "ap-northeast-1"
}

variable "aws_profile" {
  default = "783764604912_AdministratorAccess"
}

variable "vpc_name" {
  default = "ohg-info-stg"
}

variable "cidr_block" {
  default = "10.190.1.0/24"
}

variable "availability_zones" {
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "public_subnet_cidrs" {
  default = ["10.190.1.0/28", "10.190.1.16/28"]
}

variable "ec2_subnet_cidrs" {
  default = ["10.190.1.32/28", "10.190.1.48/28"]
}

variable "rds_subnet_cidrs" {
  default = ["10.190.1.64/28", "10.190.1.80/28"]
}
