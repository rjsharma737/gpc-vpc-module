resource "google_project_service" "enable_apis" {
  project = var.project

  service = [
    "container.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "redis.googleapis.com",
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com",
    "dns.googleapis.com",
  ]
}