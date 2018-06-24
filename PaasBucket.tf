# Pull Object storage information for later use
data "oci_objectstorage_namespace" "NS" {
}


# Create a Storage Bucket , so it support deployment of DB CS Classic and Java CS Classic
resource "oci_objectstorage_bucket" "PaaSBucket" {
	#Required
	compartment_id = "${var.compartment}"
	name = "PaaSBucket"
	namespace = "${data.oci_objectstorage_namespace.NS.namespace}"
}
