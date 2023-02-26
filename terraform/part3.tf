#create-EC2
resource "aws_instance" "instance1" {
ami = "ami-0dfcb1ef8550277af"
instance_type = "t2.micro"
#key_name= "C:\\Users\\norins\\Desktop\\terraform\\iti.pem.pub"

subnet_id = "subnet-033a3ccb168f23a9b"

associate_public_ip_address = "true"



security_groups = ["sg-02cab93b0cf2e2e62"]
root_block_device {
   delete_on_termination = true
   volume_size = 8
   volume_type = "gp2"
 }
user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd.x86_64
  sudo systemctl start httpd.service
  sudo systemctl enable httpd.service
  EOF
tags = {
  Name = "iti-ec2"
}

}
output "web_instance_ip" {
    value = aws_instance.instance1.public_ip
}