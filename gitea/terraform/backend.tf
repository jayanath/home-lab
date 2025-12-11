terraform {
  backend "s3" {
    key          = "proxmox/gitea/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
