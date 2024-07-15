# ec2.tf
resource "aws_instance" "app_server" {
  ami           = "ami-08cb9e86d3adf9004"
  instance_type = "t2.micro"

  tags = {
    Name = "AppServer"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.app_server.public_ip} > public_ip.txt"
  }
}

