openssl ecparam -genkey -name prime256v1 -noout -out root_ecc.key
openssl req -new -key root_ecc.key -out root_ecc.csr -config root_req.config
openssl ca -in root_ecc.csr -out root_ecc.pem -config root_ecc.config -selfsign -extfile ca.ext -days 1095

openssl ecparam -genkey -name prime256v1 -noout -out intermediate_ecc.key
openssl req -new -key intermediate_ecc.key -out intermediate_ecc.csr -config intermediate_req.config
openssl ca -in intermediate_ecc.csr -out intermediate_ecc.pem -config root_ecc.config -extfile ca.ext -days 730

openssl ecparam -genkey -name prime256v1 -noout -out leaf_ecc.key
openssl req -new -key leaf_ecc.key -out leaf_ecc.csr -config leaf_req.config
openssl ca -in leaf_ecc.csr -out leaf_ecc.pem -config intermediate_ecc.config -days 365

openssl verify -x509_strict -CAfile root_ecc.pem -untrusted intermediate_ecc.pem leaf_ecc.pem
