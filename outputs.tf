output "instance_id" {
  description = "ID of the instance"
  value       = module.rds.instance_id
  sensitive   = false
}

output "instance_arn" {
  description = "ARN of the instance"
  value       = module.rds.instance_arn
  sensitive   = false
}

output "instance_endpoint" {
  description = "DNS Endpoint of the instance"
  value       = module.rds.instance_endpoint
  sensitive   = false
}

output "instance_address" {
  description = "Address of the instance"
  value       = module.rds.instance_address
  sensitive   = false
}

output "parameter_group_id" {
  description = "ID of the Parameter Group"
  value       = module.rds.parameter_group_id
  sensitive   = false
}

output "option_group_id" {
  description = "ID of the Option Group"
  value       = module.rds.option_group_id
  sensitive   = false
}

output "subnet_group_id" {
  description = "ID of the created Subnet Group"
  value       = module.rds.subnet_group_id
  sensitive   = false
}

output "security_group_id" {
  description = "ID of the Security Group"
  value       = module.rds.security_group_id
  sensitive   = false
}

output "resource_id" {
  description = "The RDS Resource ID of this instance."
  value       = module.rds.resource_id
  sensitive   = false
}

output "hostname" {
  description = "DNS host name of the instance"
  value       = module.rds.hostname
  sensitive   = false
}

output "master_user_secret" {
  description = "Secret object if configured with `var.database_manage_master_user_password = true`."
  value       = module.rds.master_user_secret
  sensitive   = true
}