resource "google_sql_database_instance" "db" {
  name             = "${local.prefix}-db"
  database_version = "POSTGRES_15"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "db" {
  name     = "laravel"
  instance = google_sql_database_instance.db.name
  charset  = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_sql_user" "db" {
  name     = "laravel"
  instance = google_sql_database_instance.db.name
  password = "password"
}

