locals {
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }

  lambda_name        = "${var.project_name}-${var.environment}-backend"
  api_gateway_name   = "${var.project_name}-${var.environment}-api"
  frontend_bucket    = var.frontend_bucket_name != null ? var.frontend_bucket_name : "${var.project_name}-${var.environment}-frontend"
}

provider "aws" {
  region = var.region
}

module "backend" {
  source              = "./modules/backend"
  lambda_name         = local.lambda_name
  lambda_runtime      = var.lambda_runtime
  lambda_handler      = var.lambda_handler
  lambda_memory_size  = var.lambda_memory_size
  lambda_timeout      = var.lambda_timeout
  lambda_zip_path     = "./lambda.zip"
  api_gateway_name    = local.api_gateway_name
  tags                = local.tags
}

module "frontend" {
  source      = "./modules/frontend"
  bucket_name = local.frontend_bucket
  tags        = local.tags
}

output "api_url" {
  value = module.backend.api_url
}

output "frontend_url" {
  value = module.frontend.frontend_url
}
