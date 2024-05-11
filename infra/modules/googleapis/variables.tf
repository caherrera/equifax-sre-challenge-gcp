variable "project" {
  description = "The GCP project name"
  type        = string
  default     = null
}

variable "services" {
  description = "The list of GCP services to enable"
  type        = list(string)
  validation {
    condition     = length(var.services) > 0
    error_message = "At least one service must be enabled"
  }
}