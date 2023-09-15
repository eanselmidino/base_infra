variable "project_tags" {
  description = "tags del proyecto"
  type = object({
    env         = string
    owner       = string
    cloud       = string
    IAC         = string
    project     = string
    region      = string
    region-code = string
  })

  validation {
    condition     = contains(["dev", "prod", "stage"], var.project_tags.env) && lower(var.project_tags.env) == var.project_tags.env
    error_message = "Los posibles entornos son dev stage y prod escritos en minusculas"
  }
  validation {
    condition     = contains(["Terraform", "Cloudformation"], var.project_tags.IAC)
    error_message = "Los posibles IAC son Terraform o Cloudformation"
  }
}

variable "vpc" {
  description = "Valores de la VPC"
  type = object({
    cidr            = string
    public_subnets  = map(map(string))
    private_subnets = map(map(string))
    natgw_enable    = bool
  })
}
