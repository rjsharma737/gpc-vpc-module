resource "google_project_service" "enable_apis" {
  project = var.project
  count   = length(var.apis)
  disable_on_destroy = false

  service = var.apis[count.index]
}
