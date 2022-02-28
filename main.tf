terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = var.instance_region
}

resource "aws_key_pair" "key_pair" {
    key_name = "terraform_demo"
    public_key = file("/Users/rizwannadeem/.ssh/id_rsa.pub") 
}


resource "aws_instance" "app" {
  count = var.instance_count
  ami         = var.ami
  instance_type = var.instance_type

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install nginx -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
    EOF
  subnet_id  = data.aws_subnet.centtest-subnet-private.id
  vpc_security_group_ids =  ["${data.aws_security_group.centtest-sg.id}"]
  tags = {
      name = "Terraform-${var.ami}-${var.ec2_name[count.index]}"
  }
  key_name = aws_key_pair.key_pair.key_name 
}


data "aws_subnet" "centtest-subnet-private" {
  id = var.subnet_id_private.id
}

data "aws_security_group" "centtest-sg" {
   id = var.security_group_id.id
}

resource "aws_eip" "app-eip" {
    instance = "${element(aws_instance.app.*.id,count.index)}"
    count = var.instance_count
}
