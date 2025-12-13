terraform {
  backend "s3" {
    key          = "proxmox/postgres-gitea/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

