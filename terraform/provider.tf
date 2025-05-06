provider "aws" {
  region = var.aws_region

  default_tags {
	tags = {
		Project = var.project_name
		Owner 	= var.project_owner
  	}
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
