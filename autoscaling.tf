provider "aws" {
    region = "ap-south-1"  
}
resource "aws_security_group" "instancesecurity" {
    name = "sravani"  
    vpc_id = "${aws_vpc.sravanivpc.id}"
}
resource "aws_vpc" "sravanivpc" {
    cidr_block = "192.168.0.0/16"
    tags = {
      "Name" = "Terraform-VPC"
    }
}
  
resource "aws_internet_gateway" "sravaniinternetgw" {
    vpc_id = aws_vpc.sravanivpc.id
    tags = {
      "Name" = "Terraform-IGW"
    }
}

resource "aws_route" "sravaniassociate" {
    route_table_id = aws_vpc.sravanivpc.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sravaniinternetgw.id
}

resource "aws_security_group_rule" "sravani-security-group" {
    to_port = 22
    from_port = 22
    cidr_blocks =  ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.instancesecurity.id}"
    protocol = "tcp"
    type = "ingress"    
}

resource "aws_subnet" "sravanisubnet" {
    cidr_block = "192.168.1.0/24"
    vpc_id = "${aws_vpc.sravanivpc.id}"
    availability_zone = "us-west-1a"
}

resource "aws_instance" "terraform-instance" {
    ami = "ami-0d5075a2643fdf738"
    instance_type = "t2.micro"
    key_name = "test"
    subnet_id = "${aws_subnet.sravanisubnet.id}"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [aws_security_group.instancesecurity.id]
    tags = {
      "Name" = "Terrainstance"
    }
}
