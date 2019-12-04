#!/usr/bin/env bash
./dehydrated --register --accept-terms
./dehydrated --cron --challenge dns-01 --domain "*.${DOMAIN} > ${DOMAIN}" --hook ./hook.sh