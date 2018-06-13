provider "oci" {
  tenancy_ocid     = "${var.tenancy}"
  user_ocid        = "${var.user}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.privatekeylocation}"

  #  private_key_password = "${var.private_key_password}"
  region = "${var.region}"
}
/*
#Create Compartmens
#Comparment reference for Prod env
resource "oci_identity_compartment" "compartment" {
  #Required
  compartment_id = "${var.tenancy}"
  description    = "Comparment for enviroment"
  name           = "${var.comp}"
}


#Create Identity Group
#Groups for user who can get access to the compartment
resource "oci_identity_group" "group" {
  #Required
  compartment_id = "${var.tenancy}"
  description    = "Group who have access to Compartment"
  name           = "${var.group}"
}

#Create Policy
#Create Policy for user to get full access to the compartment
resource "oci_identity_policy" "policy" {
  #Required
  compartment_id = "${var.tenancy}"
  description    = "Give full access to all the resource in the Compartment"
  name           = "${var.policy}"
  statements     = ["Allow group Group to manage all-resources in compartment Compartment"]

  #Common Policies - //docs.us-phoenix-1.oraclecloud.com/Content/Identity/Concepts/commonpolicies.htm
  #Optional
  version_date = "2018-04-17"
}
*/

#Create VCN
#Create the VCN for the compartment
resource "oci_core_vcn" "vcn" {
  #Required
  cidr_block     = "${var.vcn_cidr_block}"
  compartment_id = "${var.compartment}"
  dns_label      = "mydnslabel"

  #Optional
  display_name = "${var.vcn}"
}

#Create Subnet
#Create the an subnet for the VCN
#This is a Public Subnet, can be access over the internet. 
resource "oci_core_subnet" "subnet_dmz" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "192.168.1.0/24"
  display_name        = "Subnet_DMZ"
  compartment_id      = "${var.compartment}"
  vcn_id              = "${oci_core_vcn.vcn.id}"
  security_list_ids   = ["${oci_core_security_list.seclist_dmz.id}"]
  route_table_id      = "${oci_core_route_table.rt.id}"
  dhcp_options_id     = "${oci_core_vcn.vcn.default_dhcp_options_id}"
  dns_label           = "dmz${oci_core_vcn.vcn.dns_label}"
}

#This is a Private Subnet, cannot be access over the internet. 
resource "oci_core_subnet" "subnet_1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "192.168.2.0/24"
  display_name        = "Subnet_1"
  compartment_id      = "${var.compartment}"
  vcn_id              = "${oci_core_vcn.vcn.id}"
  security_list_ids   = ["${oci_core_security_list.seclist_1.id}"]
  route_table_id      = "${oci_core_route_table.rt.id}"
  dhcp_options_id     = "${oci_core_vcn.vcn.default_dhcp_options_id}"
  dns_label           = "sub1${oci_core_vcn.vcn.dns_label}"
}

#Create Internet Gateway
resource "oci_core_internet_gateway" "ig" {
  compartment_id = "${var.compartment}"
  display_name   = "IG"
  vcn_id         = "${oci_core_vcn.vcn.id}"
}

#Create Route Table
resource "oci_core_route_table" "rt" {
  compartment_id = "${var.compartment}"
  vcn_id         = "${oci_core_vcn.vcn.id}"
  display_name   = "Table"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.ig.id}"
  }
}

# Create Security List
# Protocols are specified as protocol numbers.
# http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml
#Security List for DMZ Subnet
resource "oci_core_security_list" "seclist_dmz" {
  compartment_id = "${var.compartment}"
  vcn_id         = "${oci_core_vcn.vcn.id}"
  display_name   = "Seclist_DMZ"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"         //tcp
  }

  // allow outbound udp traffic on a port range
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "17"        // udp
    stateless   = true
  }

  // allow inbound ssh traffic from a specific port
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false
	
	tcp_options {
	// These values correspond to the destination port range.
    "min" = 22
    "max" = 22
	}
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true
  }
}

resource "oci_core_security_list" "seclist_1" {
  compartment_id = "${var.compartment}"
  vcn_id         = "${oci_core_vcn.vcn.id}"
  display_name   = "Seclist_1"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "192.168.1.0/24"
    protocol    = "6"         //tcp
  }

  // allow outbound udp traffic on a port range
  egress_security_rules {
    destination = "192.168.1.0/24"
    protocol    = "17"        // udp
    stateless   = true
  }

  // allow inbound ssh traffic from a specific port
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "192.168.1.0/24"
    stateless = false
	
	tcp_options {
    // These values correspond to the destination port range.
    "min" = 22
    "max" = 22
	}
   }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "192.168.1.0/24"
    stateless = true
  }
}
#Instances
#Bastion Host for access the enviroment
resource "oci_core_instance" "instance_bastion" {
  count               = "1"
  availability_domain = "${oci_core_subnet.subnet_dmz.availability_domain}"
  compartment_id      = "${var.compartment}"
  display_name        = "Bastion${count.index+1}"
  hostname_label      = "Bastion${count.index+1}"
  shape               = "VM.Standard1.2"

  source_details {
    source_type = "image"
    source_id   = "var.image-Oracle-Linux-7-5-2018-05-09-1" #https://docs.us-phoenix-1.oraclecloud.com/images/image/b858e2a2-2ba8-43ef-86b3-57f1aa735a28/
  }

  metadata {
		ssh_authorized_keys = "${file(var.ssh_key_bastion)}"
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
  shape               = "VM.Standard1.2"

  source_details {
    source_type = "image"
    source_id   = "var.image-Oracle-Linux-7-5-2018-05-09-1" #https://docs.us-phoenix-1.oraclecloud.com/images/image/b858e2a2-2ba8-43ef-86b3-57f1aa735a28/
  }

  metadata {
		ssh_authorized_keys = "${file(var.ssh_key_bastion)}"
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

