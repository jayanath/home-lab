terraform {
  backend "s3" {
    key          = "proxmox/vault/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
