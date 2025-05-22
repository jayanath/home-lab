terraform {
  backend "s3" {
    key          = "proxmox/postgres-keycloak/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

