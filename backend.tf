terraform {
  backend "s3" {
    bucket = "tf-bucket-prod1"
    key    = "uc9-latest/terraform.tfstate"
    region = "us-east-1"
    #use_lockfile = true
    encrypt = true
  }
}
