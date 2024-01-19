#ec2 isntances
resource "aws_instance" "webapp" {
  ami           = var.ami               
  instance_type = var.instance_type     
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Maya!" > index.html
              python3 -m http.server 8080 &
              EOF
  tags = {
    Name  = var.instance_name
  }
}