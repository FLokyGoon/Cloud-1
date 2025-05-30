resource "aws_vpc" "this" {
	cidr_block 				    = var.cidr_block
	enable_dns_hostnames 	= true
	enable_dns_support		= true
}

resource "aws_internet_gateway" "igw" {
  vpc_id 	= aws_vpc.this.id
}

resource "aws_subnet" "public" {
  count						        = length(var.public_subnet_cidrs)
  vpc_id 					        = aws_vpc.this.id
  cidr_block 				      = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone			  = var.public_azs[count.index]
}

resource "aws_route_table" "public" {
  vpc_id		= aws_vpc.this.id
  
  route {
	  cidr_block = "0.0.0.0/0"
	  gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
	count			      = length(aws_subnet.public)
	subnet_id		    = aws_subnet.public[count.index].id
	route_table_id  = aws_route_table.public.id
}
