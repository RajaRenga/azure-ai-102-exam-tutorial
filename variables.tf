variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"  # TODO: Update to your preferred region
}

variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
  default     = "TODO-PROJECT-NAME"  # TODO: Update with your project name
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "TODO-ENVIRONMENT"  # TODO: Update with your environment
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "TODO-YOUR-PROJECT"    # TODO: Update
    Environment = "TODO-YOUR-ENV"        # TODO: Update
    ManagedBy   = "Terraform"
    Module      = "cloudposse/rds/aws"
  }
}

