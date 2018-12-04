variable "cluster_id" {
    type        = "string"
    description = "GKE Cluster id."
}

variable "cluster_name" {
    type        = "string"
    description = "GKE Cluster name."
}

variable "cluster_host" {
    type        = "string"    
    description = "GKE Cluster host address."
}

variable "cluster_user" {
    type        = "string"    
    description = "GKE Cluster username."
}

variable "cluster_password" {
    type        = "string"    
    description = "GKE Cluster password."
}

variable "cluster_client_cert" {
    type        = "string"    
    description = "GKE Cluster client certificate PEM."
}

variable "cluster_client_key" {
    type        = "string"    
    description = "GKE Cluster client certificate key."
}

variable "cluster_ca_cert" {
    type        = "string"    
    description = "GKE Cluster cluster CA certificate."
}

variable "jenkins_user" {
    type        = "string"
    description = "Jenkins ADMIN user account."
}

variable "jenkins_password" {
    type        = "string"
    description = "Jenkins ADMIN user account password."
}

