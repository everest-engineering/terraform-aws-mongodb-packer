output "instance_id_list" {
  description = "List of IDs of instances"
  value       = aws_instance.mongodb.*.id
}

output "instance_arn_list" {
  description = "List of ARNs of instances"
  value       = aws_instance.mongodb.*.arn
}

output "instance_key_name_list" {
  description = "List of key names of instances"
  value       = aws_instance.mongodb.*.key_name
}

output "instance_private_ip_list" {
  description = "List of private IP addresses assigned to the instances, if applicable"
  value       = aws_instance.mongodb.*.private_ip
}

output "instance_security_group_list" {
  description = "List of associated security groups of instances"
  value       = aws_instance.mongodb.*.security_groups
}

output "vpc_security_group_id_list" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = aws_instance.mongodb.*.vpc_security_group_ids
}

output "instance_subnet_id_list" {
  description = "List of IDs of VPC subnets of instances"
  value       = aws_instance.mongodb.*.subnet_id
}

output "instance_state_list" {
  description = "List of instance states of instances"
  value       = aws_instance.mongodb.*.instance_state
}

output "instance_tags_list" {
  description = "List of tags of instances"
  value       = aws_instance.mongodb.*.tags
}
