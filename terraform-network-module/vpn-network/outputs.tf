output "vpn_gateway_public_ip" {
  value = google_compute_vpn_gateway.gateway.public_ip_address
}

output "vpn_gateway_interface0_ip" {
  value = google_compute_vpn_gateway.gateway.vpn_interface[0].ip_address
}

output "vpn_gateway_interface1_ip" {
  value = google_compute_vpn_gateway.gateway.vpn_interface[1].ip_address
}

output "vpn_gateway_tunnel1_address" {
  value = google_compute_vpn_tunnel.tunnel1.self_link
}

output "vpn_gateway_tunnel2_address" {
  value = google_compute_vpn_tunnel.tunnel2.self_link
}

output "vpn_gateway_tunnel1_remote_peer_ip" {
  value = google_compute_vpn_tunnel.tunnel1.peer_ip
}

output "vpn_gateway_tunnel2_remote_peer_ip" {
  value = google_compute_vpn_tunnel.tunnel2.peer_ip
}

output "vpn_gateway_tunnel1_shared_secret" {
  value = google_compute_vpn_tunnel.tunnel1.shared_secret
}

output "vpn_gateway_tunnel2_shared_secret" {
  value = google_compute_vpn_tunnel.tunnel2.shared_secret
}

output "vpn_gateway_tunnel1_local_traffic_selector" {
  value = google_compute_vpn_tunnel.tunnel1.local_traffic_selector
}

output "vpn_gateway_tunnel1_remote_traffic_selector" {
  value = google_compute_vpn_tunnel.tunnel1.remote_traffic_selector
}

output "vpn_gateway_tunnel2_local_traffic_selector" {
  value = google_compute_vpn_tunnel.tunnel2.local_traffic_selector
}

output "vpn_gateway_tunnel2_remote_traffic_selector" {
  value = google_compute_vpn_tunnel.tunnel2.remote_traffic_selector
}

output "cloud_router_bgp_ipv4" {
  value = google_compute_router.router.bgp[0].interface[0].ip_address
}

output "peer_router_bgp_ipv4" {
  value = google_compute_router.router.bgp[0].interface[0].peer_ip_address
}

output "peer_asn" {
  value = var.peer_asn
}

output "network_name" {
  value = var.network_name
}
