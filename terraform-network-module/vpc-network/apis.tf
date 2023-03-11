resource "google_project_service" "enable_apis" {
  project = var.project
  #count   = length(var.apis)
  count = var.enable_api_services ? length(var.apis) : 0

  service = var.apis[count.index]
}
