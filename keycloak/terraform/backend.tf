terraform {
  backend "s3" {
    key          = "proxmox/keycloak/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
