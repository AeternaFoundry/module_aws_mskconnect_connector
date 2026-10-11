variable "mskconnect_connectors" {
  description = <<EOT
Map of mskconnect_connectors, attributes below
Required:
    - connector_configuration
    - kafkaconnect_version
    - name
    - service_execution_role_arn
    - capacity (block):
        - autoscaling (optional, block):
            - max_worker_count (required)
            - mcu_count (optional)
            - min_worker_count (required)
            - scale_in_policy (optional, block):
                - cpu_utilization_percentage (optional)
            - scale_out_policy (optional, block):
                - cpu_utilization_percentage (optional)
        - provisioned_capacity (optional, block):
            - mcu_count (optional)
            - worker_count (required)
    - kafka_cluster (block):
        - apache_kafka_cluster (required, block):
            - bootstrap_servers (required)
            - vpc (required, block):
                - security_groups (required)
                - subnets (required)
    - kafka_cluster_client_authentication (block):
        - authentication_type (optional)
    - kafka_cluster_encryption_in_transit (block):
        - encryption_type (optional)
    - plugin (block):
        - custom_plugin (required, block):
            - arn (required)
            - revision (required)
Optional:
    - description
    - region
    - tags
    - tags_all
    - log_delivery (block):
        - worker_log_delivery (required, block):
            - cloudwatch_logs (optional, block):
                - enabled (required)
                - log_group (optional)
            - firehose (optional, block):
                - delivery_stream (optional)
                - enabled (required)
            - s3 (optional, block):
                - bucket (optional)
                - enabled (required)
                - prefix (optional)
    - worker_configuration (block):
        - arn (required)
        - revision (required)
EOT

  type = map(object({
    connector_configuration    = map(string)
    kafkaconnect_version       = string
    name                       = string
    service_execution_role_arn = string
    description                = optional(string)
    region                     = optional(string)
    tags                       = optional(map(string))
    tags_all                   = optional(map(string))
    capacity = object({
      autoscaling = optional(object({
        max_worker_count = number
        mcu_count        = optional(number)
        min_worker_count = number
        scale_in_policy = optional(object({
          cpu_utilization_percentage = optional(number)
        }))
        scale_out_policy = optional(object({
          cpu_utilization_percentage = optional(number)
        }))
      }))
      provisioned_capacity = optional(object({
        mcu_count    = optional(number)
        worker_count = number
      }))
    })
    kafka_cluster = object({
      apache_kafka_cluster = object({
        bootstrap_servers = string
        vpc = object({
          security_groups = set(string)
          subnets         = set(string)
        })
      })
    })
    kafka_cluster_client_authentication = object({
      authentication_type = optional(string)
    })
    kafka_cluster_encryption_in_transit = object({
      encryption_type = optional(string)
    })
    plugin = list(object({
      custom_plugin = object({
        arn      = string
        revision = number
      })
    }))
    log_delivery = optional(object({
      worker_log_delivery = object({
        cloudwatch_logs = optional(object({
          enabled   = bool
          log_group = optional(string)
        }))
        firehose = optional(object({
          delivery_stream = optional(string)
          enabled         = bool
        }))
        s3 = optional(object({
          bucket  = optional(string)
          enabled = bool
          prefix  = optional(string)
        }))
      })
    }))
    worker_configuration = optional(object({
      arn      = string
      revision = number
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.mskconnect_connectors : (
        length(v.plugin) >= 1
      )
    ])
    error_message = "Each plugin list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.mskconnect_connectors : (
        v.capacity.autoscaling == null || (v.capacity.autoscaling.max_worker_count >= 1 && v.capacity.autoscaling.max_worker_count <= 10)
      )
    ])
    error_message = "must be between 1 and 10"
  }
  validation {
    condition = alltrue([
      for k, v in var.mskconnect_connectors : (
        v.capacity.autoscaling == null || (v.capacity.autoscaling.mcu_count == null || (contains([1, 2, 4, 8], v.capacity.autoscaling.mcu_count)))
      )
    ])
    error_message = "must be one of: 1, 2, 4, 8"
  }
  validation {
    condition = alltrue([
      for k, v in var.mskconnect_connectors : (
        v.capacity.autoscaling == null || (v.capacity.autoscaling.min_worker_count >= 1 && v.capacity.autoscaling.min_worker_count <= 10)
      )
    ])
    error_message = "must be between 1 and 10"
  }
  validation {
    condition = alltrue([
      for k, v in var.mskconnect_connectors : (
        v.capacity.autoscaling == null || (v.capacity.autoscaling.scale_in_policy == null || (v.capacity.autoscaling.scale_in_policy.cpu_utilization_percentage == null || (v.capacity.autoscaling.scale_in_policy.cpu_utilization_percentage >= 1 && v.capacity.autoscaling.scale_in_policy.cpu_utilization_percentage <= 100)))
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.mskconnect_connectors : (
        v.capacity.autoscaling == null || (v.capacity.autoscaling.scale_out_policy == null || (v.capacity.autoscaling.scale_out_policy.cpu_utilization_percentage == null || (v.capacity.autoscaling.scale_out_policy.cpu_utilization_percentage >= 1 && v.capacity.autoscaling.scale_out_policy.cpu_utilization_percentage <= 100)))
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.mskconnect_connectors : (
        v.capacity.provisioned_capacity == null || (v.capacity.provisioned_capacity.mcu_count == null || (contains([1, 2, 4, 8], v.capacity.provisioned_capacity.mcu_count)))
      )
    ])
    error_message = "must be one of: 1, 2, 4, 8"
  }
  validation {
    condition = alltrue([
      for k, v in var.mskconnect_connectors : (
        v.capacity.provisioned_capacity == null || (v.capacity.provisioned_capacity.worker_count >= 1 && v.capacity.provisioned_capacity.worker_count <= 10)
      )
    ])
    error_message = "must be between 1 and 10"
  }
  # Note: 7 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

