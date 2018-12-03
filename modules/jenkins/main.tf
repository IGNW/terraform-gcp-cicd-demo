provider "helm" {
    service_account = "${kubernetes_service_account.tiller.metadata.0.name}"
}

resource "helm_release" "jenkins" {
    name      = "jenkins"
    chart     = "stable/jenkins"

    set {
        name    = "Master.AdminUser"
        value   = "${var.jenkins_user}"
    }

    set {
        name    = "Master.AdminPassword"
        value   = "${var.jenkins_password}"
    }

    depends_on = ["null_resource.helm_bootstrap"]
}