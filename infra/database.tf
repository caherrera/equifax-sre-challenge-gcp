resource "google_sql_database_instance" "db" {
  name             = "${local.prefix}-db"
  database_version = "POSTGRES_15"

  settings {
    tier              = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.google_compute_network.primary.self_link
#       authorized_networks {
#         value = google_container_cluster.kube.cluster_ipv4_cidr
#       }

    }
  }

  depends_on = [google_service_networking_connection.google-managed-services]


}

resource "google_sql_database" "db" {
  name      = "laravel"
  instance  = google_sql_database_instance.db.name
  charset   = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_sql_user" "db" {
  name     = "laravel"
  instance = google_sql_database_instance.db.name
  password = "password"
}


