variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "database_enabled" {
  type    = bool
  default = false
}

variable "bastion_enabled" {
  type    = bool
  default = false
}
