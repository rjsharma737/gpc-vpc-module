####################
# Instance disk creation
####################
resource "google_compute_disk" "disk" {
  name                      = var.boot_disk
  snapshot                  = var.source_disk_snapshot
  type                      = var.disk_type
  size                      = var.boot_disk_size_gb
  zone                      = var.zone
  physical_block_size_bytes = 4096
}

###############################
# Create zonal additional disk
###############################
resource "google_compute_disk" "addtional_disk" {
  count         = var.regional_disk != "yes" ? 1 : 0
  name          = "additional-${var.boot_disk}"
  type          = var.disk_type
  size          = var.disk_size_gb
  zone          = var.zone
  labels        = var.disk_labels
  snapshot      = var.source_disk_snapshot_external
}

##############################
# Create regional additional disk
##############################
resource "google_compute_region_disk" "addtional_disk" {
  count         = var.regional_disk == "yes" ? 1 : 0
  name          = "additional-${var.boot_disk}"
  type          = var.disk_type
  size          = var.disk_size_gb
  region        = var.region
  replica_zones = var.replica_zones
  //image = var.source_image
  labels        = var.disk_labels
  snapshot      = var.source_disk_snapshot_external
}
