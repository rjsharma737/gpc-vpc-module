data "google_compute_network" "vpc_network" {
  name = var.vpc_network_name
}

resource "google_compute_instance" "instance" {
  count = var.instance_count

  name         = var.instance_names[count.index]
  machine_type = var.instance_machine_types[count.index]

  boot_disk {
    initialize_params {
      size  = var.instance_boot_disk_sizes[count.index]
      type  = var.instance_boot_disk_types[count.index]
      image = var.instance_image
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link
    access_config {
      // Ephemeral IP is not requested
    }
  }

  metadata = {
    ssh-keys = join("\n", var.instance_ssh_keys)
  }

  labels = var.instance_labels

  tags = var.network_tags

  lifecycle {
    ignore_changes = [      network_interface[0].subnetwork,
      labels,
      metadata,
      tags,
    ]
  }
}

resource "google_compute_disk" "boot_disk" {
  count = var.instance_count

  name  = "${google_compute_instance.instance[count.index].name}-boot-disk"
  type  = var.instance_boot_disk_types[count.index]
  zone  = data.google_compute_subnetwork.subnet.region
  size  = var.instance_boot_disk_sizes[count.index]
  image = var.instance_image

  depends_on = [google_compute_instance.instance]
}

data "google_compute_subnetwork" "subnet" {
  name    = var.subnet_name
  network = data.google_compute_network.vpc_network.self_link
}





/*
resource "google_compute_instance" "instance" {
  count = var.instance_count

  name         = var.instance_names[count.index]
  machine_type = var.instance_machine_types[count.index]
  zone         = data.google_compute_subnetwork.subnet.zone

  boot_disk {
    initialize_params {
      size  = var.instance_boot_disk_sizes[count.index]
      type  = var.instance_boot_disk_types[count.index]
      image = var.instance_image
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link

    access_config {
      // Ephemeral IP is not requested
    }
  }

  metadata = {
    ssh-keys = join("\n", var.instance_ssh_keys)
  }

  labels = var.instance_labels

  tags = var.network_tags

  lifecycle {
    ignore_changes = [network_interface.0.subnetwork,      labels,      metadata,      tags,    ]
  }
}

resource "google_compute_disk" "boot_disk" {
  count = var.instance_count

  name  = "${google_compute_instance.instance[count.index].name}-boot-disk"
  type  = var.instance_boot_disk_types[count.index]
  zone  = data.google_compute_subnetwork.subnet.zone
  size  = var.instance_boot_disk_sizes[count.index]
  image = var.instance_image

  #depends_on = [google_compute_instance.instance[count.index]]
  depends_on = [for instance in google_compute_instance.instance : instance]
}

data "google_compute_subnetwork" "subnet" {
  name   = var.subnet_name
  region = var.subnet_region
}

data "google_compute_zones" "zones" {
  region = var.subnet_region
}

*/
  
  
/*
resource "google_compute_instance" "instance" {
  count = var.instance_count

  name         = var.instance_names[count.index]
  machine_type = var.instance_machine_types[count.index]
  zone         = data.google_compute_subnetwork.subnet.zone

  boot_disk {
    initialize_params {
      size  = var.instance_boot_disk_sizes[count.index]
      type  = var.instance_boot_disk_types[count.index]
      image = var.instance_image
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link

    access_config {
      // Ephemeral IP is not requested
    }
  }

  metadata = {
    ssh-keys = join("\n", var.instance_ssh_keys)
  }

  labels = var.instance_labels

  tags = var.network_tags

  lifecycle {
    ignore_changes = [
      network_interface[0].subnetwork,
      labels,
      metadata,
      tags,
    ]

    delete {
      delete_disks = var.delete_disks_on_instance_delete
    }
  }
}

data "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.subnet_region
  depends_on    = [google_compute_instance.instance] # Wait for instances to be created
}

data "google_compute_zones" "zones" {
  region = var.subnet_region
}

*/


/*
##########################

# Load variables from .tfvars file

# Load variables from .tfvars file
locals {
  variables = merge(
    var,
    file("${path.module}/variables.tfvars"),
  )
}

resource "google_compute_instance" "instance" {
  count = local.variables.instance_count

  name         = local.variables.instance_names[count.index]
  machine_type = local.variables.instance_machine_types[count.index]
  zone         = data.google_compute_subnetwork.subnet.zone

  boot_disk {
    initialize_params {
      size  = local.variables.instance_boot_disk_sizes[count.index]
      type  = local.variables.instance_boot_disk_types[count.index]
      image = local.variables.instance_image
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link

    access_config {
      # Ephemeral IP is not requested
    }
  }

  metadata = {
    ssh-keys = join("\n", local.variables.instance_ssh_keys)
  }

  labels = local.variables.instance_labels

  tags = local.variables.network_tags

  lifecycle {
    ignore_changes = [
      network_interface[0].subnetwork,
      labels,
      metadata,
      tags,
    ]

    delete {
      delete_disks = local.variables.delete_disks_on_instance_delete
    }
  }
}

data "google_compute_subnetwork" "subnet" {
  name          = local.variables.subnet_name
  region        = local.variables.subnet_region
  depends_on    = [google_compute_instance.instance] # Wait for instances to be created
}

data "google_compute_zones" "zones" {
  region = local.variables.subnet_region
}


*/
###########################
