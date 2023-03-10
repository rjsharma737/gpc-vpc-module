variable "project" {
  description = "The project ID"
}

variable "environment" {
  description = "The environment being deployed to"
}

variable "region" {
  description = "The region in which to create the VPC"
  default = "us-central1"
}

variable "create_subnet" {
  description = "Whether to create a subnet"
  default = true
}

variable "subnet_ip_cidr_range" {
  description = "The CIDR range for the subnet"
}

variable "create_secondary_ranges" {
  description = "Whether to create secondary ranges"
  default = true
}

variable "pod_range_cidr" {
  description = "The CIDR range for the pod IP range"
}

variable "svc_range_cidr" {
  description = "The CIDR range for the service IP range"
}

variable "enable_private_ip_google_access" {
  description = "Whether to enable private IP Google access for the subnet"
  default = true
}

variable "service_account_name" {
  description = "The name of the service account to create."
  default = devops-automationuser
}


