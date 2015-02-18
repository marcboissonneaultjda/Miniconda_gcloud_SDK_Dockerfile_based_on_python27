From google/appengine-python27
MAINTAINER Marc Boissonneault <marc.boissonneault@jda.com>

ENV LANG C.UTF-8

ENV MINICONDA_VERSION 3.7.0
ENV PATH /opt/miniconda/bin:$PATH

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y bzip2 curl unzip && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN curl -o /tmp/miniconda.sh http://repo.continuum.io/miniconda/Miniconda-$MINICONDA_VERSION-Linux-x86_64.sh && bash /tmp/miniconda.sh -b -p /opt/miniconda && rm /tmp/miniconda.sh