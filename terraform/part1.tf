
#vpc
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  #assign_generated_ipv6_cidr_block = "true"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  tags = {
    Name = "iti-vpc"
  }
}
#subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

 # ipv6_cidr_block = "2600:1f10:473a:2900::/64"
 # assign_ipv6_address_on_creation = "true"

  tags = {
    Name = "iti-subnet"
  }
}
#internet-gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "iti-gw"
  }
}
#route-table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
    route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "iti-route-table"
  }
}
#table-association
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}
#create_network_interface
data "aws_network_interfaces" "main" {
  filter {
    name   = "subnet-id"
    values = [aws_subnet.main.id]
  }
  tags = {
    Name = "iti-network-interface"
  }
}

output "interface" {
  value = data.aws_network_interfaces.main.id
}