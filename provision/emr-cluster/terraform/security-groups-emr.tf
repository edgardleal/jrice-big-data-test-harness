# ---------------------------------------------------------------------------
# Private Security Groups
#  - private subnets
#  - route table for subnets
#  - route table associations to all private subnets
# ---------------------------------------------------------------------------

resource "aws_security_group" "emr-master" {
	name = "${var.environment}.bdth-sg.${var.region}-emr-master"
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

	vpc_id = "${aws_vpc.bdth_emr_vpc.id}",

	tags {
        Name = "bdth-emr.${var.environment}.sg.${var.region}-emr-master",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}

resource "aws_security_group" "emr-slave" {
	name = "${var.environment}.bdth-sg.${var.region}-emr-slave"
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

	vpc_id = "${aws_vpc.bdth_emr_vpc.id}",

	tags {
        Name = "bdth-emr.${var.environment}.sg.${var.region}-emr-slave",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}

