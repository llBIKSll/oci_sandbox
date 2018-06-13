REM Authentication details
setx TF_VAR_tenancy "ocid1.tenancy.oc1..aaaaaaaa3pi2x5yqidqenk4ybimduwxvmlwcuxuetz7k3iuini4jjlmmy36q"
setx TF_VAR_user "ocid1.user.oc1..aaaaaaaa7ael4fy6ox4zmjyjqvy5qb4sv5wfmkicr4no3yundyk7w57k5x7a"
setx TF_VAR_fingerprint "88:b6:8e:45:86:36:fb:3d:c2:50:9e:4a:3a:2c:b4:e2"
setx TF_VAR_privatekeylocation ".\\.oci\\oci_api_key.pem"

REM Deployement Region
setx TF_VAR_region "eu-frankfurt-1"
REM eu-frankfurt-1, uk-london-1, us-ashburn-1, us-phoenix-1


REM Compartment
setx TF_VAR_compartment "ocid1.compartment.oc1..aaaaaaaaza5vfh3diisvf22lji7mcth4jnozi4mllzxg4hoar5rz6g5vusrq"

REM Public/private keys used on the instance
setx TF_VAR_ssh_public_key .\\.ssh\\id_rsa.pub
setx TF_VAR_ssh_private_key .\\.ssh\\id_rsa

REM Subnet AD
setx TF_VAR_AD "0"


