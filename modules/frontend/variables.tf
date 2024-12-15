variable "bucket_name" {
  description = "Name of the S3 bucket for the frontend"
  type        = string
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}
