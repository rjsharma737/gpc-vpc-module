output "instance_self_links" {
  value = google_compute_instance.instance.*.self_link
}

output "instance_ips" {
  value = google_compute_instance.instance.*.network_interface.0.network_ip
}
