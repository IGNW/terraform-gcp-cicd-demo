variable "admin_username" {
    type        = "string"
    default     = "admin"
    description = "User name for authentication to the Kubernetes linux agent virtual machines in the cluster."

}
variable "admin_password" {
    type 		= "string"
    default     = "supersecretpassword"
    description = "The password for the Linux admin account."
}
variable "gke_node_count" {
    type        = "string"
    default     = "1"    
    description = "Count of cluster instance nodes to start."
}
variable "gke_cluster_name" {
    type        = "string"
    default     = "demo"
    description = "Cluster name for the GCP GKE Cluster."
}

variable "environment" {
    type        = "string"
    default     = "DEV"
    description = "Environment name"   
}
variable "labels" {
  type = "map"
  description = "Supply labels you want added to all resources"
  default = {  
  }
}

variable "jenkins_user" {
  type        = "string"
  description = "Jenkins ADMIN user account."
}

variable "jenkins_password" {
  type        = "string"
  description = "Jenkins ADMIN user account password."
}

