# ---------------------------------------------------------------------------
# Private Security Groups
#  - private subnets
#  - route table for subnets
#  - route table associations to all private subnets
# ---------------------------------------------------------------------------

resource "aws_security_group" "public_swarm-manager" {
	name = "${var.environment}.bdth-sg.${var.region}-public-swarm-manager"
	description = "Security Group for public web ui apps"

	ingress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	vpc_id = "${aws_vpc.bdth_vpc.id}",

	tags {
        Name = "${var.environment}.sg.${var.region}-public-swarm-manager",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}


resource "aws_security_group" "public_admin-ui-web" {
	name = "${var.environment}.bdth-sg.${var.region}-public-admin-ui-web"
	description = "Security Group for public web ui apps"

	ingress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	vpc_id = "${aws_vpc.bdth_vpc.id}",

	tags {
        Name = "${var.environment}.sg.${var.region}-public-admin-ui-web",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}


resource "aws_security_group" "public_admin-persistence" {
	name = "${var.environment}.bdth-sg.${var.region}-public-admin-persistence"
	description = "Security groups for public web apis"

	ingress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	vpc_id = "${aws_vpc.bdth_vpc.id}",

	tags {
        Name = "${var.environment}.sg.${var.region}-public-admin-persistence",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}

