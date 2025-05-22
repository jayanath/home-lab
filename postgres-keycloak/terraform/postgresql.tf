resource "proxmox_lxc" "postgres" {
  target_node  = "pmox01"
  hostname     = "pg-keycloak"
  ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  ostype       = "ubuntu"
  memory       = "2048"
  cpulimit     = "2"
  cores        = "2"
  swap         = "2048"
  vmid         = 110
  start        = true
  onboot       = true
  unprivileged = true

  ssh_public_keys = <<-EOT
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUEpEbTHkHDr7ayXK48FfSscRObEjZbklrb7E47IcJa lxc@1password
  EOT

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "ceph"
    size    = "10G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.193.60/32"
    gw     = "192.168.193.1"
  }

  lifecycle {
    ignore_changes = [
      rootfs
    ]
  }
}
