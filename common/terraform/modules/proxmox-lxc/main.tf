resource "proxmox_lxc" "lxc" {
  target_node  = var.target_node
  hostname     = var.hostname
  ostemplate   = var.ostemplate
  unprivileged = var.unprivileged
  cores        = var.cores
  cpulimit     = var.cpulimit
  cpuunits     = var.cpuunits
  memory       = var.memory
  description  = var.description
  onboot       = var.onboot
  vmid         = var.vmid

  ssh_public_keys = var.ssh_public_keys

  // Terraform will crash without rootfs defined
  rootfs {
    storage = var.rootfs_storage
    size    = var.rootfs_size
  }

  network {
    name   = var.network_name
    bridge = var.network_bridge
    ip     = var.network_ip
  }
}
