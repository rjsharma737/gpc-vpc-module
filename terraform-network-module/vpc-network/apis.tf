resource "google_project_service" "enable_apis" {
  project = var.project
  service = {
    "compute.googleapis.com"             = true
    "container.googleapis.com"           = true
    "containerregistry.googleapis.com"   = true
    "dns.googleapis.com"                 = true
    "logging.googleapis.com"             = true
    "monitoring.googleapis.com"          = true
    "servicemanagement.googleapis.com"   = true
    "sql-component.googleapis.com"       = true
    "sqladmin.googleapis.com"            = true
    "storage-api.googleapis.com"         = true
  }
}

