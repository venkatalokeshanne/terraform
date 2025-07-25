variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "k8s.example.com"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name for Kops state"
  default = "vrit"
}
