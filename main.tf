
provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::290566818138:role/Terraform_assumeRole"
  }

}

data "terraform_remote_state" "operational_environment" {

  backend = "s3"
  config = {
    region = "us-east-1"
    bucket = "koljitechs.vpcstatebuckets"
    key    = format("env:/%s/terraform.tfstate", lower(terraform.workspace))

  }

}
locals {
  operational_environment = data.terraform_remote_state.operational_environment.output.vpc_output
  vpc_id                  = local.operational_environment.vpc_id
  pub_subnet              = local.operational_environment.pub_subnet
  private_subnet          = local.operational_environment.private_subnet
  database_subnet         = local.operational_environment.database_subnet
  vpc_cidr                = local.operational_environment.vpc_cidr

}
