## the provider
provider "aws" {
  region  = "us-west-1"
  profile = "my-profile"

}

# creating vpc
resource "aws_vpc" "tf_auto_vpc" {
  cidr_block = "10.0.0.0/16"
}

# creating a subnet
resource "aws_subnet" "tf_auto_subnet" {
  vpc_id                  = "aws_vpc.tf_auto_vpc.id"
  cidr_block              = "10.0.0.0/16"
  availability_zone       = "us-west-1"
  map_public_ip_on_launch = true
}

# creating security group
resource "aws_security_group" "tf_auto_sg" {
  name        = "terraform_automation_sg"
  description = "Security Group for terraform automation"
}

## creating ec2 instance (ubuntu )
resource "aws_instance" "tf_auto_instance" {
  ami           = "ami-0f8e81a3da6e2510a"
  instance_type = "t2.micro"
  tags = {
    "Name" = "Ayoterraform-automation-instance1"
  }


  ## installing packages on the instance
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install nginx -y
  sudo systemctl start nginx
  sudo systemctl enable nginx
  sudo apt install npm -y
  EOF

}


