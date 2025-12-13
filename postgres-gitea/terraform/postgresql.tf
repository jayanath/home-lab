resource "proxmox_virtual_environment_container" "postgres" {
  node_name    = "pmox01"
  vm_id        = 125
  unprivileged = true

  operating_system {
    template_file_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    type             = "ubuntu"
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048 //MB
    swap      = 2048 //MB
  }

  disk {
    datastore_id = "ceph"
    size         = 40 // GB
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }
  initialization {
    ip_config {
      ipv4 {
        address = "192.168.193.90/24"
        gateway = "192.168.193.1"
      }
    }
    hostname = "pg-gitea"

    user_account {
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUEpEbTHkHDr7ayXK48FfSscRObEjZbklrb7E47IcJa lxc@1password"
      ]
    }
  }

  startup {
    order = 1
  }

  lifecycle {
    ignore_changes = [
      disk,
    ]
  }
}
