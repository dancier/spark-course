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

resource "hcloud_ssh_key" "ssh-key" {
  name = var.ssh_public_key_name
  public_key = file("~/.ssh/id_rsa.pub")
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


##### Pupil A

resource "hetznerdns_record" "pupil-a" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "pupil-a"
    value = hcloud_server.pupil-a.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "pupil-a-reverse" {
  server_id  = hcloud_server.pupil-a.id
  ip_address = hcloud_server.pupil-a.ipv4_address
  dns_ptr    = "pupil-a.bin-ich-tot.de"
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

##### Pupil Olli

resource "hetznerdns_record" "olli" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "olli"
    value = hcloud_server.olli.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "ollirevers" {
  server_id  = hcloud_server.olli.id
  ip_address = hcloud_server.olli.ipv4_address
  dns_ptr    = "olli.bin-ich-tot.de"
}


resource "hcloud_server" "olli" {
  name        = "olli"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}


#### Busy-Ellis

resource "hetznerdns_record" "busy-ellis" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "busy-ellis"
    value = hcloud_server.busy-ellis.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "busy-ellisrevers" {
  server_id  = hcloud_server.busy-ellis.id
  ip_address = hcloud_server.busy-ellis.ipv4_address
  dns_ptr    = "busy-ellis.bin-ich-tot.de"
}


resource "hcloud_server" "busy-ellis" {
  name        = "busy-ellis"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}

#### Amazing-Cannon

resource "hetznerdns_record" "amazing-cannon" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "amazing-cannon"
    value = hcloud_server.amazing-cannon.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "amazing-cannon" {
  server_id  = hcloud_server.amazing-cannon.id
  ip_address = hcloud_server.amazing-cannon.ipv4_address
  dns_ptr    = "amazing-cannon.bin-ich-tot.de"
}


resource "hcloud_server" "amazing-cannon" {
  name        = "amazing-cannon"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}


####	Heuristic-Joliot

resource "hetznerdns_record" "heuristic-joliot" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "heuristic-joliot"
    value = hcloud_server.heuristic-joliot.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "heuristic-joliot" {
  server_id  = hcloud_server.heuristic-joliot.id
  ip_address = hcloud_server.heuristic-joliot.ipv4_address
  dns_ptr    = "heuristic-joliot.bin-ich-tot.de"
}


resource "hcloud_server" "heuristic-joliot" {
  name        = "heuristic-joliot"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}


####	Gracious-Lewin

resource "hetznerdns_record" "gracious-lewin" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "gracious-lewin"
    value = hcloud_server.olli.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "gracious-lewin" {
  server_id  = hcloud_server.gracious-lewin.id
  ip_address = hcloud_server.gracious-lewin.ipv4_address
  dns_ptr    = "gracious-lewin.bin-ich-tot.de"
}


resource "hcloud_server" "gracious-lewin" {
  name        = "gracious-lewin"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}

####	Stupefied-Wilson

resource "hetznerdns_record" "stupefied-wilson" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "stupefied-wilson"
    value = hcloud_server.stupefied-wilson.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "stupefied-wilson" {
  server_id  = hcloud_server.stupefied-wilson.id
  ip_address = hcloud_server.stupefied-wilson.ipv4_address
  dns_ptr    = "stupefied-wilson.bin-ich-tot.de"
}


resource "hcloud_server" "stupefied-wilson" {
  name        = "stupefied-wilson"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}



####	Vigilant-Mayer

resource "hetznerdns_record" "vigilant-mayer" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "vigilant-mayer"
    value = hcloud_server.vigilant-mayer.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "vigilant-mayer" {
  server_id  = hcloud_server.vigilant-mayer.id
  ip_address = hcloud_server.vigilant-mayer.ipv4_address
  dns_ptr    = "vigilant-mayer.bin-ich-tot.de"
}


resource "hcloud_server" "vigilant-mayer" {
  name        = "vigilant-mayer"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}


####	Wizardly-Keldysh

resource "hetznerdns_record" "wizardly-keldysh" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "wizardly-keldysh"
    value = hcloud_server.wizardly-keldysh.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "wizardly-keldysh" {
  server_id  = hcloud_server.wizardly-keldysh.id
  ip_address = hcloud_server.wizardly-keldysh.ipv4_address
  dns_ptr    = "wizardly-keldysh.bin-ich-tot.de"
}


resource "hcloud_server" "wizardly-keldysh" {
  name        = "wizardly-keldysh"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}


####	Reverent-Einstein

resource "hetznerdns_record" "reverent-einstein" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "reverent-einstein"
    value = hcloud_server.reverent-einstein.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "reverent-einstein" {
  server_id  = hcloud_server.reverent-einstein.id
  ip_address = hcloud_server.reverent-einstein.ipv4_address
  dns_ptr    = "reverent-einstein.bin-ich-tot.de"
}


resource "hcloud_server" "reverent-einstein" {
  name        = "reverent-einstein"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}


####	Keen-Northcutt

resource "hetznerdns_record" "keen-northcutt" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "keen-northcutt"
    value = hcloud_server.keen-northcutt.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "keen-northcutt" {
  server_id  = hcloud_server.keen-northcutt.id
  ip_address = hcloud_server.keen-northcutt.ipv4_address
  dns_ptr    = "keen-northcutt.bin-ich-tot.de"
}


resource "hcloud_server" "keen-northcutt" {
  name        = "keen-northcutt"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}


####	Blissful-Euclid

resource "hetznerdns_record" "blissful-euclid" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "blissful-euclid"
    value = hcloud_server.blissful-euclid.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "blissful-euclid" {
  server_id  = hcloud_server.blissful-euclid.id
  ip_address = hcloud_server.blissful-euclid.ipv4_address
  dns_ptr    = "blissful-euclid.bin-ich-tot.de"
}


resource "hcloud_server" "blissful-euclid" {
  name        = "blissful-euclid"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}


####	Quizzical-Aryabhata

resource "hetznerdns_record" "quizzical-aryabhata" {
    zone_id = hetznerdns_zone.bin-ich-tot-de.id
    name = "quizzical-aryabhata"
    value = hcloud_server.quizzical-aryabhata.ipv4_address
    type = "A"
    ttl= 60
}

resource "hcloud_rdns" "quizzical-aryabhata" {
  server_id  = hcloud_server.quizzical-aryabhata.id
  ip_address = hcloud_server.quizzical-aryabhata.ipv4_address
  dns_ptr    = "quizzical-aryabhata.bin-ich-tot.de"
}


resource "hcloud_server" "quizzical-aryabhata" {
  name        = "quizzical-aryabhata"
  image       = var.pupil-machine.image
  server_type = var.pupil-machine.server_type
  location    = var.location
  backups     = var.pupil-machine.backups
  ssh_keys    = [var.ssh_public_key_name]
  user_data = templatefile("${path.module}/pupil-user-data.yaml", {})
}
