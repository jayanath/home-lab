module "traefik_container" {
  source      = "../../common/terraform/modules/proxmox-lxc"
  target_node = var.target_node
  hostname    = var.hostname
  ostemplate  = var.ostemplate
  cores       = var.cores
  cpulimit    = var.cpulimit
  memory      = var.memory
  description = var.description

  ssh_public_keys = var.ssh_public_keys

  rootfs_storage = var.rootfs_storage
  rootfs_size    = var.rootfs_size

  network_name   = var.network_name
  network_bridge = var.network_bridge
  network_ip     = var.network_ip
}
