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

variable "boot_disk" {
  description = "boot disk name"
  type        = string
}

variable "source_disk_snapshot" {
  description = "source disk snapshot name"
  type        = string
}

variable "source_disk_snapshot_external" {
  description = "source additional disk snapshot name"
  type        = string
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  default     = "10"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB"
  default     = "10"
}

variable "disk_labels" {
  description = "Labels to be assigned to boot disk, provided as a map"
  type        = map(string)
  default     = {}
}

variable "replica_zones" {
  type        = list(string)
  description = "replica zones"
  default     = []
}

variable "regional_disk" {
  description = "Regional/zonal disk is required: yes/no"
  type        = string
  default     = "yes"
}

