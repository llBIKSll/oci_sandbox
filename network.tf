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
    destination_type  = "CIDR_BLOCK"
    destination       = "0.0.0.0/0"
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
