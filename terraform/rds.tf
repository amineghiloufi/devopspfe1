# rds.tf

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.subnet.id]

  tags = {
    Name = "MainDBSubnetGroup"
  }
} #Defines a new database subnet group resource named main, includes the ID of the subnet created in the vpc.tf file and adds a tag to the subnet group for easy identification

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "13.15"
  instance_class       = "db.t2.micro"
  name                 = "pfe"
  username             = "postgres"
  password             = "jegojego"
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  skip_final_snapshot  = true

  tags = {
    Name = "MyDatabaseInstance"
  }
} #Defines a new RDS instance resource

