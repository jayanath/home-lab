terraform {
  backend "s3" {
    key     = "proxmox/traefik/terraform.tfstate"
    encrypt = true
  }
}
