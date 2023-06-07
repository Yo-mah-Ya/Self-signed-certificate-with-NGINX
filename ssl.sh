
# Generate private key
openssl genpkey \
    -algorithm RSA \
    -pkeyopt rsa_keygen_bits:2048 \
    -aes-256-cbc \
    -out privkey.pem

# Generate CSR
openssl req \
    -new -key privkey.pem \
    -out csr.pem

# Generate the certificate from CSR
openssl x509 \
    -req -in csr.pem \
    -signkey privkey.pem \
    -days 90 -out crt.pem


# Check certificate infos
openssl x509 -in crt.pem -noout -text


# move files under ./nginx/ssl
mkdir -p ./nginx/ssl
mv crt.pem ./nginx/ssl/
mv privkey.pem ./nginx/ssl/

touch ./nginx/ssl/passwd
chmod 600 ./nginx/ssl/passwd
# You need to write passphrase, which you used when you crated private key, to ./nginx/ssl/passwd
echo 'passphrase' > ./nginx/ssl/passwd
