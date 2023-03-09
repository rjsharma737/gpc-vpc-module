output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "subnet_name" {
  value = local.subnet_name
}

output "subnet_cidr_block" {
  value = local.subnet_cidr
}

output "subnet_secondary_ranges" {
  value = jsonencode(local.subnet_secondary_ranges)
}

