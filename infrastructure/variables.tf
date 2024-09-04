# variables.tf
variable "region" {
  description = "The region to deploy resources in"
  type        = string
  default     = "europe-west1"
}
