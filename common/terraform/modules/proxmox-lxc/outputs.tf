output "lxc_vmid" {
  description = "The unique Proxmox VMID of the created LXC container"
  value       = proxmox_lxc.lxc.vmid
}

output "lxc_hostname" {
  description = "The hostname of the LXC container"
  value       = proxmox_lxc.lxc.hostname
}

output "lxc_target_node" {
  description = "The Proxmox node where the LXC container was created"
  value       = proxmox_lxc.lxc.target_node
}

output "lxc_ip_address" {
  description = "The IP address assigned to the LXC container (if configured)"
  value       = proxmox_lxc.lxc.network[0].ip
}

output "lxc_unprivileged" {
  description = "Indicates if the container is unprivileged"
  value       = proxmox_lxc.lxc.unprivileged
}
