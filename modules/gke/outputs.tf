output "cluster_id" {
  value = "${google_container_cluster.primary.id}"
}

output "cluster_endpoint" {
    value = "${google_container_cluster.primary.endpoint}"
}
output "ssh_command" {
    value = "ssh ${var.admin_username}@${google_container_cluster.primary.endpoint}"
}

output "cluster_name" {
    value = "${google_container_cluster.primary.name}"
}

# The following outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}