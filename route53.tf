provider "aws" {
    region = "ap-south-1"
}

resource "ec2_instance" "my-instance" {
ami = 
instance_type = "t2.mirco"
key_name      =  "mumbai"
tags          = {
    Name = "First_ec2"

}
 }
resource "ec2_instance" "my-instance-2" {
ami = 
instance_type = "t2.mirco"
key_name      =  "mumbai"
tags          = {
    Name = "Second_ec2"

}
 }
data "aws_vpc" "testing" {
    default = true
}
output "check_my_vpc_id" {
      value = data.aws_vpc.testing.id
}

resource "aws_route53_zone" "my-test-zone" {
    name = sarang.cloud

vpc {
    vpc_id = data.aws_vpc.testing.id
}   
comment = 'terraform-route-53 demo'
  tags = {
    Environment = "demo"
  }
  }
resource "aws_route53_record" "first_record" {
    zone_id = aws_route53_zone.my-test-zone.zone_id
    name    = "first.sarang.cloud"
    type    = "A"
    ttl     = 300
    records = [aws_instance.my-instance.private_ip]
}
resource "aws_route53_record" "second_record" {
     zone_id = aws_route53_zone.my-test-zone.zone_id
    name    = "first.sarang.cloud"
    type    = "A"
    ttl     = 300
    records = [aws_instance.my-instance-2.private_ip]
}

