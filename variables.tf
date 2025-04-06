variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "europe-west1"
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "gke-cluster"
}

variable "network_name" {
  description = "VPC Network Name"
  type        = string
  default     = "gke-network"
}

variable "subnet_name" {
  description = "Subnet Name"
  type        = string
  default     = "gke-subnet"
} 