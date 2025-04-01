resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
}

terraform {
  backend "s3" {
    # Replace this with your bucket table name!
    bucket = "unique-name-bucket-jiow02"
    key    = "workspaces-example/ terraform.tfstate"
    region = "us-east-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "unique-name-dynamo-jiow02"
    encrypt        = true
  }
}
