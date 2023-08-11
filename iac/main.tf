terraform {
  required_providers {
    hcloud = {
        source = "hetznercloud/hcloud"
    }
    hetznerdns = {
      source = "timohirt/hetznerdns"
      version = "2.1.0"
    }
  }
  required_version = ">= 1.0"
}

variable "hetznerdns_token" {}

provider "hetznerdns" {
  apitoken = var.hetznerdns_token
}

provider "hcloud" {
  token = var.hcloud_token
}

# https://github.com/timohirt/terraform-provider-hetznerdns
# attention: this deleted the whole zone after a destroy!
# this was not a problem as bin-ich-tot.de is almos dead.
# but we should take care to know how to use this module with a 
# production zone
resource "hetznerdns_zone" "bin-ich-tot-de" {
  name = "bin-ich-tot.de"
  ttl  = 60
}

resource "hetznerdns_record" "pupil-a" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "pupil-a"
    value = hcloud_server.pupil-a.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "master" {
  server_id  = hcloud_server.pupil-a.id
  ip_address = hcloud_server.pupil-a.ipv4_address
  dns_ptr    = "pupil-a.bin-ich-tot.de"
}

resource "hcloud_ssh_key" "ssh-key" {
  name = var.ssh_public_key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "hcloud_server" "pupil-a" {
  name        = "pupil-a"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}

output "pupil-a-ip" {
  value = hcloud_server.pupil-a.ipv4_address
}