provider "oci" {
  tenancy_ocid     = "${var.ref_tenancy}"
  user_ocid        = "${var.ref_user}"
  fingerprint      = "${var.ref_fingerprint}"
  private_key_path = "${var.ref_privatekeylocation}"

  #  private_key_password = "${var.private_key_password}"
  region = "${var.ref_region}"
}

#Create Compartmens
#Comparment reference for Prod env
resource "oci_identity_compartment" "demo_compartment" {
  #Required
  compartment_id = "${var.ref_tenancy}"
  description    = "Comparment for Demo Refrence Architeture"
  name           = "${var.ref_comp_demo}"
}

/*
#Create Identity Group
#Groups for user who can get access to the demo compartment
resource "oci_identity_group" "demo_group" {
  #Required
  compartment_id = "${oci_identity_compartment.demo_compartment.id}"
  description    = "Group who have access to Demo Compartment - NOT FOR PROD"
  name           = "${var.ref_group_demo}"
}

#Create Policy
#Create Policy for user to get full access to the demo compartment
resource "oci_identity_policy" "demo_policy" {
  #Required
  compartment_id = "${oci_identity_compartment.demo_compartment.id}"
  description    = "Give full access to all the resource in the  Demo Compartment - NOT FOR PROD"
  name           = "${var.ref_policy_demo}"
  statements     = ["Allow group Demo_Group to manage all-resources in compartment Demo_Compartment"]

  #Common Policies - //docs.us-phoenix-1.oraclecloud.com/Content/Identity/Concepts/commonpolicies.htm
  #Optional
  version_date = "2018-04-17"
}
*/

#Create VCN
#Create the VCN for the demo compartment
resource "oci_core_vcn" "demo_vcn" {
  #Required
  cidr_block     = "${var.ref_vcn_cidr_block_demo}"
  compartment_id = "${oci_identity_compartment.demo_compartment.id}"
  dns_label      = "myoracledemo"

  #Optional
  display_name = "${var.ref_vcn_demo}"
}

#Create Subnet
#Create the an subnet for the VCN
#This Public Subnet, can be access over the internet. 
resource "oci_core_subnet" "demo_subnet_dmz" {
  availability_domain = "LBSi:US-ASHBURN-AD-1"
  cidr_block          = "192.168.1.0/24"
  display_name        = "Demo_Subnet_DMZ"
  compartment_id      = "${oci_identity_compartment.demo_compartment.id}"
  vcn_id              = "${oci_core_vcn.demo_vcn.id}"
  security_list_ids   = ["${oci_core_security_list.demo_seclist_dmz.id}"]
  route_table_id      = "${oci_core_route_table.demo_rt.id}"
  dhcp_options_id     = "${oci_core_vcn.demo_vcn.default_dhcp_options_id}"
  dns_label           = "${oci_core_vcn.demo_vcn.dns_label}"
}
#This Private Subnet, cannot be access over the internet. 
resource "oci_core_subnet" "demo_subnet_1" {
  availability_domain = "LBSi:US-ASHBURN-AD-1"
  cidr_block          = "192.168.2.0/24"
  display_name        = "Demo_Subnet_Private1"
  compartment_id      = "${oci_identity_compartment.demo_compartment.id}"
  vcn_id              = "${oci_core_vcn.demo_vcn.id}"
  security_list_ids   = ["${oci_core_security_list.demo_seclist_1.id}"]
  route_table_id      = "${oci_core_route_table.demo_rt.id}"
  dhcp_options_id     = "${oci_core_vcn.demo_vcn.default_dhcp_options_id}"
  dns_label           = "${oci_core_vcn.demo_vcn.dns_label}"
}

#Create Internet Gateway
resource "oci_core_internet_gateway" "demo_ig" {
  compartment_id = "${oci_identity_compartment.demo_compartment.id}"
  display_name   = "Demo_IG"
  vcn_id         = "${oci_core_vcn.demo_vcn.id}"
}

#Create Route Table
resource "oci_core_route_table" "demo_rt" {
  compartment_id = "${oci_identity_compartment.demo_compartment.id}"
  vcn_id         = "${oci_core_vcn.demo_vcn.id}"
  display_name   = "Demo_Table"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.demo_ig.id}"
  }
}

# Create Security List
# Protocols are specified as protocol numbers.
# http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml
#Security List for DMZ Subnet
resource "oci_core_security_list" "demo_seclist_dmz" {
  compartment_id = "${oci_identity_compartment.demo_compartment.id}"
  vcn_id         = "${oci_core_vcn.demo_vcn.id}"
  display_name   = "Demo_Seclist_DMZ"

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

    icmp_options {
      "type" = 3
      "code" = 4
    }
  }
}

resource "oci_core_security_list" "demo_seclist_1" {
  compartment_id = "${oci_identity_compartment.demo_compartment.id}"
  vcn_id         = "${oci_core_vcn.demo_vcn.id}"
  display_name   = "Demo_Seclist_1"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "192.168.2.0/24"
    protocol    = "6"         //tcp
  }

  // allow outbound udp traffic on a port range
  egress_security_rules {
    destination = "192.168.2.0/24"
    protocol    = "17"        // udp
    stateless   = true

    udp_options {
      // These values correspond to the destination port range.
      "min" = 319
      "max" = 320
    }
  }

  // allow inbound ssh traffic from a specific port
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "192.168.1.0/24"
    stateless = false

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
resource "oci_core_instance" "instance" {
  count               = "1"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ref_AD_demo.availability_domains["${count.index}"],"name")}"
  compartment_id      = "${oci_identity_compartment.demo_compartment.id}"
  display_name        = "Bastion${count.index}"
  hostname_label      = "Bastion${count.index}"
  shape               = "VM.Standard2.1"

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaaeookczfwutjxzifu2gcdgdx4yk6xls7d5fhtlqbrqzpaxdedny4a" #https://docs.us-phoenix-1.oraclecloud.com/images/image/b858e2a2-2ba8-43ef-86b3-57f1aa735a28/
  }

  metadata {
		ssh_authorized_keys = "${var.ssh_public_key}"
		user_data = "${base64encode(file(var.custom_bootstrap_file_name))}"
	}
  create_vnic_details {
    subnet_id              = "${oci_core_subnet.demo_subnet_dmz.id}"
    skip_source_dest_check = true
    assign_public_ip       = true
  }

  timeouts {
    create = "60m"
  }
}
