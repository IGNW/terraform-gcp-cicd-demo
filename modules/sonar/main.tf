provider "helm" {
  kubernetes {
    host     = "${var.cluster_host}"
    username = "${var.cluster_user}"
    password = "${var.cluster_password}"

    client_certificate     = "${var.cluster_client_cert}"
    client_key             = "${var.cluster_client_key}"
    cluster_ca_certificate = "${var.cluster_ca_cert}"
  }
  service_account = "${var.cluster_service_account}"
}

resource "helm_release" "sonar" {
  name      = "sonar"
  chart     = "stable/sonarqube"
}