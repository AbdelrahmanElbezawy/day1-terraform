#create-EC2
resource "aws_instance" "instance1" {
ami = "ami-0dfcb1ef8550277af"
instance_type = "t2.micro"
#key_name= "C:\\Users\\norins\\Desktop\\terraform\\iti.pem.pub"


subnet_id = ["aws_subnet.main.id"]

associate_public_ip_address = "true"


vpc_security_group_ids = [aws_security_group.allow_http.id]
root_block_device {
   delete_on_termination = true
   volume_size = 8
   volume_type = "gp2"
 }

user_data = <<EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
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