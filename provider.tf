provider "oci" {
  tenancy_ocid     = "${var.tenancy}"
  user_ocid        = "${var.user}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.privatekeylocation}"

  #  private_key_password = "${var.private_key_password}"
  region = "${var.region}"
}
provider "oci" {
  alias = "ashburn"
  tenancy_ocid     = "${var.tenancy}"
  user_ocid        = "${var.user}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.privatekeylocation}"

  #  private_key_password = "${var.private_key_password}"
  region = "us-ashburn-1"
}
