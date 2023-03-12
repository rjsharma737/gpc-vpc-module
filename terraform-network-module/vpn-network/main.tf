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
  


/*

resource "google_compute_vpn_tunnel" "tunnel1" {
  name                = local.tunnel1_name
  peer_ip             = var.peer_ip1
  shared_secret       = var.shared_secret
  target_vpn_gateway  = google_compute_vpn_gateway.gateway.self_link
  ike_version         = 2
  peer_gateway_interface = local.intf0_name
  local_traffic_selector  = ["0.0.0.0/0"]
  remote_traffic_selector = ["192.168.0.0/19"]
  depends_on = [
    google_compute_vpn_gateway.gateway,
    google_compute_router.router
  ]
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name                = local.tunnel2_name
  peer_ip             = var.peer_ip2
  shared_secret       = var.shared_secret
  target_vpn_gateway  = google_compute_vpn_gateway.gateway.self_link
  ike_version         = 2
  peer_gateway_interface = local.intf1_name
  local_traffic_selector  = ["0.0.0.0/0"]
  remote_traffic_selector = ["192.168.0.0/19"]
  depends_on = [
    google_compute_vpn_gateway.gateway,
    google_compute_router.router
  ]
}

*/

  
provider "google" {
  project     = var.project
  region      = var.region
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
  vpn_type    = "HA"
  depends_on = [
    data.google_compute_network.network
  ]

  dynamic "vpn_interface" {
    for_each = var.vpn_peer_ips
    content {
      name        = "vpn-interface-${vpn_interface.key}"
      peer_ip     = vpn_interface.value
      shared_secret = var.shared_secret
    }
  }
}

resource "google_compute_vpn_tunnel" "tunnel" {
  count               = length(var.vpn_peer_ips)
  name                = "${var.project}-ha-vpn-tunnel_${count.index+1}"
  peer_ip             = var.vpn_peer_ips[count.index]
  shared_secret       = var.shared_secret
  target_vpn_gateway  = google_compute_vpn_gateway.gateway.self_link
  ike_version         = 2
  local_traffic_selector {
    ip_ranges = ["10.0.1.0/24"]
  }
  remote_traffic_selector {
    ip_ranges = ["192.168.1.0/24"]
  }
  dynamic "vpn_gateway_interface" {
    for_each = [0, 1]
    content {
      id = google_compute_vpn_gateway.gateway.vpn_interfaces[vpn_gateway_interface.value].id
    }
  }
}

resource "google_compute_router" "router" {
  name    = local.cloud_router
  network = data.google_compute_network.network.self_link
  bgp {
    asn                   = var.router_asn
    advertise_mode        = "CUSTOM"
    advertise_ip_ranges   = ["10.0.0.0/8"]
    advertised_route_priority = 1000
    dynamic "peer" {
      for_each = var.vpn_peer_ips
      content {
        ip_address = peer.value
      }
    }
  }
}

resource "google_compute_router_interface" "router_interface" {
  router    = google_compute_router.router.name
  ip_address = "169.254.0.1"
  network   = data.google_compute_network.network.self_link
}

resource "google_compute_bgp_peering" "bgp_peering" {
  count    = length(var.vpn_peer_ips)
  name     = "${var.project}-bgp-session${count.index+1}"
  router   = google_compute_router.router.name
  interface_name = google_compute_router_interface.router_interface.name
  peer_ip_address = var.vpn_peer_ips[count.index]
  peer_asn = var.vpn_peer_asn
  advertised_route_priority = 1000
}


