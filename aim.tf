#Create Compartmens
/*
#Comparment reference for Prod env
resource "oci_identity_compartment" "compartment" {
  #Required
  provider = "oci.ashburn"
  compartment_id = "${var.tenancy}"
  description    = "Comparment for enviroment"
  name           = "${var.comp}"
}


#Create Identity Group
#Groups for user who can get access to the compartment
resource "oci_identity_group" "group" {
  #Required
  provider = "oci.ashburn"
  compartment_id = "${var.tenancy}"
  description    = "Group who have access to Compartment"
  name           = "${var.group}"
}

#Create Policy
#Create Policy for user to get full access to the compartment
resource "oci_identity_policy" "policy" {
  #Required
  provider = "oci.ashburn"
  compartment_id = "${var.compartment}"
  description    = "Give full access to all the resource in the Compartment"
  name           = "${var.policy}"
  statements     = ["Allow group Demo_Group to manage all-resources in compartment Demo_Compartment"] 
  # I need to make smarter, no hard code values

  #Common Policies - //docs.us-phoenix-1.oraclecloud.com/Content/Identity/Concepts/commonpolicies.htm
  #Optional
  version_date = "2018-04-17"
}
*/