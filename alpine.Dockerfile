FROM alpine:latest

COPY . /scripts
WORKDIR /scripts

RUN ls -al && . ./conf-no-all.env.sh && \
    ./setup.sh
