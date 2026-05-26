terraform {
  backend "s3" {
    key          = "proxmox/lms/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
