# CLOUD RUN SERVICE IAM POLICY

variable "service_name" { type = string }
variable "region" { type = string }
variable "member" { type = string }
variable "environment" { type = string }

resource "google_cloud_run_v2_service_iam_member" "this" {
  location = var.region
  name     = var.service_name
  role     = "roles/run.invoker"
  member   = var.member

  precondition {
    condition     = !(var.environment == "Production" && var.member == "allUsers")
    error_message = "Public IAM not allowed in Production."
  }
}