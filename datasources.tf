data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${oci_identity_compartment.demo_compartment.id}"
}

/*
  filter {
    name   = "name"
    values = ["\\w*-AD-1"]
    regex  = true
  }
}

data "oci_identity_availability_domains" "ad-iad" {
  //provider       = "oci.iad"
  compartment_id = "${var.ref_availability_demo_iad1}"

  filter {
    name   = "name"
    values = ["\\w*-AD-1"]
    regex  = true
  }
}

/*
output "ad-phx" {
  value = ["${data.oci_identity_availability_domains.ad-phx.availability_domains}"]
}

output "ad-iad" {
  value = ["${data.oci_identity_availability_domains.ad-iad.availability_domains}"]
}
*/

