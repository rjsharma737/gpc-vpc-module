/*
provider "google" {
  project = var.project
  region  = var.region
}

data "google_compute_network" "network" {
  name = var.network_name
}

locals {
  tunnel1_name    = "${var.project}-ha-vpn-tunnel-1"
  tunnel2_name    = "${var.project}-ha-vpn-tunnel-2"
  gateway_name    = "${var.project}-ha-vpn-gateway"
  intf0_name      = "${var.project}-ha-vpn-gateway-interface0"
  intf1_name      = "${var.project}-ha-vpn-gateway-interface1"
  peer_gw_name    = "${var.project}-ha-vpn-peer-gateway"
  cloud_router    = "${var.project}-ha-vpn-cloud-router"
  bgp_session1    = "${var.project}-bgp-session1"
  bgp_session2    = "${var.project}-bgp-session2"
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
  #local_traffic_selector = [""]
  #remote_traffic_selector = ["192.168.0.0/19"]
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name          = local.tunnel2_name
  peer_ip       = var.peer_ip2
  shared_secret = var.shared_secret
  target_vpn_gateway = google_compute_vpn_gateway.gateway.self_link
  #local_traffic_selector = [""]
  #remote_traffic_selector = ["192.168.0.0/19"]
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
      advertised_route_priority = 100
      bfd             = {
        session_initiation_mode = "DISABLED"
      }
    }

    bgp_session {
      name            = local.bgp_session2
      peer_ip_address = var.peer_router_bgp_ipv4
      interface_name  = local.intf1_name
      advertised_route_priority = 100
      bfd             = {
        session_initiation_mode = "DISABLED"
      }
    }
  }
}
*/
  



provider "google" {
  project = var.project
  region  = var.region
}

data "google_compute_network" "network" {
  name = var.network_name
}

locals {
  tunnel1_name    = "${var.project}-ha-vpn-tunnel-1"
  tunnel2_name    = "${var.project}-ha-vpn-tunnel-2"
  gateway_name    = "${var.project}-ha-vpn-gateway"
  intf0_name      = "${var.project}-ha-vpn-gateway-interface0"
  intf1_name      = "${var.project}-ha-vpn-gateway-interface1"
  peer_gw_name    = "${var.project}-ha-vpn-peer-gateway"
  cloud_router    = "${var.project}-ha-vpn-cloud-router"
  bgp_session1    = "${var.project}-bgp-session1"
  bgp_session2    = "${var.project}-bgp-session2"
}

resource "google_compute_vpn_gateway" "gateway" {
  name        = local.gateway_name
  network     = data.google_compute_network.network.self_link
  description = "VPN setup for HQ."

  depends_on = [
    data.google_compute_network.network
  ]

  dynamic "vpn_interface" {
    for_each = var.vpn_interfaces
    content {
      name            = vpn_interface.value.name
      peer_ip         = vpn_interface.value.peer_ip
      shared_secret   = vpn_interface.value.shared_secret
    }
  }
}

resource "google_compute_vpn_gateway_interface" "intf0" {
  name                  = local.intf0_name
  gateway               = google_compute_vpn_gateway.gateway.self_link
  ip_address            = var.gateway_interface0_ip
  peer_ip_address       = var.peer_gateway_interface0_ip
  shared_secret         = var.shared_secret1
}

resource "google_compute_vpn_gateway_interface" "intf1" {
  name                  = local.intf1_name
  gateway               = google_compute_vpn_gateway.gateway.self_link
  ip_address            = var.gateway_interface1_ip
  peer_ip_address       = var.peer_gateway_interface1_ip
  shared_secret         = var.shared_secret2
}

resource "google_compute_resource_label" "gateway_labels" {
  name    = google_compute_vpn_gateway.gateway.name
  labels = {
    owner = "terraform"
  }
}

resource "google_compute_vpn_tunnel" "tunnel1" {
  name                  = local.tunnel1_name
  peer_ip               = var.peer_gw_interface0_ip
  shared_secret         = var.shared_secret
  shared_secret_hash    = var.shared_secret1_hash
  #local_traffic_selector = ["0.0.0.0/0"]
  #remote_traffic_selector = ["0.0.0.0/0"]
  target_vpn_gateway    = google_compute_vpn_gateway.gateway.self_link
  depends_on = [
    google_compute_vpn_gateway.gateway
  ]
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name                  = local.tunnel2_name
  peer_ip               = var.peer_gw_interface1_ip
  shared_secret         = var.shared_secret
  shared_secret_hash    = var.shared_secret2_hash
  #local_traffic_selector = ["0.0.0.0/0"]
  #remote_traffic_selector = ["0.0.0.0/0"]
  target_vpn_gateway    = google_compute_vpn_gateway.gateway.self_link
  depends_on = [
    google_compute_vpn_gateway.gateway
  ]
}

resource "google_compute_router" "router" {
  name    = local.cloud_router
  network = data.google_compute_network.network.self_link

  bgp {
    asn    = var.bgp_asn
    advertise_mode = "CUSTOM"
    advertised_route_priority = "100"
  }

  dynamic "bgp_session" {
    for_each = var.bgp_sessions
    content {
      name           = bgp_session.value.name
      interface_name = bgp_session.value.interface_name
      peer_ip        = bgp_session.value.peer_ip
      peer_asn       = bgp_session.value.peer_asn
    }
  }
}

resource "google_compute_router_interface" "router_interface" {
  name    = "vpn-tunnel-interface"
  router  = google_compute_router.router.self_link
  ip_range = var.router_interface_ip_range
  linked_vpn_tunnel = google_compute_vpn_tunnel.tunnel.*.self_link
}

resource "google_compute_router_bgp_peer" "peer" {
  name                = "peer-hq-vpn"
  router              = google_compute_router.router.self_link
  peer_ip_address     = var.peer_gateway_interface1_ip
  peer_asn            = var.peer_asn
  interface_name      = google_compute_router_interface.router_interface.name
  advertise_mode      = "CUSTOM"
  advertised_route_priority = "100"

  dynamic "advertised_route" {
    for_each = var.advertised_routes
    content {
      description  = advertised_route.value.description
      destination  = advertised_route.value.destination
      next_hop_self = advertised_route.value.next_hop_self
      metric       = advertised_route.value.metric
    }
  }
}




