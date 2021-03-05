FROM debian:10
RUN apt-get update && apt-get install -y  default-jre-headless wget
RUN apt-get install -y vim-tiny
WORKDIR /root

RUN wget 'https://apache.osuosl.org/jena/binaries/apache-jena-3.17.0.tar.gz' && tar -xaf apache-jena-3.17.0.tar.gz

WORKDIR /root/apache-jena-3.17.0/bin/
