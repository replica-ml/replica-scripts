FROM alpine:latest

COPY . /scripts
WORKDIR /scripts

RUN ls -al && \
    apk add findutils && \
    find /scripts -not -path '*/.git/*' -type f && \
#   . ./conf-no-all.env.sh && \
    ./install.sh
