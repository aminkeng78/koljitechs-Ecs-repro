
module "aurora" {
  source = "git::https://github.com/Bkoji1150/aws-rdscluster-kojitechs-tf.git"

  name           = local.name
  engine         = "aurora-mysql"
  engine_version = "5.7.12"
  instances = {
    1 = {
      instance_class      = "db.r5.large"
      publicly_accessible = false
    }
    # 2 = {
    #   identifier     = format("%s-%s", "kojitechs-${var.component-name}", "reader-instance")
    #   instance_class = "db.r5.xlarge"
    #   promotion_tier = 15
    # }
  }
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  vpc_id = local.vpc_id
  #   db_subnet_group_name   = local.db_subnets_names
  subnets                = local.database_subnet
  create_db_subnet_group = true
  create_security_group  = false
  #   allowed_cidr_blocks    = local.private_sunbet_cidrs

  iam_database_authentication_enabled = true
  create_random_password              = false

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.example.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example.id
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  database_name                   = var.database_name
  master_username                 = var.master_username
}

resource "aws_db_parameter_group" "example" {
  name        = "${local.name}-aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${local.name}-aurora-db-57-parameter-group"

}

resource "aws_rds_cluster_parameter_group" "example" {
  name        = "${local.name}-aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${local.name}-aurora-57-cluster-parameter-group"
}