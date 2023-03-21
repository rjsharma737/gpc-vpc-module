variable "project" {
  description = "The project ID"
}

variable "region" {
  description = "The region where the instances will be created."
}

variable "num_instances" {
  description = "The number of instances to create."
}

variable "instance_name" {
  description = "The names of the instances to create."
  type        = list(string)
}

variable "machine_type" {
  description = "The machine type to use for the instances."
}

variable "vpc_name" {
  description = "The name of the VPC to create the instances in."
}

variable "subnet_name" {
  description = "The name of the subnet to create the instances in."
}

variable "ssh_username" {
  description = "The SSH username to use for connecting to the instances."
}

variable "ssh_public_key" {
  description = "The SSH public key to use for connecting to the instances."
}

variable "boot_disk_size" {
  description = "The size of the boot disk for the instances."
}

variable "boot_disk_type" {
  description = "The type of the boot disk for the instances. Use 'pd-ssd' for SSD persistent disk and 'pd-standard' for balanced persistent disk."
}

variable "environment" {
  description = "The environment label for the instances."
}

variable "user_name" {
  description = "The user name label for the instances."
}

variable "team_name" {
  description = "The team name label for the instances."
}

variable "image_name" {
  description = "The name of the image to use for the instances."
}


/*
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
*/

