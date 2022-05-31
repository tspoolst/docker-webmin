FROM debian:stretch
MAINTAINER Trent Spoolstra <tspoolst@gmail.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN echo root:pass | chpasswd && \
    echo "Acquire::GzipIndexes \"false\"; Acquire::CompressionTypes::Order:: \"gz\";" >/etc/apt/apt.conf.d/docker-gzip-indexes

RUN echo Etc/UTC \> /etc/localtime && \
  ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

RUN apt-get -y update && \
    apt-get -y install \
    net-tools \
    apt-transport-https \
    apt-utils \
    wget \
    gnupg \
  && \
  apt-get -y clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://www.webmin.com/jcameron-key.asc && \
    apt-key add jcameron-key.asc && \
    rm -f jcameron-key.asc && \
    echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list && \
    echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y webmin python && \
    apt-get -y clean && \
      rm -rf /tmp/* /var/tmp/* && \
      rm -rf /var/lib/apt/lists/*

ENV LC_ALL C.UTF-8

EXPOSE 10000

CMD /usr/bin/touch /var/webmin/miniserv.log && /usr/sbin/service webmin restart && /usr/bin/tail -f /var/webmin/miniserv.log
