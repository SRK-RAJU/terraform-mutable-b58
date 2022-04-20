resource "aws_db_subnet_group" "mysql" {
  name       = "mysql-dbsg-${var.env}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "mysql-dbsg-${var.env}"
  }
}


resource "aws_security_group" "mysql-rds" {
  name        = "allow_mysql_${var.env}"
  description = "Allow MySQL"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress = [
    {
      description      = "MySQL"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = local.all_cidr_vpc
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      security_groups  = []
    }
  ]

  egress = [
    {
      description      = "ALL"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      security_groups  = []
    }
  ]

  tags = {
    Name = "allow_mysql_${var.env}"
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  name                   = "terrafrom"
  username               = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["rds_mysql_user"]
  password               = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["rds_mysql_pass"]
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.mysql-rds.id]
  identifier             = "mysql-${var.env}"
}

resource "aws_route53_record" "mysql" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
  name    = "mysql-${var.env}.roboshop.internal"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.mysql.address]
}

resource "null_resource" "mysql-schema-load" {
  depends_on = [aws_route53_record.mysql]
  provisioner "local-exec" {
    command = <<EOT
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
cd /tmp
unzip -o /tmp/mysql.zip
cd mysql-main
mysql -h mysql-${var.env}.roboshop.internal -u ${jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["rds_mysql_user"]} -p${jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["rds_mysql_pass"]} <shipping.sql
EOT
  }
}
