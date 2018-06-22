# This enviroment is for Test,Dev and learnings use cases
# It is NOT for Production setup


# Basic Settings - Need to be change before any deployments
# Tenant information
# Tenant - you tenant
variable "tenancy" {} # the input will come from the enviroment variable file (windows env.bat, linux env-vars)

# Comparment - the Comparment where the enviroment will be deployed in
variable "compartment" {} # # the input will come from the enviroment variable file (windows env.bat, linux env-vars)

# Region and Availability Domain
# Region - wish region do you want to deploy to?
variable "region" {} # the input will come from the enviroment variable file (windows env.bat, linux env-vars)

# Deployment user - used to deploy the enviroment
variable "user" {} # the input will come from the enviroment variable file (windows env.bat, linux env-vars)

# Fingerprint - the fingerprint from the PEM certficate
variable "fingerprint" {} # the input will come from the enviroment variable file (windows env.bat, linux env-vars)

# PrivateKey location - point to the location where you have the key file
variable "privatekeylocation" {} # the input will come from the enviroment variable file (windows env.bat, linux env-vars)

# Public SSH Key location - point to the location where you have the key file
variable "ssh_public_key" {
  type        = "string"
  default     = ".\\.ssh\\id_rsa.pub"
}

#Advanced Configuration - only done if you need to change default settings

# Comparments
# Comparment reference for enviroment
variable "comp" {
  type        = "string"
  default     = "Demo_Compartment"
}

# Root Comparment
variable "rootcomp" {
	type = "string"
	default = "ocid1.tenancy.oc1..aaaaaaaaq4opdzi7h3t6zlqj2nrbeidvmyugbwbgr3et3rtojwfsp7vu5zrq"
}

# Groups
# Group that have access to the enviroment
variable "group" {
  type        = "string"
  default     = "Demo_Group"
}

# Policies
# Policy Full Access enviroment, give user full access
variable "policy" {
  type        = "string"
  default     = "Demo_Group_Full_Access"
}

# VCN - Networking
# VCN for the enviroment
variable "vcn" {
  type        = "string"
  default     = "VNC"
}

# CIDR - ip range for VNC for the enviroment
variable "vcn_cidr_block" {
  type        = "string"
  default     = "192.168.0.0/16"

}
# Image locations
variable "image-Oracle-Linux-7-5-2018-05-09-1" {
  type = "map"

  default = {
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaazregkysspxnktw35k4r5vzwurxk6myu44umqthjeakbkvxvxdlkq"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaa6ybn2lkqp2ejhijhehf5i65spqh3igt53iyvncyjmo7uhm5235ca"
    uk-london-1 =	"ocid1.image.oc1.uk-london-1.aaaaaaaayodsld656eh5stds5mo4hrmwuhk2ugin4eyfpgoiiskqfxll6a4a"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaozjbzisykoybkppaiwviyfzusjzokq7jzwxi7nvwdiopk7ligoia"
  }
}
