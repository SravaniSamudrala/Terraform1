resource "aws_instance" "ec2-instance" {
  ami           ="ami-0892d3c7ee96c0bf7"
  instance_type = "t2.micro"

  tags = {
    Name = "env"
  }
}
