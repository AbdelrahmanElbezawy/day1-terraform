#create-security-group
resource "aws_security_group" "allow_http" {
  name        = "allow_http_ssh"
  description = "Allow http-ssh inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  #  ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  #  ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  #  ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  tags = {
    Name = "allow_http"
  }
}
