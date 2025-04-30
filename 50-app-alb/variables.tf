variable "project" {
 default = "expense"
}

variable "environment" {
  default = "dev"
}


variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "zone_id" {
  default = "Z0903495IBCX9H53880M"
}

variable "domain_name" {
  default = "salearnings.tech"
}