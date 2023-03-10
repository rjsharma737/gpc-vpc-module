resource "google_project_service" "enable_apis" {
  project = var.project
  count   = length(var.apis)

  service = var.apis[count.index]
}
