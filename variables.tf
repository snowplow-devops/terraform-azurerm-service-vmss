variable "name" {
  description = "A name which will be pre-pended to the resources created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy the instances into"
  type        = string
}

variable "subnet_id" {
  description = "The subnet id to deploy the instances across"
  type        = string
}

variable "network_security_group_id" {
  description = "The security group to attach to the deployed servers"
  type        = string
}

variable "user_supplied_script" {
  description = "The user-data script extension to execute"
  type        = string
}

variable "sku" {
  description = "The SKU of the instances to be deployed"
  type        = string
  default     = "Standard_B2s"
}

variable "instance_count" {
  description = "The number of instances to deploy in the scale-set"
  type        = number
  default     = 1
}

variable "os_disk_type" {
  description = "The type of disk to use for the Operating System"
  type        = string
  default     = "StandardSSD_LRS"
}

variable "os_disk_size_gb" {
  description = "The size of the Operating System disk in gb"
  type        = number
  default     = 30
}

variable "application_gateway_backend_address_pool_ids" {
  description = "The ID of the backend address pool to bind the scale-set to when used with a load balancer"
  type        = list(string)
  default     = []
}

variable "admin_username" {
  description = "The username to be set as the server admin"
  type        = string
  default     = "snowplow"
}

variable "admin_ssh_public_key" {
  description = "The SSH public key attached for access to the servers"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to assign a public ip address to this instance"
  type        = bool
  default     = true
}

variable "tags" {
  description = "The tags to append to this resource"
  default     = {}
  type        = map(string)
}
