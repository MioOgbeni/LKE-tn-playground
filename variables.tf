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

variable "default_namespaces" {
  description = "Default namespace to create"
  type        = set(string)
  default     = ["external-dns", "traefik"]
}

variable "cloudflare_api_token" {
  description = "Cloudflare api token"
  type        = string
  default     = ""
}

variable "cloudflare_zone_id_filter" {
  description = "Cloudflare zone id filter"
  type        = string
  default     = ""
}