resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    depends_on = [aws_s3_bucket.dev_s3]

}

resource "aws_s3_bucket" "dev_s3" {
    bucket        = "goutham-depends"
    force_destroy = true
}