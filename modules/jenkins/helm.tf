provider "kubernetes" {
  host = "${var.cluster_host}"

  username = "${var.cluster_user}"
  password = "${var.cluster_password}"

  client_certificate     = "${var.cluster_client_cert}"
  client_key             = "${var.cluster_client_key}"
  cluster_ca_certificate = "${var.cluster_ca_cert}"
}

resource "null_resource" "configure_kubectl" {

  triggers {
    cluster_id = "${var.cluster_id}"
  }

  provisioner "local-exec" {
    command = <<EOF
        echo 'Configuring local kubectl...'
        gcloud config set project $GOOGLE_PROJECT
        gcloud config set compute/region GOOGLE_REGION
        gcloud config set compute/zone $GOOGLE_ZONE
        gcloud container clusters get-credentials ${var.cluster_name}
    EOF
  }
}


resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"  
  }
}

resource "null_resource" "helm_init" {

  triggers {
    cluster_id = "${var.cluster_id}"
  }

  provisioner "local-exec" {
    command = <<EOF
        echo 'Initializing helm...'
        helm init
    EOF
  }
  depends_on = ["null_resource.configure_kubectl"]
}

resource "kubernetes_cluster_role_binding" "tiller_cluster_role" {
  metadata {
    name = "tiller-cluster-role"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind  = "ClusterRole"
    name = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind = "User"
    name = "system:serviceaccount:kube-system:tiller"
  }
  subject {
    kind = "Group"
    name = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
  depends_on = ["null_resource.helm_init"]
}

resource "null_resource" "helm_bootstrap" {
  triggers {
    service_account_id = "${kubernetes_service_account.tiller.id}"
  }
	

  provisioner "local-exec" {
    command = <<EOF
        echo 'Installing & configuring helm...'
        kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
        helm init --upgrade
        helm repo update
    EOF
  }

  depends_on = ["kubernetes_service_account.tiller", "kubernetes_cluster_role_binding.tiller_cluster_role", "null_resource.helm_init"]
}
