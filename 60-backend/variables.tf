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
