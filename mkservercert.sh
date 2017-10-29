[ -e server ] || mkdir server

openssl genrsa -out server/server-rsa.key 4096
openssl dsaparam -genkey 2048 | openssl dsa -out server/server-dsa.key
openssl ecparam -genkey -name prime256v1 | openssl ec -out server/server-ecdsa.key

cat <<EOF > server/server.cnf
[req]
prompt = no
distinguished_name = req_distinguished_name

[req_distinguished_name]
C = CN
ST = ShannXi
L = XiAn
O = Server Endpoint
CN = Some Nginx Web Server 
emailAddress = nginx-web-server@example.com
EOF

openssl req -new -config server/server.cnf -key server/server-rsa.key -out server/server-rsa.csr
openssl req -new -config server/server.cnf -key server/server-dsa.key -out server/server-dsa.csr
openssl req -new -config server/server.cnf -key server/server-ecdsa.key -out server/server-ecdsa.csr

chmod 400 server/server-rsa.key server/server-dsa.key server/server-ecdsa.key
chmod 444 server/server-rsa.csr server/server-dsa.csr server/server-ecdsa.csr
