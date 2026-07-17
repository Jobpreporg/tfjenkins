module "ec2-dev" {
  source = "./modules/ec2"

  instance_name = "dev-${var.instance_name}"
  instance_type = var.instance_type
  ami           = var.ami
}

module "ec2-model" {
  source = "./modules/ec2"

  instance_name = "model-${var.instance_name}"
  instance_type = var.instance_type
  ami           = var.ami
}

module "ec2-prod" {
  source = "./modules/ec2"

  instance_name = "prod-${var.instance_name}"
  instance_type = var.instance_type
  ami           = var.ami
}

module "ec2-qa" {
  source = "./modules/ec2"

  instance_name = "qa-${var.instance_name}"
  instance_type = var.instance_type
  ami           = var.ami
}

module "ec2-uat" {
  source = "./modules/ec2"

  instance_name = "uat-${var.instance_name}"
  instance_type = var.instance_type
  ami           = var.ami
}

