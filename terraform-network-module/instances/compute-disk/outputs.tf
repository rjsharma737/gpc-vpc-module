
output "disk_self_link" {
  description = "Name of the disk"
  value       = google_compute_disk.disk.self_link
}

output "addtional_disk_self_link" {
  description = "Name of the additional disk"
  value       = google_compute_disk.addtional_disk[*].self_link
}

output "addtional_regional_disk_self_link" {
  description = "Name of the additional disk"
  value       = google_compute_region_disk.addtional_disk[*].self_link
}
output "disk_name" {
  description = "Name of the disk"
  value       = google_compute_disk.disk.name
}

output "addtional_disk_name" {
  description = "Name of the additional disk"
  value       = google_compute_disk.addtional_disk[*].name
}

output "addtional_regional_disk_name" {
  description = "Name of the additional disk"
  value       = google_compute_region_disk.addtional_disk[*].name
}

