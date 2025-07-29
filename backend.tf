terraform {
  backend "s3" {
    bucket = "terraform-state-pratyushaa94"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}
