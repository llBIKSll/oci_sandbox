#Basic Settings - Need to be change before any deployments
#Tenant information - 
# Tenant - you tenant
variable "ref_tenancy" {
  type        = "string"
  default     = "ocid1.tenancy.oc1..aaaaaaaa3pi2x5yqidqenk4ybimduwxvmlwcuxuetz7k3iuini4jjlmmy36q"
  description = "Tenancy id"
}

#Region and Availability Domain
#Region - wish region do you want to deploy to?
variable "ref_region" {
  type        = "string"
  default     = "us-ashburn-1"
  description = "The region for Demo Refrence Architeture"
}

#Availability Domain - AD do you want to deploy to?
variable "ref_availability_domain" {
  type        = "string"
  default     = "Uocm:IAD-AD-1"
  description = "The AD for Demo Refrence Architeture"
}

# Deployment user - used to deploy the Demo Reference Architeture
variable "ref_user" {
  type        = "string"
  default     = "ocid1.user.oc1..aaaaaaaa7ael4fy6ox4zmjyjqvy5qb4sv5wfmkicr4no3yundyk7w57k5x7a"
  description = "Deployment User for Demo Refrence Architeture"
}

#Fingerprint - the fingerprint from the PEM certficate
variable "ref_fingerprint" {
  type        = "string"
  default     = "88:b6:8e:45:86:36:fb:3d:c2:50:9e:4a:3a:2c:b4:e2"
  description = "Fingerprint from the PEM certficate for Demo Refrence Architeture"
}

#PrivateKey location - point to the location where you have the key file
variable "ref_privatekeylocation" {
  type        = "string"
  default     = ".\\.oci\\oci_api_key.pem"
  description = "The full path for the private key file for Demo Refrence Architeture"
}

#Advanced Configuration - only done if you need to change default settings

#Comparments
#Comparment reference for Demo Env
variable "ref_comp_demo" {
  type        = "string"
  default     = "Demo_Compartment"
  description = "Comparment for Demo Refrence - NOT FOR PROD"
}

#Groups
#Group that have access to the Demo Compartment
variable "ref_group_demo" {
  type        = "string"
  default     = "Demo_Group"
  description = "Group who have access to Demo Compartment - NOT FOR PROD"
}

#Availability Domain
variable "ref_availability_demo_iad1" {
  type        = "string"
  default     = "0"
  description = "IAD AD1  to Demo Compartment - NOT FOR PROD"
}

#Policies
#Policy Full Access Demo Compartment, give user full access
variable "ref_policy_demo" {
  type        = "string"
  default     = "Demo_Group_Full_Access"
  description = "Give full access to all the resource in the  Demo Compartment- NOT FOR PROD"
}

#VCN - Networking
#VCN for the Demo Compartment
variable "ref_vcn_demo" {
  type        = "string"
  default     = "Demo_VNC"
  description = "VNC for Demo Compartment - NOT FOR PROD"
}

#CIDR - ip range for VNC for the Demo Compartment
variable "ref_vcn_cidr_block_demo" {
  type        = "string"
  default     = "192.168.0.0/16"
  description = "VNC ip range for Demo Compartment- NOT FOR PROD"
}

#Subnet for the VNC to the Demo Compartment
variable "ref_subnet__demo" {
  type        = "string"
  default     = "192.168.0.0/24"
  description = "VNC ip range for Demo Compartment - NOT FOR PROD"
}

#Instances
#Bastion

