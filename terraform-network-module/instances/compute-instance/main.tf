
locals {
  addtional_disk = var.regional_disk == "yes" && var.backup_restore == "yes" ? "projects/${var.subnetwork_project}/regions/${var.region}/disks/${var.additional_disk_name}" : var.additional_disk_name
  gpu_enabled = var.gpu != null
  on_host_maintenance = (
    var.preemptible || var.enable_confidential_vm || local.gpu_enabled
    ? "TERMINATE"
    : var.on_host_maintenance
  )
}
resource "null_resource" "module_depends_on" {
  triggers = {
    value = length(var.module_depends_on)
  }
}
#############
# Instances
#############

resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = "internal-address-${var.hostname}"
  subnetwork   = var.subnetwork 
  address_type = "INTERNAL"
  region       = var.region
}

resource "google_compute_address" "static_public_ip" {
  count = var.public_static_ip == "no" ? 0 : 1
  name  = "external-address-${var.hostname}-${count.index}"
  address = var.public_static_ip == "yes" ? null: var.public_static_ip 
}

resource "google_compute_instance" "compute_instance" {
  provider = google
  //count    = local.num_instances
  name                      = var.hostname
  project                   = var.subnetwork_project
  zone                      = var.zone 
  allow_stopping_for_update = true
  machine_type              = var.machine_type
  labels                    = var.labels
  tags                      = var.tags
  can_ip_forward            = var.can_ip_forward
  metadata                  = var.metadata
  boot_disk {
    // Instance Templates reference disks by name, not self link
    source                = var.disk_name
    auto_delete           = var.auto_delete
  }
  
  attached_disk {
      source       = local.addtional_disk
  }

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
    network_ip         = google_compute_address.internal_with_subnet_and_address.address
    dynamic "access_config" {
      for_each = var.access_config
      content {
        nat_ip       = var.public_static_ip == "no" ? access_config.value.nat_ip: google_compute_address.static_public_ip[0].address
        network_tier = access_config.value.network_tier
      }
    }
  }
  
  scheduling {
    preemptible         = var.preemptible
    automatic_restart   = ! var.preemptible
    on_host_maintenance = local.on_host_maintenance
  }

  service_account {
    scopes = var.instance_scope
  }

 depends_on = [null_resource.module_depends_on]
}

