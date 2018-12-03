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
    set {
        name    = "CredentialsXmlSecret"
        value   = "<<EOF
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
          </com.cloudbees.plugins.credentials.SystemCredentialsProvider> 
				EOF
    }

    set {
        name    = "Master.InstallPlugins"
        value   = "google-oauth-plugin:0.6 "
    }

    depends_on = ["null_resource.helm_bootstrap"]
}
