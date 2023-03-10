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
  type    = string
  default = ""
}

variable "svc_range_cidr" {
  type    = string
  default = ""
}

variable "enable_private_ip_google_access" {
  description = "Whether to enable private IP Google access for the subnet"
  default = true
}

variable "service_account_name" {
  description = "The name of the service account to create."
}

variable "apis" {
  type = list(string)

  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "dns.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "servicemanagement.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "storage-api.googleapis.com",
  ]
}







