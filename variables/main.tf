provider "aws" { 
    region = "eu-east-1"
}


#string
variable "vpcname" {
    type = string
    default = "myvpc"
}

#numeros
variable "sshport" {
    type = number
    default = 22
}

#boolean
variable "enabled" {
    default = true
}

#listas
variable "mylist" {
    type = list (string)#strings or numbers
    default = ["Value1,Value2"]
}

variable "mymap" {
    type = map 
    default = {
        Key1 = "Value1"
        Key2 = "Value2"
    }
}

#VPC String
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = var.vpcname #or var.inputname 
                            #ESSE "var." vai embora e vc coloca só o nome que quer!!!
    }
}

#VPC List
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = var.mylist[0] #stars in 0
    }
}

#VPC MAP
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = var.mymap["Key2"]
    }
}

#VPC Input
variable "inputname"{
    type = string
    description = "Set the name of the VPC" 
}

#example in:
# resource "aws_vpc" "my-vpc" {
#    cidr_block = "10.0.0.0/16"
#
#    tags = {
#        Name = var.inputname

#Output
output "myoutput" {
    value = aws_vpc.my-vpc.id #in case of vpc 
}

#Tuples
variable "my tuple" {
    type = tuple([string,number,string]) #multiple data type
    default = ["cat",1,"dog"]
}

#Objects
variable "myobject" {
    type = object({name = string, port = list(number)})
    default = { 
        name = "TJ"
        port = [22, 25,80]
    }
}