variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of instance to use for the EC2 instance."
  type        = string
  default     = "t2.nano"
}

variable "ami" {
  description = "The AMI ID"
  type        = string
  default     = "ami-0b6d9d3d33ba97d99"
}

variable "instance_name" {
  description = "The name of the EC2 instance."
  type        = string
  default     = "tfdemo"
}

variable "environment" {
  description = "The environment for the resources."
  type        = string
  default     = "dev"
}