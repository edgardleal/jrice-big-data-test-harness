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

resource "aws_instance" "admin-ui-web-az-1" {
	ami = "${lookup(var.amis_docker_node, "${var.region}")}"
	availability_zone = "${lookup(var.availability_zone, "${var.region}.az-1")}"
	instance_type = "${lookup(var.ec2-instance-type, "${var.environment-size}.admin-ui-web")}"
	key_name = "${var.aws_key_name}"
	security_groups = ["${aws_security_group.public_admin-ui-web.id}"]
	subnet_id = "${aws_subnet.az-1-public.id}",
	monitoring = "true",
	provisioner "local-exec" {
       command = "echo "
    }

	tags {
        Name = "${var.environment}.instance.swarm-worker.admin-ui-web.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}",
        bdth.instance-name-full = "${var.environment}.instance.swarm-worker.admin-ui-web.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}"
        bdth.instance-name = "admin-ui-web-${var.region}-az-1"
        bdth.environment = "${var.environment}"
    	bdth.failure-zone = "${var.region}-az-1"
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    	bdth.swarm-instance-type = "swarm-worker"
    	bdth.swarm-node-type = "admin-ui-web"
    	bdth.subnet-type = "public"
    }
}

resource "aws_instance" "admin-persistence-az-1" {
	ami = "${lookup(var.amis_docker_node, "${var.region}")}"
	availability_zone = "${lookup(var.availability_zone, "${var.region}.az-1")}"
	instance_type = "${lookup(var.ec2-instance-type, "${var.environment-size}.admin-persistence")}"
	key_name = "${var.aws_key_name}"
	security_groups = ["${aws_security_group.public_admin-persistence.id}"]
	subnet_id = "${aws_subnet.az-1-public.id}",
	monitoring = "true",
	provisioner "local-exec" {
       command = "echo "
    }

	tags {
        Name = "${var.environment}.instance.swarm-worker.admin-persistence.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}",
        bdth.instance-name-full = "${var.environment}.instance.swarm-worker.admin-persistence.${var.environment}.${lookup(var.availability_zone, "${var.region}.az-1")}"
        bdth.instance-name = "admin-persistence-${var.region}-az-1"
        bdth.environment = "${var.environment}"
    	bdth.failure-zone = "${var.region}-az-1"
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    	bdth.swarm-instance-type = "swarm-worker"
    	bdth.swarm-node-type = "admin-persistence"
    	bdth.subnet-type = "public"
    }
}