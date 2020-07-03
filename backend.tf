terraform {
  backend "remote" {
    organization = "YASH_Technologies_AWS"
    workspaces {
      name = "yash-terraform-aws"
    }
  }
}