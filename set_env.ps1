# Authentication details
setx TF_VAR_tenancy "ocid1.tenancy.oc1..aaaaaaaaq4opdzi7h3t6zlqj2nrbeidvmyugbwbgr3et3rtojwfsp7vu5zrq"
setx TF_VAR_user "ocid1.user.oc1..aaaaaaaaoxcnc5ik7bthl77v5634owqe2h33ackmfy6f6easbrvj3jfcocba"
setx TF_VAR_fingerprint "88:b6:8e:45:86:36:fb:3d:c2:50:9e:4a:3a:2c:b4:e2"
setx TF_VAR_privatekeylocation ".\\.oci\\oci_api_key.pem"

# Deployement Region, what region to use
setx TF_VAR_region "us-ashburn-1"
# eu-frankfurt-1, uk-london-1, us-ashburn-1, us-phoenix-1


# Compartment, the compartment to use
setx TF_VAR_compartment "ocid1.compartment.oc1..aaaaaaaaj2pr6wc2bk4ninhqgaqg2dfrtuquvjoro6ja3pp67lmn47btpdzq"

# Public/private keys used on the instance, the location
setx TF_VAR_ssh_public_key .\\.ssh\\id_rsa.pub
setx TF_VAR_ssh_private_key .\\.ssh\\id_rsa

# Subnet AD
setx TF_VAR_AD "0"
