#!/usr/bin/env bash

mkdir -p certs/${DOMAIN}/
aws s3 cp --quiet s3://${S3BUCKET}/${DOMAIN}/${DOMAIN}.FULLCHAIN.pem certs/${DOMAIN}/fullchain.pem
aws s3 cp --quiet s3://${S3BUCKET}/${DOMAIN}/${DOMAIN}.chain.pem certs/${DOMAIN}/chain.pem
aws s3 cp --quiet s3://${S3BUCKET}/${DOMAIN}/${DOMAIN}.crt certs/${DOMAIN}/cert.pem
aws s3 cp --quiet s3://${S3BUCKET}/${DOMAIN}/${DOMAIN}.key certs/${DOMAIN}/privkey.pem

echo "${DOMAIN} *.${DOMAIN}" > domains.txt

./dehydrated --register --accept-terms
./dehydrated --cron --challenge dns-01 --hook ./hook.sh
