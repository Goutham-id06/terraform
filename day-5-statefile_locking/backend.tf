terraform {
  backend "s3" {
    bucket = "goutham-statefiles"
    key    = "terraform-statefile/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}