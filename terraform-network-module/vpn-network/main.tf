provider "google" {
  project = var.project
  region  = var.region
}

data "google_compute_network" "network" {
  name = var.network_name
}

locals {
  tunnel1_name    = "${var.project}_ha_vpn_tunnel_1"
  tunnel2_name    = "${var.project}_ha_vpn_tunnel_2"
  gateway_name    = "${var.project}_ha_vpn_gateway"
  intf0_name      = "${var.project}_ha_vpn_gateway_interface0"
  intf1_name      = "${var.project}_ha_vpn_gateway_interface1"
  peer_gw_name    = "${var.project}_ha_vpn_peer_gateway"
  cloud_router    = "${var.project}_ha_vpn_cloud_router"
  bgp_session1    = "${var.project}_bgp_session1"
  bgp_session2    = "${var.project}_bgp_session2"
}

resource "google_compute_vpn_gateway" "gateway" {
  name        = local.gateway_name
  network     = data.google_compute_network.network.self_link
  description = "VPN setup for HQ."
  labels = {
    owner = "terraform"
  }

  depends_on = [
    data.google_compute_network.network
  ]

  vpn_interface {
    name        = local.intf0_name
    peer_ip     = var.peer_ip1
    shared_secret = var.shared_secret
  }

  vpn_interface {
    name        = local.intf1_name
    peer_ip     = var.peer_ip2
    shared_secret = var.shared_secret
  }
}

resource "google_compute_vpn_tunnel" "tunnel1" {
  name          = local.tunnel1_name
  peer_ip       = var.peer_ip1
  shared_secret = var.shared_secret
  target_vpn_gateway = google_compute_vpn_gateway.gateway.self_link
  local_traffic_selector = ["172.16.0.0/16"]
  remote_traffic_selector = ["192.168.0.0/16"]
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name          = local.tunnel2_name
  peer_ip       = var.peer_ip2
  shared_secret = var.shared_secret
  target_vpn_gateway = google_compute_vpn_gateway.gateway.self_link
  local_traffic_selector = ["172.16.0.0/16"]
  remote_traffic_selector = ["10.0.0.0/8"]
}

resource "google_compute_router" "router" {
  name    = local.cloud_router
  network = google_compute_network.network.self_link

  bgp {
    asn               = var.peer_asn
    advertise_mode    = "CUSTOM"
    advertised_route_priority = 100

    interface {
      name               = local.intf0_name
      ip_address         = var.cloud_router_bgp_ipv4
      peer_ip_address    = var.peer_router_bgp_ipv4
    }

    interface {
      name               = local.intf1_name
      ip_address         = var.cloud_router_bgp_ipv4
      peer_ip_address    = var.peer_router_bgp_ipv4
    }

    bgp_session {
      name            = local.bgp_session1
      peer_ip_address = var.peer_router_bgp_ipv4
      interface_name  = local.intf0_name
      #advertised_route_priority = 100
      bfd             = {
        session_initiation_mode = "DISABLED"
      }
    }

    bgp_session {
      name            = local.bgp_session2
      peer_ip_address = var.peer_router_bgp_ipv4
      interface_name  = local.intf1_name
      #advertised_route_priority = 100
      bfd             = {
        session_initiation_mode = "DISABLED"
      }
    }
  }
}

output "vpn_gateway_public_ip" {
  value = google_compute_vpn_gateway.gateway.public_ip_address
}
