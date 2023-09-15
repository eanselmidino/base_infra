########### VPC ###########

vpc = {
  "cidr" = "10.50.0.0/16"
  "public_subnets" = {
    subnet_a = {
      az   = "us-east-1a"
      cidr = "10.50.0.0/24"
    }
    subnet_b = {
      az   = "us-east-1b"
      cidr = "10.50.1.0/24"
    }
    subnet_c = {
      az   = "us-east-1c"
      cidr = "10.50.2.0/24"
    }
  }
  "private_subnets" = {
    subnet_a = {
      az   = "us-east-1a"
      cidr = "10.50.50.0/24"
    }
    subnet_b = {
      az   = "us-east-1b"
      cidr = "10.50.51.0/24"
    }
    subnet_c = {
      az   = "us-east-1c"
      cidr = "10.50.52.0/24"
    }
    subnet_db_a = {
      az   = "us-east-1a"
      cidr = "10.50.100.0/24"
    }
    subnet_db_b = {
      az   = "us-east-1b"
      cidr = "10.50.101.0/24"
    }
    subnet_db_c = {
      az   = "us-east-1c"
      cidr = "10.50.102.0/24"
    }
  }
  "natgw_enable" = true
}


########### TAGS ###########

project_tags = {
  "env"         = "prod"
  "owner"       = "ceibus"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "project"     = "prontopago"
  "region"      = "virginia"
  "region-code" = "us-east-1"
}

