 variable "aws_region" {
   description = "The region in which to create the infrastructure"
   type        = string
   nullable    = false
   default     = "us-east-1" 
   validation {
     condition = var.aws_region == "us-east-1" || var.aws_region == "us-west-2"
     error_message = "The variable 'aws_region' must be one of the following regions: us-east-1, us-west-2"
   }
}



provider "aws" {
  region = var.aws_region
  }

 resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "my_vpc"
    }
}

#after run this will get error like The variable 'aws_region' must be one of the following regions: us-west-2,â eu-west-1, so it will allow any one region defined above in conditin block


#Example-2
 variable "environment" {
  type    = string
  default = "prod"
}

resource "aws_instance" "example" {
  count         = var.environment == "dev" ? 3 : 1
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.micro"

  tags = {
    Name = "example-${count.index}"
  }
}

# #In this case:
# #If var.environment == "prod" â count = 3
# #Else (like dev, qa, etc.) â count = 1
# #terraform apply -var="environment=dev"