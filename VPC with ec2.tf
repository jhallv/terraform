
provider "aws" {
  region = var.location
}

resource "aws_instance" "ec2-terra" {
    ami = var.os-name
    key_name = var.key
    instance_type = var.instance-type
    subnet_id = aws_subnet.subnet_terra.id
    vpc_security_group_ids = [aws_security_group.terra-vpc-sg.id] 

}

//Create VPC
resource "aws_vpc" "vpc-terra" {
  cidr_block = var.vpc-cidr
}

//Create Subnet
resource "aws_subnet" "subnet_terra" {
  vpc_id = aws_vpc.vpc-terra.id
  cidr_block = var.subnet-cidr

  tags = {
    Name = "subnet_terra"
  }
}

//Create internet gateway
resource "aws_internet_gateway" "gw_terra" {
  vpc_id = aws_vpc.vpc-terra.id

  tags = {
    Name = "gw_terra"
  }
}

//Create Route Table
resource "aws_route_table" "rt-terra" {
  vpc_id = aws_vpc.vpc-terra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_terra.id
  }

  tags = {
    Name = "rt=terra"

  }
}

//Associate the Subnet
resource "aws_route_table_association" "t-rt-associ"{
  subnet_id = aws_subnet.subnet_terra.id
  route_table_id = aws_route_table.rt-terra.id

}

//Create Security Group
resource "aws_security_group" "terra-vpc-sg" {
  name        = "terra-vpc-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-terra.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "terra-vpc-sg"
  }
}
