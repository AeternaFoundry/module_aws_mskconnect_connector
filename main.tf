resource "aws_mskconnect_connector" "mskconnect_connectors" {
  for_each = var.mskconnect_connectors

  connector_configuration    = each.value.connector_configuration
  kafkaconnect_version       = each.value.kafkaconnect_version
  name                       = each.value.name
  service_execution_role_arn = each.value.service_execution_role_arn
  description                = each.value.description
  region                     = each.value.region
  tags                       = each.value.tags
  tags_all                   = each.value.tags_all

  capacity {
    dynamic "autoscaling" {
      for_each = each.value.capacity.autoscaling != null ? [each.value.capacity.autoscaling] : []
      content {
        max_worker_count = autoscaling.value.max_worker_count
        mcu_count        = autoscaling.value.mcu_count
        min_worker_count = autoscaling.value.min_worker_count
        dynamic "scale_in_policy" {
          for_each = autoscaling.value.scale_in_policy != null ? [autoscaling.value.scale_in_policy] : []
          content {
            cpu_utilization_percentage = scale_in_policy.value.cpu_utilization_percentage
          }
        }
        dynamic "scale_out_policy" {
          for_each = autoscaling.value.scale_out_policy != null ? [autoscaling.value.scale_out_policy] : []
          content {
            cpu_utilization_percentage = scale_out_policy.value.cpu_utilization_percentage
          }
        }
      }
    }
    dynamic "provisioned_capacity" {
      for_each = each.value.capacity.provisioned_capacity != null ? [each.value.capacity.provisioned_capacity] : []
      content {
        mcu_count    = provisioned_capacity.value.mcu_count
        worker_count = provisioned_capacity.value.worker_count
      }
    }
  }

  kafka_cluster {
    apache_kafka_cluster {
      bootstrap_servers = each.value.kafka_cluster.apache_kafka_cluster.bootstrap_servers
      vpc {
        security_groups = each.value.kafka_cluster.apache_kafka_cluster.vpc.security_groups
        subnets         = each.value.kafka_cluster.apache_kafka_cluster.vpc.subnets
      }
    }
  }

  kafka_cluster_client_authentication {
    authentication_type = each.value.kafka_cluster_client_authentication.authentication_type
  }

  kafka_cluster_encryption_in_transit {
    encryption_type = each.value.kafka_cluster_encryption_in_transit.encryption_type
  }

  dynamic "plugin" {
    for_each = each.value.plugin
    content {
      custom_plugin {
        arn      = plugin.value.custom_plugin.arn
        revision = plugin.value.custom_plugin.revision
      }
    }
  }

  dynamic "log_delivery" {
    for_each = each.value.log_delivery != null ? [each.value.log_delivery] : []
    content {
      worker_log_delivery {
        dynamic "cloudwatch_logs" {
          for_each = log_delivery.value.worker_log_delivery.cloudwatch_logs != null ? [log_delivery.value.worker_log_delivery.cloudwatch_logs] : []
          content {
            enabled   = cloudwatch_logs.value.enabled
            log_group = cloudwatch_logs.value.log_group
          }
        }
        dynamic "firehose" {
          for_each = log_delivery.value.worker_log_delivery.firehose != null ? [log_delivery.value.worker_log_delivery.firehose] : []
          content {
            delivery_stream = firehose.value.delivery_stream
            enabled         = firehose.value.enabled
          }
        }
        dynamic "s3" {
          for_each = log_delivery.value.worker_log_delivery.s3 != null ? [log_delivery.value.worker_log_delivery.s3] : []
          content {
            bucket  = s3.value.bucket
            enabled = s3.value.enabled
            prefix  = s3.value.prefix
          }
        }
      }
    }
  }

  dynamic "worker_configuration" {
    for_each = each.value.worker_configuration != null ? [each.value.worker_configuration] : []
    content {
      arn      = worker_configuration.value.arn
      revision = worker_configuration.value.revision
    }
  }
}

