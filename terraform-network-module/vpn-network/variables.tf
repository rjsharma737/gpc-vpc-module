variable "project" {
  description = "The ID of the project in which the resources will be created."
}

variable "region" {
  description = "The region in which the resources will be created."
}

variable "network_name" {
  description = "The name of the VPC network that the VPN gateway will be attached to."
}

variable "peer_ip1" {
  description = "The public IP address of the first VPN peer gateway."
}

variable "peer_ip2" {
  description = "The public IP address of the second VPN peer gateway."
}

variable "shared_secret" {
  description = "The shared secret used to establish the VPN tunnel."
}

variable "peer_asn" {
  description = "The ASN of the VPN peer."
}

variable "cloud_router_bgp_ipv4" {
  description = "The IPv4 address of the BGP interface of the cloud router."
}

variable "peer_router_bgp_ipv4" {
  description = "The IPv4 address of the BGP interface of the peer router."
}
