resource "google_project_service" "enable_apis" {
  project = var.project_id
  service = "container.googleapis.com"
  service = "cloudresourcemanager.googleapis.com"
  service = "redis.googleapis.com"
  service = "sqladmin.googleapis.com"
  service = "servicenetworking.googleapis.com"
  service = "dns.googleapis.com"
}
