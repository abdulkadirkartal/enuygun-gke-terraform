resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  logging_service    = "none"
  monitoring_service = "none"

 
  node_config {
    disk_size_gb = 50
    disk_type    = "pd-standard"  
  }
}

#main pool gke config 
resource "google_container_node_pool" "main_pool" {
  name       = "main-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name

  node_count = 1

  node_config {
    machine_type = "n2d-standard-2"  
    disk_size_gb = 50
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

#application pool gke config 
resource "google_container_node_pool" "application_pool" {
  name       = "application-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type = "n2d-standard-2"  
    disk_size_gb = 50
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
} 