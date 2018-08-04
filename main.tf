variable "DIGITALOCEAN_API_TOKEN" {}
variable "IMAGE_BUILD_SIZE" {}
variable "IMAGE_BASE_IMAGE" {}
variable "IMAGE_REGION" {}
variable "IMAGE_SNAPSHOT_NAME" {}

provider "digitalocean" {
  token = "${var.DIGITALOCEAN_API_TOKEN}"
}

resource "digitalocean_floating_ip" "director_address" {
  droplet_id = "${digitalocean_droplet.director.id}"
  region     = "${digitalocean_droplet.director.region}"
}

resource "digitalocean_firewall" "www" {

  name = "www"

  droplet_ids = ["${digitalocean_droplet.director.id}"]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "80"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "443"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    }
  ],
  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "80"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "443"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

data "digitalocean_image" "director" {
  name = "${var.IMAGE_SNAPSHOT_NAME}"
}

resource "digitalocean_droplet" "director" {
  image  = "${data.digitalocean_image.director.image}"
  name   = "${var.IMAGE_SNAPSHOT_NAME}"
  region = "${var.IMAGE_REGION}"
  size   = "${var.IMAGE_BUILD_SIZE}"
}
