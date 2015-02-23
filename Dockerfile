# Dockerfile extending the generic Python image with application files for a
# single application.
FROM google/appengine-python27

ENV LANG C.UTF-8

ENV MINICONDA_VERSION 3.7.0
ENV PATH /opt/miniconda/bin:$PATH
#ENV PYTHONPATH /opt/miniconda/lib/site-packages#:/opt/miniconda/lib/python2.7/site-packages
ENV PATH /opt/miniconda/lib/site-packages:$PATH

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y bzip2 curl unzip && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN curl -o /tmp/miniconda.sh http://repo.continuum.io/miniconda/Miniconda-$MINICONDA_VERSION-Linux-x86_64.sh && bash /tmp/miniconda.sh -b -p /opt/miniconda && rm /tmp/miniconda.sh

ADD requirements_conda.txt /app/
RUN conda install --yes --quiet --file requirements_conda.txt

ADD requirements.txt /app/
RUN pip install -r requirements.txt

ADD . /app/