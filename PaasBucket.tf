data "oci_objectstorage_namespace" "NS" {
}

resource "oci_objectstorage_bucket" "PaaSBucket" {
	#Required
	compartment_id = "${var.compartment}"
	name = "PaaSBucket"
	namespace = "${data.oci_objectstorage_namespace.NS.namespace}"
}
