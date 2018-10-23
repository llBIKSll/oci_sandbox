mkdir .oci
openssl.exe genrsa -out ./.oci/oci_api_key.pem 2048
openssl rsa -pubout -in ./.oci/oci_api_key.pem -out ./.oci/oci_api_key_public.pem
openssl rsa -pubout -outform DER -in ./.oci/oci_api_key.pem | openssl md5 -c
openssl rsa -pubout -outform DER -in ./.oci/oci_api_key.pem | openssl md5 -c > ./.oci/oci_api_key_fingerprint
REM copy the contents of bmcs_api_key_public.pem to the clipboard. 
cat ./.oci/oci_api_key_public.pem
