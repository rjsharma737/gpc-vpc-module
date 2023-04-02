# Define a map of roles with their corresponding members
locals {
  iam_roles = {
    "compute_network_admin" = "roles/compute.networkAdmin",
    "cloud_sql_admin" = "roles/cloudsql.admin",
    "owner" = "roles/owner",
    "compute_admin" = "roles/compute.admin",
    "compute_storage_admin" = "roles/compute.storageAdmin",
  }
  
  storage_roles = {
    "asia_artifacts_viewer" = "roles/storage.objectViewer",
    "asia_artifacts_admin" = "roles/storage.admin",
    "us_artifacts_viewer" = "roles/storage.objectViewer",
    "us_artifacts_admin" = "roles/storage.admin",
    "terraform_statefiles_object_admin" = "roles/storage.objectAdmin",
    "terraform_statefiles_admin" = "roles/storage.admin",
    "jenkins_backupfiles_admin" = "roles/storage.admin",
    "jenkins_backupfiles_object_admin" = "roles/storage.objectAdmin",
  }
  
  bucket_names = [
    "asia.artifacts.greymatter-development.appspot.com",
    "us.artifacts.greymatter-development.appspot.com",
    "terraform-dev-statefiles",
    "greymatter-jenkins-backupfiles",
  ]

  service_accounts = [
    "devops-automationuser@cez-india.iam.gserviceaccount.com",
    "devops-automationuser@gm-dev-tompkins-integration.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-apotek.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-coupangdaegu.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-dafiti.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-dillard.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-evergreen.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-hmcanada.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-llbean.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-macys.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-robinson.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-walmart-mexico.iam.gserviceaccount.com",
    "devops-automationuser@gm-prod-walmartca.iam.gserviceaccount.com",
    "devops-automationuser@gor-simulation.iam.gserviceaccount.com",
    "devops-automationuser@greymatter-go5.iam.gserviceaccount.com",
    "devops-automationuser@greymatter-pe.iam.gserviceaccount.com",
    "devops-automationuser@greymatter-psodev.iam.gserviceaccount.com",
    "devops-automationuser@greymatter-qa.iam.gserviceaccount.com",
    "devops-automationuser@greymatter-validation.iam.gserviceaccount.com",
    "devops-automationuser@poc-service-project-a-376015.iam.gserviceaccount.com",
    "devops-automationuser@ra-prod-seko.iam.gserviceaccount.com",
    "devops-automationuser@rms-development-322610.iam.gserviceaccount.com"
  ]
}

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


# Compute IAM roles
resource "google_project_iam_member" "compute_roles" {
  for_each = local.iam_roles
  project = "greymatter-development"
  role    = each.value
    member = [
    "serviceAccount:${var.service_account}",
    "serviceAccount:${var.service_account_name}@${var.project}.iam.gserviceaccount.com"
  ]
}  





# Storage IAM roles
resource "google_storage_bucket_iam_member" "storage_roles" {
  for_each = local.storage_roles

  bucket = each.key
  role = each.value
  member = [
    for service_account in local.service_accounts :
    "serviceAccount:${service_account}"
  ]
}


#resource "google_storage_bucket_iam_member" "storage_roles" {
#for_each = local.storage_roles

#bucket = var.bucket
#role = each.value

# Add all service accounts to IAM policy for each storage role
#members = [
#for service_account in local.service_accounts :
#"serviceAccount:${service_account}"
#]
#}
  
  
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
