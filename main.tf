resource "aws_s3_bucket" "s3" {
  bucket = "site-files-shalonn"
}

resource "aws_s3_bucket_policy" "public_objects" {
  bucket = "site-files-shalonn"
  policy = data.aws_iam_policy_document.public_objects.json
}


resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "aws_internet_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "internet-route-table"
  }
}

resource "aws_route_table_association" "route_tbl_assoc_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.aws_internet_route_table.id
}

resource "aws_route" "internet_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.aws_internet_route_table.id
  gateway_id             = aws_internet_gateway.igw.id

}


resource "aws_security_group" "sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "open-sg"
  }
}

#  resource "aws_key_pair" "auth" {
#    key_name   = "shalonn"
#    public_key = file("shalonn.pem")
#}

resource "aws_instance" "ec2_red" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.server_ami.id

  tags = {
    Name = "red-ec2"
  }

  key_name               = "shalonn"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = file("userdata.sh")

}