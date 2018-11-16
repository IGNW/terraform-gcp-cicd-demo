variable "admin_username" {
    type        = "string"    
    description = "User name for authentication to the Kubernetes linux agent virtual machines in the cluster."

}
variable "admin_password" {
    type 		= "string"   
    description = "The password for the Linux admin account."
}
variable "gke_node_count" {
    type = "string"
    description = "Count of cluster instance nodes to start."
}
variable "name" {
    type = "string"
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