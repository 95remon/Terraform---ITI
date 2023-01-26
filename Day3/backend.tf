
terraform {
  backend "s3" {
    bucket = "terraform-iti-remon-louis"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-iti-dynamodb"
  }
}
