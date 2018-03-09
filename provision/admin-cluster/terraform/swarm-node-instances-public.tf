# ---------------------------------------------------------------------------
# Build - Swarm Node Instances
#  - EC2 Instances for across 3 avail zones
# ---------------------------------------------------------------------------
resource "aws_instance" "swarm-manager-az-1" {
	ami = "${lookup(var.amis_docker_node, "${var.region}")}"
	availability_zone = "${lookup(var.availability_zone, "${var.region}.az-1")}"
	instance_type = "${lookup(var.ec2-instance-type, "${var.environment-size}.swarm-manager")}"
	key_name = "${var.aws_key_name}"
	security_groups = ["${aws_security_group.public_swarm-manager.id}"]
	subnet_id = "${aws_subnet.az-1-public.id}",
	monitoring = "true",
	provisioner "local-exec" {
       command = "echo "
    }

	tags {
        Name = "${var.environment}.instance.swarm-worker.swarm-manager.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}",
        bdth.instance-name-full = "${var.environment}.instance.swarm-worker.swarm-manager.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}"
        bdth.instance-name = "swarm-manager-${var.region}-az-1"
        bdth.environment = "${var.environment}"
    	bdth.failure-zone = "${var.region}-az-1"
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    	bdth.swarm-instance-type = "swarm-manager"
    	bdth.swarm-node-type = "swarm-manager"
    	bdth.subnet-type = "public"
    }
}

resource "aws_instance" "admin-logging-az-1" {
	ami = "${lookup(var.amis_docker_node, "${var.region}")}"
	availability_zone = "${lookup(var.availability_zone, "${var.region}.az-1")}"
	instance_type = "${lookup(var.ec2-instance-type, "${var.environment-size}.admin-logging")}"
	key_name = "${var.aws_key_name}"
	security_groups = ["${aws_security_group.public_admin-logging.id}"]
	subnet_id = "${aws_subnet.az-1-public.id}",
	monitoring = "true",
	provisioner "local-exec" {
       command = "echo "
    }

	tags {
        Name = "${var.environment}.instance.swarm-worker.admin-logging.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}",
        bdth.instance-name-full = "${var.environment}.instance.swarm-worker.admin-logging.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}"
        bdth.instance-name = "admin-logging-${var.region}-az-1"
        bdth.environment = "${var.environment}"
    	bdth.failure-zone = "${var.region}-az-1"
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    	bdth.swarm-instance-type = "swarm-worker"
    	bdth.swarm-node-type = "admin-logging"
    	bdth.subnet-type = "public"
    }
}


resource "aws_instance" "admin-monitoring-az-1" {
	ami = "${lookup(var.amis_docker_node, "${var.region}")}"
	availability_zone = "${lookup(var.availability_zone, "${var.region}.az-1")}"
	instance_type = "${lookup(var.ec2-instance-type, "${var.environment-size}.admin-monitoring")}"
	key_name = "${var.aws_key_name}"
	security_groups = ["${aws_security_group.public_admin-monitoring.id}"]
	subnet_id = "${aws_subnet.az-1-public.id}",
	monitoring = "true",
	provisioner "local-exec" {
       command = "echo "
    }

	tags {
        Name = "${var.environment}.instance.swarm-worker.admin-monitoring.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}",
        bdth.instance-name-full = "${var.environment}.instance.swarm-worker.admin-monitoring.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}"
        bdth.instance-name = "admin-monitoring-${var.region}-az-1"
        bdth.environment = "${var.environment}"
    	bdth.failure-zone = "${var.region}-az-1"
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    	bdth.swarm-instance-type = "swarm-worker"
    	bdth.swarm-node-type = "admin-monitoring"
    	bdth.subnet-type = "public"
    }
}