resource "google_container_cluster" "primary" {
    name               = "${var.name}"    
    initial_node_count = "${var.gke_node_count}"
    master_auth {
        username = "${var.admin_username}"
        password = "${var.admin_password}"
    }
    node_config {
        machine_type = "n1-standard-4"
        oauth_scopes = [
          "https://www.googleapis.com/auth/compute",
          "https://www.googleapis.com/auth/devstorage.read_only",
          "https://www.googleapis.com/auth/logging.write",
          "https://www.googleapis.com/auth/monitoring",
        ]        
        labels = "${merge(map("Name", format("%s-%d", var.name, count.index+1)), map("Terraform", "true"), map("Environment", var.environment), var.labels)}"
    }
}
