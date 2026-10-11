output "mskconnect_connectors_id" {
  description = "Map of id values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.id if v.id != null && length(v.id) > 0 }
}
output "mskconnect_connectors_arn" {
  description = "Map of arn values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "mskconnect_connectors_capacity" {
  description = "Map of capacity values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => one(v.capacity) if v.capacity != null && length(v.capacity) > 0 }
}
output "mskconnect_connectors_connector_configuration" {
  description = "Map of connector_configuration values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.connector_configuration if v.connector_configuration != null && length(v.connector_configuration) > 0 }
}
output "mskconnect_connectors_description" {
  description = "Map of description values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.description if v.description != null && length(v.description) > 0 }
}
output "mskconnect_connectors_kafka_cluster" {
  description = "Map of kafka_cluster values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => one(v.kafka_cluster) if v.kafka_cluster != null && length(v.kafka_cluster) > 0 }
}
output "mskconnect_connectors_kafka_cluster_client_authentication" {
  description = "Map of kafka_cluster_client_authentication values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => one(v.kafka_cluster_client_authentication) if v.kafka_cluster_client_authentication != null && length(v.kafka_cluster_client_authentication) > 0 }
}
output "mskconnect_connectors_kafka_cluster_encryption_in_transit" {
  description = "Map of kafka_cluster_encryption_in_transit values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => one(v.kafka_cluster_encryption_in_transit) if v.kafka_cluster_encryption_in_transit != null && length(v.kafka_cluster_encryption_in_transit) > 0 }
}
output "mskconnect_connectors_kafkaconnect_version" {
  description = "Map of kafkaconnect_version values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.kafkaconnect_version if v.kafkaconnect_version != null && length(v.kafkaconnect_version) > 0 }
}
output "mskconnect_connectors_log_delivery" {
  description = "Map of log_delivery values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => one(v.log_delivery) if v.log_delivery != null && length(v.log_delivery) > 0 }
}
output "mskconnect_connectors_name" {
  description = "Map of name values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.name if v.name != null && length(v.name) > 0 }
}
output "mskconnect_connectors_plugin" {
  description = "Map of plugin values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.plugin if v.plugin != null && length(v.plugin) > 0 }
}
output "mskconnect_connectors_region" {
  description = "Map of region values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.region if v.region != null && length(v.region) > 0 }
}
output "mskconnect_connectors_service_execution_role_arn" {
  description = "Map of service_execution_role_arn values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.service_execution_role_arn if v.service_execution_role_arn != null && length(v.service_execution_role_arn) > 0 }
}
output "mskconnect_connectors_tags" {
  description = "Map of tags values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "mskconnect_connectors_tags_all" {
  description = "Map of tags_all values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "mskconnect_connectors_version" {
  description = "Map of version values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => v.version if v.version != null && length(v.version) > 0 }
}
output "mskconnect_connectors_worker_configuration" {
  description = "Map of worker_configuration values across all mskconnect_connectors, keyed the same as var.mskconnect_connectors"
  value       = { for k, v in aws_mskconnect_connector.mskconnect_connectors : k => one(v.worker_configuration) if v.worker_configuration != null && length(v.worker_configuration) > 0 }
}

