# ---------------------------------------------------------------------------
# EMR Cluster
# ---------------------------------------------------------------------------
resource "aws_emr_cluster" "emr-cluster" {
  name          = "bdth-emr.${var.environment}.emr-cluster.${var.region}"
  release_label = "emr-5.12.0"
  applications  = ["Hadoop","Hive","Ganglia","Zeppelin","Spark"]

  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true
  log_uri                           = "s3://bdth-emr-cluster-logs/bdth-${var.environment}-${random_id.env-instance.b64}/"
  ebs_root_volume_size              = "100"

  ec2_attributes {
    subnet_id                         = "${aws_subnet.az-1-public.id}"
    emr_managed_master_security_group = "${aws_security_group.emr-master.id}"
    emr_managed_slave_security_group  = "${aws_security_group.emr-slave.id}"
    instance_profile                  = "${aws_iam_instance_profile.emr_profile.arn}"
	key_name                          = "${var.aws_key_name}"
  }

  instance_group = [
	  {
	      instance_role  = "MASTER"
	      instance_type  = "${lookup(var.ec2-instance-type, "${var.environment-size}.emr-master")}"
	      instance_count = "1"
	      name           = "bdth-emr.${var.environment}.instance.master.${var.region}"
	      ebs_config {
	        size  = "32"
	        type  = "gp2"
	        volumes_per_instance = 1
	      }
	      bid_price      = "${lookup(var.ec2-instance-bid-price, "${var.environment-size}.emr-master")}"
	  },
	  {
	      instance_role  = "CORE"
	      instance_type  = "${lookup(var.ec2-instance-type, "${var.environment-size}.emr-core")}"
	      instance_count = "${var.emr-cluster-core-instance-count}"
	      name           = "bdth-emr.${var.environment}.instance.core.${var.region}"
	      ebs_config {
	        size = "100"
	        type = "gp2"
	        volumes_per_instance = 1
	      }
	      bid_price = "${lookup(var.ec2-instance-bid-price, "${var.environment-size}.emr-master")}"
	  }
  ]
  
  tags {
    Name = "bdth-emr.${var.environment}.emr-cluster.${var.region}",
    bdth.instance-name-full = "bdth-emr.${var.environment}.emr-cluster.${var.region}"
    bdth.instance-name = "emr-cluster-${var.region}"
    bdth.environment = "${var.environment}"
	bdth.failure-zone = "${var.region}"
    bdth.environment-instance-id = "${random_id.env-instance.b64}"
	bdth.subnet-type = "public"
  }

  service_role = "${aws_iam_role.iam_emr_service_role.arn}"
}