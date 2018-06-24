resource "oci_identity_policy" "PaaSPSMPolicy" {
	#Required
	compartment_id = "${var.root_compartment}"
	description = "Policies for PaaS Services"
	name = "PaaSPSMPolicy"
	statements = ["Allow service PSM to inspect vcns in compartment AlMana-Production",
								"Allow service PSM to use subnets in compartment AlMana-Production",
								"Allow service PSM to use vnics in compartment AlMana-Production",
								"Allow service PSM to manage security-lists in compartment AlMana-Production"]
}
