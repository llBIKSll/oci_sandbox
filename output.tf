# Bastion Host information
# Output the private and public IPs of the instance
output "Bastion Host Information" {
value = ""
}

output "Bastion_PrivateIPs" {
value = ["${oci_core_instance.instance_bastion.*.private_ip}"]
}

output "Bastion_PublicIPs" {
value = ["${oci_core_instance.instance_bastion.*.public_ip}"]
}

# Management Host information
output "Management Host Information" {
value = []
}

output "Mng_PrivateIPs" {
value = ["${oci_core_instance.instance_mng.*.private_ip}"]
}

output "Mng_PublicIPs" {
value = ["${oci_core_instance.instance_mng.*.public_ip}"]
}