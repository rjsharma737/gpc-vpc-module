/*This code creates a Google Cloud Platform (GCP) network, subnet, 
 and secondary IP ranges. It uses the locals block to define some variables, including the subnet name, subnet
 CIDR range, and the names and CIDR ranges for the secondary IP ranges. The google_compute_network resource 
 creates the GCP VPC network, and the google_compute_subnetwork resource creates the subnet. 
 The google_compute_subnetwork_secondary_range resources create the secondary IP ranges if they have been defined.
 The count parameteris used to conditionally create resources based on the values of input variables.
 */

locals {
  subnet_name = "${var.project}-${var.environment}-subnet"
  subnet_cidr = var.create_subnet ? var.subnet_ip_cidr_range : null
  pod_range_name = "${var.project}-${var.environment}-pod-range"
  svc_range_name = "${var.project}-${var.environment}-svc-range"
  pod_range_cidr = var.create_secondary_ranges ? var.pod_range_cidr : null
  svc_range_cidr = var.create_secondary_ranges ? var.svc_range_cidr : null
  subnet_secondary_ranges = var.create_secondary_ranges ? {
    pod_range_cidr = var.pod_range_cidr
    svc_range_cidr = var.svc_range_cidr
  } : null
}

resource "google_compute_network" "vpc" {
  name                    = "${var.project}-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  count                    = var.create_subnet ? 1 : 0
  name                     = local.subnet_name
  region                   = var.region
  network                  = google_compute_network.vpc.self_link
  ip_cidr_range            = local.subnet_cidr
  #secondary_ip_range       = local.subnet_secondary_ranges 
  private_ip_google_access = var.enable_private_ip_google_access
}
/*
resource "google_compute_subnetwork_secondary_range" "pod_range" {
  count           = local.pod_range_cidr != null ? 1 : 0
  name            = local.pod_range_name
  subnetwork      = google_compute_subnetwork.subnet.self_link
  ip_cidr_range   = local.pod_range_cidr
}

resource "google_compute_subnetwork_secondary_range" "svc_range" {
  count           = local.svc_range_cidr != null ? 1 : 0
  name            = local.svc_range_name
  subnetwork      = google_compute_subnetwork.subnet.self_link
  ip_cidr_range   = local.svc_range_cidr
}
  */


  
resource "google_compute_subnetwork_internal_ip_range" "pod_range" {
  subnetwork       = google_compute_subnetwork.subnet.self_link
  name            = local.pod_range_name
  ip_cidr_range    = var.pod_range_secondary_ip_range
  private_ip_google_access = true
}

resource "google_compute_subnetwork_internal_ip_range" "svc_range" {
  subnetwork       = google_compute_subnetwork.subnet.self_link
  name            = local.svc_range_name
  ip_cidr_range    = var.svc_range_secondary_ip_range
  private_ip_google_access = true
}

