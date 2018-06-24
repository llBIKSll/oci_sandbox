# Create a Policy to get PSM access to the compartment, so it support deployment of DB CS Classic and Java CS Classic
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
