# Define IAM policy for restricting full access to all users and roles
resource "aws_iam_policy" "restrict_full_access" {
  name        = "restrict-full-access-policy"
  description = "Enforce least privilege by restricting full access"
  policy      = file("${path.module}/policies/restrict_full_access.json") # Path to JSON policy file
}

# Attach IAM policy to all users and roles
resource "aws_iam_policy_attachment" "restrict_full_access_attachment" {
  name       = "restrict-full-access-attachment"
  users      = ["${aws_iam_user.example.name}"] # Add user names here
  roles      = ["${aws_iam_role.example.name}"] # Add role names here
  policy_arn = aws_iam_policy.restrict_full_access.arn
}

# Enable CloudTrail for logging API calls
resource "aws_cloudtrail" "example" {
  name                          = "example-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.bucket
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  include_global_service_events = true
  tags = {
    Environment = "Production"
  }
}

# Define AWS Config rule for monitoring compliance
resource "aws_config_config_rule" "example" {
  name = "example-config-rule"
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }
}

# Enable GuardDuty for threat detection
resource "aws_guardduty_detector" "example" {
  enable = true
}

# Create VPC with CIDR block
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16" # Define the CIDR block for the VPC
}

# Encrypt EBS volumes by default
resource "aws_ebs_default_kms_key" "example" {
  key_arn = "arn:aws:kms:us-east-1:123456789012:key/abcd1234-12ab-34cd-56ef-1234567890ab" # Replace with actual KMS key ARN
}

# Define centralized monitoring and alerting mechanisms
# Implement your centralized monitoring solution here

# Implement your alerting mechanisms here