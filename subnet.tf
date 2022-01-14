resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Sravani_VPC"
  }
}

resource "aws_subnet" "private" {
  count                   = 2
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(var.subnet_cidr, count.index)}"
  map_public_ip_on_launch = false

  tags = {
    Name        = "sravani_private"
    Environment = "${terraform.workspace}"
  }
}

