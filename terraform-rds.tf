variable "password" {
  type    = string
  default = null
}


resource "aws_db_instance" "mysql_db" {
  allocated_storage       = 10
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  username                = "root"
  password                = var.password
  parameter_group_name    = "default.mysql5.7"
  vpc_security_group_ids  = [aws_security_group.rds_sg1.id]
  skip_final_snapshot     = true
 
  tags = {
    Name = "aca_web"
  }
}

resource "aws_security_group" "rds_sg1" {
  name        = "rds_sg1"
  description = "Allow sql traffic"
  tags = {
    Name = "local_only_mysql"
  }

  ingress {
    description      = "MySQL"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["172.16.0.0/12"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.mysql_db.address
}
