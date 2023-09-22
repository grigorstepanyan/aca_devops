resource "aws_eip" "aca_eip" {
  instance = aws_instance.web_aca.id
  domain   = "vpc"
}

output "public_ip" {
  value = aws_instance.web_aca.public_ip
  }
