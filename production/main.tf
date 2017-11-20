# ------------
# AWS Provider
# ------------
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}


# --------
# Key Pair
# --------
module "key_pair" {
  source = "git::https://github.com/brentwg/terraform-aws-key-pair.git?ref=1.0"

  key_pair_name   = "${var.key_pair_name}"
  public_key_path = "${var.public_key_path}"
}
