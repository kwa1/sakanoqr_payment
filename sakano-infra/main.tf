locals {
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }

  lambda_name        = "${var.project_name}-${var.environment}-backend"
  api_gateway_name   = "${var.project_name}-${var.environment}-api"
  frontend_bucket    = var.frontend_bucket_name != null ? var.frontend_bucket_name : "${var.project_name}-${var.environment}-frontend"
}
