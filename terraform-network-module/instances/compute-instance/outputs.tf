
output "instances_self_links" {
  description = "List of self-links for compute instances"
  value       = google_compute_instance.compute_instance.*.self_link
}

output "instances_details" {
  description = "List of all details for compute instances"
  value       = google_compute_instance.compute_instance.*
}

output "instance_name" {
  description = "Name of the instance"
  value       = google_compute_instance.compute_instance.name
}

/*output "instance_ip" {
  description = "IP of the instance"
  value       = google_compute_address.static.address
}*/

output "private_ip" {
  value = google_compute_instance.compute_instance.network_interface.0.network_ip
}

