
variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = ""
}

variable "hostname" {
  description = "Hostname of instances"
  default     = ""
}

variable "region" {
  type        = string
  description = "Region where the instances should be created."
  default     = null
}

variable "zone" {
  type        = string
  description = "Zone where the instances should be created. If not specified, instances will be spread across available zones in the region."
  default     = null
}

variable "machine_type" {
  description = "Machine type to create, e.g. n1-standard-1"
  default     = "n1-standard-1"
}

variable "can_ip_forward" {
  description = "Enable IP forwarding, for NAT instances for example"
  default     = "false"
}

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}
variable "preemptible" {
  type        = bool
  description = "Allow the instance to be preempted"
  default     = false
}

variable "on_host_maintenance" {
  type        = string
  description = "Instance availability Policy"
  default     = "MIGRATE"
}

variable "metadata" {
  type        = map(string)
  description = "Metadata, provided as a map"
  default     = {}
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  default     = "10"
}

variable "disk_labels" {
  description = "Labels to be assigned to boot disk, provided as a map"
  type        = map(string)
  default     = {}
}

variable "disk_encryption_key" {
  description = "The self link of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance"
  type        = string
  default     = null
}

variable "auto_delete" {
  description = "Whether or not the boot disk should be auto-deleted"
  default     = "true"
}

variable "gpu" {
  description = "GPU information. Type and count of GPU to attach to the instance template. See https://cloud.google.com/compute/docs/gpus more details"
  type = object({
    type  = string
    count = number
  })
  default = null
}

variable "enable_confidential_vm" {
  default     = false
  description = "Whether to enable the Confidential VM configuration on the instance. Note that the instance image must support Confidential VMs. See https://cloud.google.com/compute/docs/images"
}

variable "module_depends_on" {
  description = "List of modules or resources this module depends on"
  type        = list(any)
  default     = []
}

variable "disk_name" {
  description = "disk name"
  default     = ""
}

variable "additional_disk_name" {
  description = "additional disk name"
  default     = ""
}

variable "regional_disk" {
  description = "Regional/zonal disk is required (Input yes/no)"
  type        = string
  default     = "yes"
}

variable "backup_restore" {
  description = "restore from existing backup (Input yes/no)"
  default     = "no"
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "public_static_ip" {
  description = "public ip for vm"
  default     = "no"
}

variable "instance_scope" {
  type        = list(string)
  description = "Instance Scope"
  default     = []
}
