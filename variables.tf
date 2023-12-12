variable "location" {
    default = "us-east-2" 
}

variable "os-name" {
    default = "ami-06d4b7182ac3480fa"
}

variable "instance-type" {
    default = "t2.micro"
}

variable "key" {
    default = "kp-1"
}

variable "vpc-cidr" {
    default = "10.10.0.0/16"
  
}

variable "subnet-cidr" {
    default = "10.10.1.0/24"
  
}

