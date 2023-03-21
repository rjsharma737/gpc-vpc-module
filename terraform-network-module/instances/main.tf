resource "google_compute_instance" "instances" {
  count        = var.num_instances
  name         = var.instance_name[count.index]
  machine_type = var.machine_type
  tags         = ["cez-india-hq", "testvm"]
  boot_disk {
    initialize_params {
      size = var.boot_disk_size
      type = var.boot_disk_type
    }
  }
  metadata = {
    ssh-keys = "${var.ssh_username}:${var.ssh_public_key}"
  }
  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet_name
  }
  labels = {
    environment = var.environment
    user-name = var.user_name
    team-name = var.team_name
  }
  boot_disk_auto_delete = true
  scheduling {
    automatic_restart = false
  }

  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }
}
