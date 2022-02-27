variable "instance_count" {
    type = number 
    default = 1 
}

variable "ami" {
    type = string
    default = "ami-03a0c45ebc70f98ea"
}
variable "ec2_name" {
  type    = list(string)
  default = ["one"]
}

variable "instance_type" {
    type = string 
    default = "t2.micro"
  
}

variable "instance_region" {
    type = string 
    default = "us-east-2"
  
}

variable "vpc" {
    default = {
        id = "vpc-09dac9ec402870acb"
    }
}

variable "security_group_id" {
    default = {
        id = "sg-06484e5d78137cf6d"
    }
}


variable "subnet_id_private" {

   default = {
       id = "subnet-0210f8b8c4dd64b83"
   }  
}

variable "subnet_id_public" {

   default = {
       id = "subnet-02e17f960e79c5a8e"
   }  
}
