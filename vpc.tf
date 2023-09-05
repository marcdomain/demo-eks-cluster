data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name"                                      = var.cluster_name,
    "kubernetes.io/cluster/${var.cluster_name}" = "owned",
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_eip" "nat" {
  count  = var.single_nat_gateway ? 1 : local.number_of_azs[local.environment]
  domain = "vpc"

  tags = {
    Name = "${var.cluster_name}-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = var.single_nat_gateway ? 1 : local.number_of_azs[local.environment]
  subnet_id     = aws_subnet.public[count.index].id
  allocation_id = aws_eip.nat[count.index].id

  tags = {
    Name = "${var.cluster_name}-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_subnet" "private" {
  count             = local.number_of_azs[local.environment]
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name"                                      = "${var.cluster_name}-private-${count.index + 1}"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public" {
  count             = local.number_of_azs[local.environment]
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name"                                      = "${var.cluster_name}-public-${count.index + 1}"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}
