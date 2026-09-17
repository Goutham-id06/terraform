#create vpc
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_vpc"
  }
}

#create subnet
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "public_subnet-2"
  }
}

#create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my_igw"
  }
}

#create route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "my_route_table"
  }
}

#create route table association
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.rt.id
}
#create sg 
resource "aws_security_group" "allow" {
  name        = "my_sg"
  description = "allow"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}


#crerate ec2
resource "aws_instance" "web" {
  ami                         = "ami-0e34b50e714a297f1"
  instance_type               = "t3.small"
  vpc_security_group_ids      = [aws_security_group.allow.id]
  subnet_id                   = aws_subnet.subnet-1.id
  associate_public_ip_address = true
  tags = {
    Name = "my_instance"
  }
}

#create s3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket        = "goutham-statefiles"
  force_destroy = true

  tags = {
    Name = "my_bucket"
  }
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#create rds subnet group
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

  tags = {
    Name = "my-db-subnet-group"
  }
}

#create rds security group
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
}

#create rds instance
resource "aws_db_instance" "my_db" {
  identifier              = "rds-1"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  backup_retention_period = 1
  apply_immediately       = true
  skip_final_snapshot     = true
  publicly_accessible     = true

}

# create rds read replica
resource "aws_db_instance" "my_db_read_replica" {
  identifier             = "rds-1-read-replica"
  replicate_source_db    = aws_db_instance.my_db.arn
  instance_class         = "db.t3.micro"
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = true
  skip_final_snapshot    = true
}

