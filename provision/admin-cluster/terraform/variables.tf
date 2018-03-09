variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "region" {
  default = "us-east-1"
}

variable "availability_zone" {
  description = "Availability Zones per region and failure zones"
  type = "map"
  default = {
    us-east-1.az-1 = "us-east-1a"
    us-east-1.az-2 = "us-east-1b"
    us-east-1.az-3 = "us-east-1c"
    us-east-1.az-4 = "us-east-1d"
    us-west-1.az-1 = "us-west-1a"
    us-west-1.az-2 = "us-west-1b"
    us-west-1.az-3 = "us-west-1c"
    us-west-1.az-4 = "us-west-1d"
  }
}

variable "amis_docker_node" {
  description = "AMIs for docker-engine nodes by region"
  type = "map"
  default = {
    us-east-1 = "ami-cd0f5cb6"
    us-west-2 = "ami-06b94666"
  }
}

# ---------------------------------------------------------------------------
# Network Variables
# ---------------------------------------------------------------------------
variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

# ---------------------------------------------------------------------------
# Resource Tag Variables
# ---------------------------------------------------------------------------
variable "environment" {
    description = "The environment this resource is running in"
	default = "latest"
}


# ---------------------------------------------------------------------------
# Environment Sizing Variables
# ---------------------------------------------------------------------------
variable "environment-size" {
    description = "Size of an environment"
    default = "small"
}

variable "ec2-instance-type" {
  description = "What ec2 instance type to use per environment size and swawrm-node type"
  type = "map"
  default = {
    small.swarm-manager = "t2.micro"
    small.admin-logging = "t2.large"
    small.admin-monitoring = "t2.large"

    medium.swarm-manager = "t2.medium"
    medium.admin-logging = "t2.medium"
    medium.admin-monitoring = "t2.medium"

    large.swarm-manager = "m4.large"
    large.admin-logging = "t2.medium"
    large.admin-monitoring = "t2.medium"
  }
}