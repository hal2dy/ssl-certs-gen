FROM alpine:3.10

RUN apk update 
RUN apk add bash openssl curl jq

RUN apk -Uuv add groff less python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*

ENV CLOUDFLARE_TOKEN=
ENV AWS_ACCESS_KEY_ID=
ENV AWS_SECRET_ACCESS_KEY=
ENV AWS_DEFAULT_REGION="ap-southeast-1"
ENV DOMAIN=
ENV S3BUCKET=

COPY config config
COPY hook.sh hook.sh
COPY dehydrated dehydrated
COPY entrypoint.sh entrypoint.sh
RUN chmod +x hook.sh
RUN chmod +x dehydrated
RUN chmod +x entrypoint.sh

# CMD tail -f /dev/null
ENTRYPOINT ["./entrypoint.sh"]