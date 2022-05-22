variable "start_nodes_scale" {
  description = "Initial number of running worker nodes"
  type        = number
  default     = 3
}

variable "min_node_pool_scale" {
  description = "Minimal number of worker nodes"
  type        = number
  default     = 3
}

variable "max_node_pool_scale" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 6
}