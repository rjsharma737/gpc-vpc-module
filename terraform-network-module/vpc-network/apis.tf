resource "google_project_service" "enable_apis" {
  project = var.project
service = {
  "compute.googleapis.com"             = {}
  "container.googleapis.com"           = {}
  "containerregistry.googleapis.com"   = {}
  "dns.googleapis.com"                 = {}
  "logging.googleapis.com"             = {}
  "monitoring.googleapis.com"          = {}
  "servicemanagement.googleapis.com"   = {}
  "sql-component.googleapis.com"       = {}
  "sqladmin.googleapis.com"            = {}
  "storage-api.googleapis.com"         = {}
}
