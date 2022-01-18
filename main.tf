provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"
}

resource "aws_s3_bucket" "mywb"{
    bucket = "website-code-mk"
    acl = "public-read"
    policy = file("policy.json")

    website{
        index_document = "index.html"
        error_document = "error.html"
    }
   

}

resource "aws_s3_bucket_object" "index" {
    bucket = aws_s3_bucket.mywb.id
    acl = "public-read"
    key = "index.html"
    source = "index.html"
    etag = filemd5("index.html")
    content_type = "text/html"

}

output name {
  value       = aws_s3_bucket.mywb.website_endpoint
  //sensitive   = true
  description = "description"
  //depends_on  = []
}
