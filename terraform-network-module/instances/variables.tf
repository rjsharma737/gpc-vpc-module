variable "project" {
  description = "The project ID"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "subnet_name" {
  type    = string
}

variable "subnet_region" {
  type    = string
}

variable "instance_names" {
  type    = list(string)
}

variable "instance_machine_types" {
  type    = list(string)
  default = ["e2-medium"]
}


variable "instance_boot_disk_sizes" {
  type    = list(number)
}

variable "instance_boot_disk_types" {
  type    = list(string)
  default = ["SSD"]
}


variable "instance_ssh_keys" {
  type    = list(string)
}

variable "instance_image" {
  type    = string
}

variable "instance_labels" {
  type    = map(string)
}

variable "delete_disks_on_instance_delete" {
  type    = bool
  default = true
}

variable "network_tags" {
  type    = list(string)
}


variable "gce_ssh_user" {
  description = "username for ssh connection"
}

variable "gce_ssh_pub_key_file" {
  description = "public key for ssh connection"
}

variable "gce_ssh_private_key_file" {
  description = "private key for ssh connection"
  type        = string
  default     = "/tmp/gcp_key_greymatter"
}

variable "gce_ssh_user1" {
  description = "username for ssh connection"
  default = ""
}

variable "gce_ssh_pub_key_file1" {
  description = "public key for ssh connection"
}


