
provider "aws" {
  region = "us-east-1"
}

# create EC2 instance 
resource "aws_instance" "sql_runner" {
  ami                         = "ami-0fef201115eefe936"
  instance_type               = "t3.micro"
  key_name                    = "asd"
  associate_public_ip_address = true

  tags = {
    Name = "SQL server"
  }
}


# Create RDS instance
resource "aws_db_instance" "mysql_rds" {
  identifier          = "my-mysql-db"
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  username            = "admin"
  password            = "123456789"
  db_name             = "dev"
  allocated_storage   = 20
  skip_final_snapshot = true
  publicly_accessible = true
}

# Deploy SQL remotely using null_resource + remote-exec
resource "null_resource" "remote_sql_exec" {
  depends_on = [aws_db_instance.mysql_rds, aws_instance.sql_runner]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/Admin/Downloads/asd.pem")
    host        = aws_instance.sql_runner.public_ip
  }

  provisioner "file" {
    source      = "init.sql"
    destination = "/tmp/init.sql"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install mariadb105-server -y",
      "mysql -h ${aws_db_instance.mysql_rds.address} -u admin -p123456789 dev < /tmp/init.sql"
    ]
  }

  triggers = {
    always_run = timestamp()
  }

  #if any chnages in init.sql then execute
  #triggers = {
  #sql_file= filemd5("init.sql")
  #}


}
