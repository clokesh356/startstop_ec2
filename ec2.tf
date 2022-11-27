resource "aws_security_group" "startstop" {
  name        = "startstop"
  description = "Allow  enduser"
  vpc_id      = "vpc-0a37326cc7e9d0a3d"


  ingress {
    description = "ssh for admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
   ingress {
    description = "http for enduser"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "startstop-sg"
    Terraform = "true"
  }
}

resource "aws_instance" "lamp" {
  ami           = "ami-02a66f06b3557a897"
  instance_type = "t2.micro"
  #   vpc_id =aws_vpc.vpc.id
  subnet_id              = "subnet-0765086ec1ec79fdb"
  vpc_security_group_ids = [aws_security_group.startstop.id]
  key_name               = "testing"
 
  tags = {
    Name = "startstop"
  }
}

