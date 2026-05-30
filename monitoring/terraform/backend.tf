terraform {
  backend "s3" {
    key          = "proxmox/monitoring/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
