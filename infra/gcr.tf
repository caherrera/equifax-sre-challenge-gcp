resource "google_artifact_registry_repository" "gcr" {
  project = var.project_id
  format        = "DOCKER"
  repository_id = local.prefix
}

resource "google_service_account" "gcr" {
  account_id   = "${local.prefix}-gcr-sa"
  display_name = "${local.prefix}-gcr-sa"
}

resource "google_service_account_key" "gcr" {
  service_account_id = google_service_account.gcr.name
}

resource "google_project_iam_member" "viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.gcr.email}"
}

resource "local_file" "gcr" {
  filename = "${ google_service_account.gcr.email }.json"
  content  = base64decode(google_service_account_key.gcr.private_key)
}

# resource "kubernetes_secret" "gcr" {
#   type = "kubernetes.io/dockerconfigjson"
#   metadata {
#     name      = "gcr-image-pull"
#     namespace = "default"
#   }
#
#   data = {
#     ".dockerconfigjson" = jsonencode({
#       auths = {
#         "gcr.io" = {
#           username = "_json_key"
#           password = base64decode(google_service_account_key.gcr.private_key)
#           email    = google_service_account.gcr.email
#           auth     = base64encode("_json_key:${ base64decode(google_service_account_key.gcr.private_key) }")
#
#         }
#
#       }
#
#     })
#
#   }
#
# }