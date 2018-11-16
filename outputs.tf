output "name" {
  description = "Cluster name"
  value       = "${var.gke_cluster_name}"
}

output "environment" {
  description = "Cluster environment"
  value       = "${var.environment}"
}

output "labels" {
  description = "Cluster labels"
  value       = "${var.labels}"
}

