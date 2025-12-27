variable "name" {
  description = "The name of the helm deployment"
  type        = string
  default     = "wordpress"
}

variable "namespace" {
  description = "The namespace for the helm deployment"
  type        = string
  default     = "wordpress"
}

variable "chart" {
  description = "Which helm chart to install"
  type        = string
  default     = "wordpress"
}

variable "repository" {
  description = "Which helm repository to use"
  type        = string
  default     = "http://linuxgurus.github.io/wordpress"
}

variable "hostname" {
  description = "The host name for the wordpress site"
  type        = string
}

variable "cert_issuer" {
  description = "The internal CA to use"
  type        = string
}

variable "ingress_class" {
  description = "Which ingress class to use for the ingress"
  type        = string
}
