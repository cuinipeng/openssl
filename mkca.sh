[ -e ca ] || mkdir ca

openssl genrsa -out ca/ca-rsa.key 4096
openssl dsaparam -genkey 2048 | openssl dsa -out ca/ca-dsa.key
openssl ecparam -genkey -name prime256v1 | openssl ec -out ca/ca-ecdsa.key

cat <<EOF > ca/ca.cnf
[req]
prompt = no
distinguished_name = req_distinguished_name

[req_distinguished_name]
C = CN
ST = ShannXi
L = XiAn
O = Root Certificate Authority
CN = CA-Level-0
emailAddress = ca-level-0@example.com
EOF

openssl req -new -x509 -days 365 -config ca/ca.cnf -key ca/ca-rsa.key -out ca/ca-rsa.crt
openssl req -new -x509 -days 365 -config ca/ca.cnf -key ca/ca-dsa.key -out ca/ca-dsa.crt
openssl req -new -x509 -days 365 -config ca/ca.cnf -key ca/ca-ecdsa.key -out ca/ca-ecdsa.crt

chmod 400 ca/ca-rsa.key ca/ca-dsa.key ca/ca-ecdsa.key
chmod 444 ca/ca-rsa.crt ca/ca-dsa.crt ca/ca-ecdsa.crt
