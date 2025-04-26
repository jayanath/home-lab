terraform {
  required_version = ">= 1.10"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 2.9.14"
    }
  }
}
