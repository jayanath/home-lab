variable "target_node" {
  type        = string
  description = "A cluster node name for the LXC container to live"
}

variable "hostname" {
  type        = string
  description = "Host name of the container"
}

variable "ostemplate" {
  type        = string
  description = "The volume identifier of the OS template.(e.g. local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz)"
}

variable "cores" {
  type        = number
  description = "The number of cores assigned to the container"
}

variable "cpulimit" {
  type        = number
  description = "A number to limit CPU usage by"
}

variable "memory" {
  type        = number
  description = "A number containing the amount of RAM to assign to the container (in MB)"
}

variable "description" {
  type        = string
  description = "The container description seen in the web interface"
}

variable "ssh_public_keys" {
  type        = string
  description = "Multi-line string of SSH public keys that will be added to the container. Can be defined using heredoc syntax"
}

variable "rootfs_storage" {
  type        = string
  description = "A string containing the volume , directory, or device to be mounted into the container"
}

variable "rootfs_size" {
  type        = string
  description = "Size of the underlying volume"
}

variable "network_name" {
  type        = string
  description = "The name of the network interface as seen from inside the container (e.g. eth0)"
}

variable "network_bridge" {
  type        = string
  description = "The bridge to attach the network interface to (e.g. vmbr0)"
}

variable "network_ip" {
  type        = string
  description = "The IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation), dhcp, or manual"
}

variable "root_password" {
  type        = string
  description = "The root password inside the container"
}
