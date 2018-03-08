# ---------------------------------------------------------------------------
# Set Environment Instance Id
# ---------------------------------------------------------------------------
resource "random_id" "env-instance" {
  byte_length = 8
}

# ---------------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------------
resource "aws_vpc" "bdth_vpc" {
	cidr_block = "${var.vpc_cidr}",
	enable_dns_support = "true",
	enable_dns_hostnames  = "true",

	tags {
        Name = "${var.environment}.vpc.${var.region}",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}

# ---------------------------------------------------------------------------
# Internet Gateway
# ---------------------------------------------------------------------------
resource "aws_internet_gateway" "bdth_igw" {
	vpc_id = "${aws_vpc.bdth_vpc.id}",

	tags {
        Name = "${var.environment}.igw.${var.region}",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}

# ---------------------------------------------------------------------------
# Routing table for public subnets
# ---------------------------------------------------------------------------
resource "aws_route_table" "public" {
	vpc_id = "${aws_vpc.bdth_vpc.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.bdth_igw.id}"
	},

	tags {
        Name = "${var.environment}.route-table.${var.region}-public",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}

# ---------------------------------------------------------------------------
# Routing table for public subnets
# ---------------------------------------------------------------------------
resource "aws_route_table" "private" {
	vpc_id = "${aws_vpc.bdth_vpc.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.bdth_igw.id}"
	},

	tags {
        Name = "${var.environment}.route-table.${var.region}-private",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}
