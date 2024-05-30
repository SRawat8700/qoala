# AWS Region
variable "location" {
    default = "ap-south-1"
}
variable "os_name" {
    default = "ami-0f58b397bc5c1f2e8"
}
variable "instance-type" {
    default = "t2.micro"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "key_name" {
  description = "kp1"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to spread the subnets across"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"] // Update with your desired availability zones
}
