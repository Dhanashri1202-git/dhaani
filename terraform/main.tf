provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "dev_key" {
  key_name   = "dev-key"
  public_key = file("${path.module}/my-key.pub")
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg-New"
  description = "Allow SSH and Strapi ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "StrapiSecurityGroup"
  }
}

resource "aws_instance" "strapi_ec2" {
  ami                         = "ami-0b09627181c8d5778" # Amazon Linux 2 AMI
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.dev_key.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "StrapiAppServer"
  }
}


