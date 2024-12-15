variable "project_name" {
  description = "The name of the project (used for tagging and naming resources)"
  type        = string
  default     = "sakano"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, qa, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "frontend_bucket_name" {
  description = "S3 bucket name for hosting the frontend"
  type        = string
  default     = null
}

variable "lambda_runtime" {
  description = "Runtime environment for Lambda"
  type        = string
  default     = "nodejs18.x"
}

variable "lambda_handler" {
  description = "Handler for the Lambda function"
  type        = string
  default     = "index.handler"
}

variable "lambda_memory_size" {
  description = "Memory size for the Lambda function"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function in seconds"
  type        = number
  default     = 10
}
