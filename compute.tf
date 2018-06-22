#Instances
#Bastion Host for access the enviroment
resource "oci_core_instance" "instance_bastion" {
  count               = "1"
  availability_domain = "${oci_core_subnet.subnet_dmz.availability_domain}"
  compartment_id      = "${var.compartment}"
  display_name        = "Bastion${count.index+1}"
  hostname_label      = "Bastion${count.index+1}"
  shape               = "VM.Standard2.1"

  source_details {
    source_type = "image"
    source_id   = "${var.image-Oracle-Linux-7-5-2018-05-09-1["${var.region}"]}" #https://docs.us-phoenix-1.oraclecloud.com/images/image/b858e2a2-2ba8-43ef-86b3-57f1aa735a28/
  }

  metadata {
		ssh_authorized_keys = "${file(var.ssh_public_key)}"
		# user_data = "${base64encode(file(var.custom_bootstrap_file_name))}"
	}
  create_vnic_details {
    subnet_id              = "${oci_core_subnet.subnet_dmz.id}"
    skip_source_dest_check = true
    assign_public_ip       = true
  }

  timeouts {
    create = "60m"
  }
}

#Management Host for access the enviroment
resource "oci_core_instance" "instance_mng" {
  count               = "1"
  availability_domain = "${oci_core_subnet.subnet_1.availability_domain}"
  compartment_id      = "${var.compartment}"
  display_name        = "Management${count.index+1}"
  hostname_label      = "Management${count.index+1}"
  shape               = "VM.Standard2.1"

  source_details {
    source_type = "image"
    source_id   = "${var.image-Oracle-Linux-7-5-2018-05-09-1["${var.region}"]}" #https://docs.us-phoenix-1.oraclecloud.com/images/image/b858e2a2-2ba8-43ef-86b3-57f1aa735a28/
  }

  metadata {
		ssh_authorized_keys = "${file(var.ssh_public_key)}"
		# user_data = "${base64encode(file(var.custom_bootstrap_file_name))}"
	}
  create_vnic_details {
    subnet_id              = "${oci_core_subnet.subnet_1.id}"
    skip_source_dest_check = true
    assign_public_ip       = false
  }

  timeouts {
    create = "60m"
  }
}

