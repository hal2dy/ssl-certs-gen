# SSL Certificate generate

Generate (wildcard) SSL certificate issue by [LetsEncrypt](https://letsencrypt.org/) with ACME client [dehydrated](https://github.com/lukas2511/dehydrated) using DNS-01 challenge type. Works with domain that manage on CloudFlare. The generated certificate will be upload and store on AWS S3 `ssl-certs` bucket

## Require

- Docker
- CloudFlare API Token with `Zone:Read` and `DNS:Edit` permission
- AWS Access Key to upload to S3

## Usage

```bash
docker build -t ssl-certs-gen .
```

```bash
docker run -e CLOUDFLARE_TOKEN="xxx" -e AWS_ACCESS_KEY_ID="xxx" -e AWS_SECRET_ACCESS_KEY="xxx" -e DOMAIN="yourname.com" ssl-certs-gen
```

wildcard ssl certificate of the giving domain will be created on S3

```bash
*.yourname.com-CERTFILE-1575446868.pem
*.yourname.com-CHAINFILE-1575446868.pem
*.yourname.com-FULLCHAINFILE-1575446868.pem
*.yourname.com-KEYFILE-1575446868.pem
```

update nginx with cert file

```bash
# cp "${KEYFILE}" "${FULLCHAINFILE}" /etc/nginx/ssl/; chown -R nginx: /etc/nginx/ssl
# systemctl reload nginx
```

## Example docker run output

```
# INFO: Using main config file //config
+ Generating account key...
+ Registering account key with ACME server...
+ Fetching account ID...
+ Done!

# INFO: Using main config file //config
 + Creating chain cache directory //chains
Processing *.yourname.com
 + Creating new directory //certs/yourname.com ...
 + Signing domains...
 + Generating private key...
 + Generating signing request...
 + Requesting new certificate order from CA...
 + Received 1 authorizations URLs from the CA
 + Handling authorization for yourname.com
 + 1 pending challenge(s)
 + Deploying challenge tokens...
 - Wait for 60 seconds...
 + Responding to challenge for yourname.com authorization...
 + Challenge is valid!
 + Cleaning challenge tokens...
 + Checking certificate...
 + Done!
 + Creating fullchain.pem...

upload: certs/yourname.com/privkey.pem to s3://ssl-certs/*.yourname.com/*.yourname.com-KEYFILE-1575446868.pem
upload: certs/yourname.com/cert.pem to s3://ssl-certs/*.yourname.com/*.yourname.com-CERTFILE-1575446868.pem
upload: certs/yourname.com/fullchain.pem to s3://ssl-certs/*.yourname.com/*.yourname.com-FULLCHAINFILE-1575446868.pem
upload: certs/yourname.com/chain.pem to s3://ssl-certs/*.yourname.com/*.yourname.com-CHAINFILE-1575446868.pem
 + Done!
```
