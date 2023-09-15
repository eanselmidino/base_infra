variable "vpc_cidr" {
  description = "CIDR Virginia"
  type        = string
}

variable "public_subnets" {
  description = "Lista de subnets publicas"
  type        = map(map(string))
}

variable "private_subnets" {
  description = "Lista de subnets privadas"
  type        = map(map(string))
}

variable "sufix" {
  description = "Sufijo para descripciones"
  type        = string
}

variable "natgw" {
  description = "Enable/Disable natgw"
  type        = bool
  default     = false
}




