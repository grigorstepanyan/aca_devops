
resource "aws_eip" "aca_eip" {
  domain   = "vpc"
  tags = {
    Name = "aca_web_eip"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web_aca.id
  allocation_id = aws_eip.aca_eip.id
}


output "public_ip" {
  value = aws_eip.aca_eip.public_ip
  }

