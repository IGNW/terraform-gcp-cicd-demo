provider "helm" {
    service_account = "${kubernetes_service_account.tiller.metadata.0.name}"
}

data "template_file" "values" {
  template = "${file("./modules/jenkins/config_files/values.tpl")}"
  vars {
    jenkins_user     = "${var.jenkins_user}"
    jenkins_password = "${var.jenkins_password}"
  }
}

resource "kubernetes_secret" "xmlcredentials" {
  metadata {
    name = "credentials.xml"
    }
  data {
    credentials.xml =<<EOF
		<?xml version='1.1' encoding='UTF-8'?>
      <com.cloudbees.plugins.credentials.SystemCredentialsProvider plugin="credentials@2.1.18">
        <domainCredentialsMap class="hudson.util.CopyOnWriteMap$Hash">
          <entry>
            <com.cloudbees.plugins.credentials.domains.Domain>
              <specifications/>
            </com.cloudbees.plugins.credentials.domains.Domain>
            <java.util.concurrent.CopyOnWriteArrayList>
              <com.google.jenkins.plugins.credentials.oauth.GoogleRobotMetadataCredentials plugin="google-oauth-plugin@0.6">
                <module class="com.google.jenkins.plugins.credentials.oauth.GoogleRobotMetadataCredentialsModule"/>
                <projectId>ignw-internal-tools</projectId>
              </com.google.jenkins.plugins.credentials.oauth.GoogleRobotMetadataCredentials>
            </java.util.concurrent.CopyOnWriteArrayList>
          </entry>
        </domainCredentialsMap>
    EOF
    }
  }
resource "helm_release" "jenkins" {
    name      = "jenkins"
    chart     = "stable/jenkins"
		values = ["${data.template_file.values.rendered}"]
    depends_on = ["null_resource.helm_bootstrap", "kubernetes_secret.xmlcredentials"]
}
