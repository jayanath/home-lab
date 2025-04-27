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

variable "unprivileged" {
  type        = bool
  description = "Run the container as an unprivileged user"
  default     = true
}

variable "cores" {
  type        = number
  description = "The number of cores assigned to the container"
  default     = 1
}

variable "cpulimit" {
  type        = number
  description = "A number to limit CPU usage by"
  default     = 1
}

variable "cpuunits" {
  type        = number
  description = "A number of the CPU weight that the container possesses"
  default     = 100
}

variable "memory" {
  type        = number
  description = "A number containing the amount of RAM to assign to the container (in MB)"
  default     = 512
}

variable "description" {
  type        = string
  description = "The container description seen in the web interface"
  default     = "lxc-container"
}

variable "onboot" {
  type        = bool
  description = "A boolean that determines if the container will start on boot"
  default     = true
}

variable "start" {
  type        = bool
  description = "A boolean that determines if the container is started after creation"
  default     = true
}

variable "vmid" {
  type        = number
  description = "A number that sets the VMID of the container"
  default     = 0 # this tells the system to use next available VMID
}

variable "ssh_public_keys" {
  type        = string
  description = "Multi-line string of SSH public keys that will be added to the container. Can be defined using heredoc syntax"
  default     = "NONE"
}

variable "rootfs_storage" {
  type        = string
  description = "A string containing the volume , directory, or device to be mounted into the container"
}

variable "rootfs_size" {
  type        = string
  description = "Size of the underlying volume"
  default     = "10G"
}

variable "network_name" {
  type        = string
  description = "The name of the network interface as seen from inside the container (e.g. eth0)"
  default     = "eth0"
}

variable "network_bridge" {
  type        = string
  description = "The bridge to attach the network interface to (e.g. vmbr0)"
  default     = "vmbr0"
}

variable "network_ip" {
  type        = string
  description = "The IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation), dhcp, or manual"
}

variable "root_password" {
  type        = string
  description = "The root password inside the container"
}
