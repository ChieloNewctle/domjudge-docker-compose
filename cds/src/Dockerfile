FROM ubuntu:latest

MAINTAINER Chielo Newctle

RUN apt-get update -y && apt-get install -y ca-certificates

COPY sources.list /etc/apt/sources.list

RUN apt-get update -y && apt-get install -y unzip openjdk-11-jdk

ADD wlp.CDS-2.1.2100.zip /opt/

WORKDIR /opt

RUN unzip wlp.CDS-2.1.2100.zip

WORKDIR /opt/wlp

ENTRYPOINT ["/opt/wlp/bin/server", "run", "cds"]
