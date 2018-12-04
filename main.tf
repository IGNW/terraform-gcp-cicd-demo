provider "google" {
  project = "ignw-internal-tools"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Google Kubernetes Engine (GKE) Cluster
module "gke" {
  source  = "./modules/gke"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  gke_node_count = "${var.gke_node_count}"
  name			 = "${var.gke_cluster_name}"
  labels {
   	Category = "Demo"
  }
}

# Jenkins CI/CD Server
module "jenkins" {
  source  = "./modules/jenkins"

  cluster_id              = "${module.gke.cluster_id}"
  cluster_name            = "${module.gke.cluster_name}"
  cluster_host            = "${module.gke.cluster_endpoint}"
  cluster_user            = "${var.admin_username}"
  cluster_password        = "${var.admin_password}"

  cluster_client_cert     = "${base64decode(module.gke.client_certificate)}"
  cluster_client_key      = "${base64decode(module.gke.client_key)}"
  cluster_ca_cert         = "${base64decode(module.gke.cluster_ca_certificate)}"

  jenkins_user            = "${var.jenkins_user}"
  jenkins_password        = "${var.jenkins_password}"
}
