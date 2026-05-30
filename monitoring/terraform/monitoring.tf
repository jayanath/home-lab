resource "proxmox_virtual_environment_container" "monitoring" {
  node_name    = "pmox01"
  vm_id        = 175
  unprivileged = true

  operating_system {
    template_file_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    type             = "ubuntu"
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096 // MB — InfluxDB + Loki need headroom
    swap      = 1024 // MB
  }

  disk {
    datastore_id = "ceph"
    size         = 32 // GB
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.193.30/24"
        gateway = "192.168.193.1"
      }
    }
    hostname = "monitoring"

    user_account {
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUEpEbTHkHDr7ayXK48FfSscRObEjZbklrb7E47IcJa lxc@1password"
      ]
    }
  }

  startup {
    order = 2 // after core infra, before dependent services
  }

  lifecycle {
    ignore_changes = [
      disk,
    ]
  }

  features {
    nesting = true
  }
}
