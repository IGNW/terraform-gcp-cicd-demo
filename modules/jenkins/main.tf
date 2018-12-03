provider "helm" {
    service_account = "${kubernetes_service_account.tiller.metadata.0.name}"
}

data "template_file" "jenkins_values" {
    template = <<EOF
Master:
  AdminUser: ${var.jenkins_user}
  AdminPassword: ${var.jenkins_password}
EOF
}

resource "helm_release" "jenkins" {
    name      = "jenkins"
    chart     = "stable/jenkins"
    values    = "${data.template_file.jenkins_values.rendered}"
    depends_on = ["null_resource.helm_bootstrap"]
}