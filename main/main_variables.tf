variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "database_enabled" {
  type    = bool
  default = false
}

variable "server_prompt_enabled" {
  type    = bool
  default = false
}

variable "bastion_enabled" {
  type    = bool
  default = false
}

variable "vpn_enabled" {
  type    = bool
  default = false
}

variable "ubuntu_ami" {
  type        = string
  description = "The AMI ID for the Ubuntu image"
  default     = "ami-0a0b7b240264a48d7"
}