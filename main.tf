terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "3.39.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

variable "ip_hospedagem" {
  type = string
  description = "IP da hospedagem CPANEL do cliente"
}