resource "aws_instance" "example" {
  ami           = var.os_name  # Specify your desired AMI
  instance_type = var.instance-type       # Specify your desired instance type
  subnet_id     = aws_subnet.private[0].id  # Reference the first private subnet
  key_name      = var.key_name  # Reference the created key pair
  tags = {
    Name = "example-ec2"
  }
}
