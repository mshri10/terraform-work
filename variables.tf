// "security-group" Module Variables
variable "security-group-create" {
  type    = bool
  default = true
}

variable "security-group-count" {
  type    = number
  default = 1
}

variable "security_group_name" {
  type    = string
  default = "yash-sg"
}

variable "vpc_id" {
  type    = string
  default = "yash-vpc"
}

// "Elasticsearch Module Variables"
variable "aws-es-create" {
  type    = bool
  default = true
}

variable "aws-es-count" {
  type    = number
  default = 1
}

variable "region" {}
variable "profile" {}
variable "es_domain_name" {}
variable "es_version" {}

variable "subnet_ids" {
  type        = list(string)
  description = "VPC Subnet IDs"
  default     = []
}

variable "instance_count" {
  type = number
  default = 3
}

variable "instance_type" {
  type = string
  default = "r5.large.elasticsearch"
}

variable "security_group_name" {
  type        = list(string)
  description = "VPC Security Group"
  default     = []

}
