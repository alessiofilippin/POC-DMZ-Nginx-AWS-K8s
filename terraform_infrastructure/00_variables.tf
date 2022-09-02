variable "name_prefix" {
  default     = "alef"
  description = "Resources prefix"
}

variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

variable "cluster_name" {
  default     = "test-k8s-alef"
  description = "My Cluster Name"
}
