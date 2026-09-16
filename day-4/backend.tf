terraform {
  backend "s3" {
    bucket = "goutham027"
    key    = "terraform-statefile/terraform.tfstate"
    region = "us-east-1"
  }
}