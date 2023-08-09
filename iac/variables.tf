# variables.tf

variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH Public Key"
  type        = string
}

variable "ssh_public_key_name" {
  description = "Name of public key"
  type = string
  default = "default"
}

variable "pupil-machine" {
  type        = map(any)
  description = "One Machine defintion for one pupil for the course"
  default = {
    name        = "pupil-01"
    server_type = "cx11"
    image       = "ubuntu-22.04"
    location    = "nbg1"
    backups     = false
  }
}

