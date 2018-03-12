
resource "aws_security_group" "elb-public" {
	name = "${var.environment}.bdth-sg.${var.region}-elb"
	description = "Security groups for public logging elb"

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

	vpc_id = "${aws_vpc.bdth_admin_vpc.id}",

	tags {
        Name = "bdth-admin.${var.environment}.sg.${var.region}-elb",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}


resource "aws_elb" "elb-public" {
    name = "${var.environment}-bdth-elb-${var.region}"
    subnets = ["${aws_subnet.az-1-public.id}"]
    security_groups = ["${aws_security_group.elb-public.id}"]

    listener {
        instance_port = 81
        instance_protocol = "tcp"
        lb_port = 80
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 4
        unhealthy_threshold = 4
        timeout = 3
        target = "TCP:81"
        interval = 15
    }

    instances = ["${aws_instance.swarm-manager-az-1.id}", "${aws_instance.admin-logging-az-1.id}", "${aws_instance.admin-monitoring-az-1.id}"]
    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    tags {
        Name = "bdth-admin.${var.environment}-bdth-elb-${var.region}",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    }
}