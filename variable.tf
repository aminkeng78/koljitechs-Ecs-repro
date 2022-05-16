
variable "component_name" {
  default = "kojitechs"
}

variable "http_port" {
  description = "http from everywhere"
  type        = number
  default     = 80
}


variable "https_port" {
  description = "https from everywhere"
  type        = number
  default     = 8080
}


variable "register_dns" {
  default = "coniliuscf.org"
}
variable "dns_name" {
  type    = string
  default = "coniliuscf.org"
}

variable "subject_alternative_names" {
  type    = list(any)
  default = ["*.coniliuscf.org"]
}

variable "database_name" {
  default     = "webappdb"
  description = "dbname"
}
variable "master_username" {
  default     = "dbadmin"
  description = "db user name"
}