terraform {
  backend "s3" {
    bucket = "vani079093-sre-cicd-terraform-eks"
    region = "us-east-1"
    key    = "Jenkins-server-key/terraform.tfstate"
  }
}
