FROM ubuntu:16.04
MAINTAINER Tord Kloster

ENV CODENAME xenial
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get update && \
    apt-get install -y wget apt-transport-https && \
    wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | apt-key add - && \
    echo "deb     https://sensu.global.ssl.fastly.net/apt $CODENAME main" | tee /etc/apt/sources.list.d/sensu.list && \
    apt-get update && \
    apt-get install -y sensu

COPY config/* /etc/sensu/conf.d

CMD ["start", "api"]
ENTRYPOINT ["/opt/sensu/bin/sensu-service"]
