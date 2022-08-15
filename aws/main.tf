variable "tags" {
  type = map
  default = { Name = "testing-noctua-app-stack" }
}

variable "instance_type" {
  default = "t2.large"
}

variable "disk_size" {
  default = 100
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_port" {
  type        = number
  default     = 22
  description = "ssh server port"
}

variable "noctua_port" {
  type        = number
  default     = 8080
  description = "noctua server port"
}

variable "barista_port" {
  type        = number
  default     = 8090
  description = "barista server port"
}

variable "golr_port" {
  type        = number
  default     = 8983
  description = "golr server port"
}

variable "open_ports" {
  type = list 
  default = [var.ssh_port, var.noctua_port, var.barista_port, var.golr_port]
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = [ "~/.aws/credentials" ]
  profile = "default"
}

module "base" {
  source = "git::https://github.com/geneontology/devops-aws-go-instance.git?ref=V2.0"
  instance_type = var.instance_type
  public_key_path = var.public_key_path
  tags = var.tags
  open_ports = var.open_ports
  disk_size = var.disk_size
}

output "public_ip" {
   value                  = module.base.public_ip
}
