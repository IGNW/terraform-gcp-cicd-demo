output "cluster_service_account" {
  value = "${kubernetes_service_account.tiller.metadata.0.name}"
}

output "jenkins_username" {
  value = "${var.jenkins_user}"
}

output "jenkins_password" {
  value = "${var.jenkins_password}"
}

