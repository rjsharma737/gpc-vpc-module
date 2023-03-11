#roles for serivce account within the project
resource "google_project_iam_member" "compute_network_admin" {
  project = var.project
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "cloud_sql_admin" {
  project = var.project
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "owner" {
  project = var.project
  role    = "roles/owner"
  member  = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}

#compute admin and compute storage admin IAM role to service account
resource "google_project_iam_member" "compute_admin" {
  project = "greymatter-development"
  role    = "roles/compute.admin"
  member  = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "compute_storage_admin" {
  project = "greymatter-development"
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}


#Storage Admin and Storage Object Viewer permission for newly created service account into buckets
resource "google_storage_bucket_iam_member" "asia_artifacts_viewer" {
  bucket = "asia.artifacts.greymatter-development.appspot.com"
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}

resource "google_storage_bucket_iam_member" "asia_artifacts_admin" {
  bucket = "asia.artifacts.greymatter-development.appspot.com"
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}

resource "google_storage_bucket_iam_member" "us_artifacts_viewer" {
  bucket = "us.artifacts.greymatter-development.appspot.com"
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}

resource "google_storage_bucket_iam_member" "us_artifacts_admin" {
  bucket = "us.artifacts.greymatter-development.appspot.com"
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
}


#roles for bucket terraform-dev-statefiles
resource "google_storage_bucket_iam_binding" "terraform_statefiles_object_admin" {
  bucket = "terraform-dev-statefiles"
  role   = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
  ]
}

resource "google_storage_bucket_iam_binding" "terraform_statefiles_admin" {
  bucket = "terraform-dev-statefiles"
  role   = "roles/storage.admin"

  members = [
    "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
  ]
}

#roles for bucket greymatter-jenkins-backupfiles
resource "google_storage_bucket_iam_binding" "jenkins_backupfiles_admin" {
  bucket = "greymatter-jenkins-backupfiles"
  role   = "roles/storage.admin"

  members = [
    "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
  ]
}

resource "google_storage_bucket_iam_binding" "jenkins_backupfiles_object_admin" {
  bucket = "greymatter-jenkins-backupfiles"
  role   = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
  ]
}

/*
#owner role in project gm-prod-common-services
resource "google_project_iam_binding" "owner" {
  project = "gm-prod-common-services"
  role    = "roles/owner"
    members = [
    "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
  ]
}
*/
