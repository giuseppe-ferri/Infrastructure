provider "aws" {
  region = "us-east-2"
  alias  = "region_1"

  # Tags to apply to all AWS resources by default
  default_tags {
    tags = {
      Owner     = "team-devops"
      ManagedBy = "Terraform"
    }
  }
}

provider "aws" {
  region = "us-west-1"
  alias  = "region_2"

  # Tags to apply to all AWS resources by default
  default_tags {
    tags = {
      Owner     = "team-devops"
      ManagedBy = "Terraform"
    }
  }
}

data "aws_region" "region_1" {
  provider = aws.region_1
}

data "aws_region" "region_2" {
  provider = aws.region_2
}

resource "aws_instance" "region_1" {
  provider = aws.region_1

  # Note different AMI IDS!!
  ami           = data.aws_ami.ubuntu_region_1.id
  instance_type = "t2.micro"
}

resource "aws_instance" "region_2" {
  provider = aws.region_2

  # Note different AMI IDS!!
  ami           = data.aws_ami.ubuntu_region_2.id
  instance_type = "t2.micro"
}

data "aws_ami" "ubuntu_region_1" {
  provider = aws.region_1

  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_region_2" {
  provider = aws.region_2

  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

output "region_1" {
  description = "The name of the first region"
  value       = data.aws_region.region_1.name
}

output "region_2" {
  description = "The name of the second region"
  value       = data.aws_region.region_2.name
}

output "instance_region_1_az" {
  value       = aws_instance.region_1.availability_zone
  description = "The AZ where the instance in the first region deployed"
}

output "instance_region_2_az" {
  value       = aws_instance.region_2.availability_zone
  description = "The AZ where the instance in the second region deployed"
}

output "ami_region_1" {
  value = data.aws_ami.ubuntu_region_1.id
}

output "ami_region_2" {
  value = data.aws_ami.ubuntu_region_2.id
}