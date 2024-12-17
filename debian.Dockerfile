FROM debian:bookworm-slim

COPY . /scripts
WORKDIR /scripts

RUN ls -al && . ./conf-no-all.env.sh && \
    ./setup.sh
