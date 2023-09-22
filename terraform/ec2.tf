data "aws_ami" "al" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.1.20230912.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_instance" "web_aca" {
  ami           = data.aws_ami.al.id
  instance_type = "t2.micro"
  key_name      = "aca _evops"
  vpc_security_group_ids = [ aws_security_group.allow_ssh_http.id ]

}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-05ac266e5928a688f"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


