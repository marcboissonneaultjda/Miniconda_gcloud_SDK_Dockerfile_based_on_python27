****************************************************************************** 
# Setup Linux machine with ubuntu (same setup as on the docker image)

## Download Ubuntu
[Ubuntu download page](http://www.ubuntu.com/download/desktop):
Download the ubuntu iso

## Install Virtual Box
[Virtual Box download page](https://www.virtualbox.org/wiki/Downloads)
1. Create a new virtual machine
    - Type: linux
    - Version: Ubuntu
    - Memory: At least 1G
    - Create a Virtual Hard Drive 
        - VDI (Virtual Box Disk Image)
        - Dynamically allocated
        - At Least 15GB of Size
1. Start the machine
    - Startup disk: your ubuntu iso

> Once installed and started, open a terminal and configure default size in Menu edit/profile

## Install base programs
- apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y bzip2 curl unzip docker.io && apt-get clean && rm -rf /var/lib/apt/lists/*

## Download Sublime Text 3 & Install
- curl -o /tmp/sublime.deb http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3065_amd64.deb && dpkg --install /tmp/sublime.deb && rm -rf /tmp/sublime.deb  
- ln -s /opt/sublime_text/sublime_text /usr/local/bin/subl

> From HERE Run as root if possible: sudo -s 

## Install Miniconda
- cat <<EOF > /etc/profile.d/miniconda.sh
- export MINICONDA_VERSION=3.8.3
- export PATH=/opt/miniconda/bin:\$PATH
- EOF

- source /etc/profile.d/miniconda.sh                  **OR Log out and login again to apply the environment variables**

- curl -o /tmp/miniconda.sh http://repo.continuum.io/miniconda/Miniconda-$MINICONDA_VERSION-Linux-x86_64.sh && bash /tmp/miniconda.sh -b -p /opt/miniconda && rm /tmp/miniconda.sh

## Install Cloud SDK
- cat <<EOF > /etc/profile.d/google-cloud-sdk.sh
- export CLOUDSDK_PYTHON_SITEPACKAGES=1
- export PATH=\$PATH:/opt/google-cloud-sdk/bin
- export PYTHONPATH=/opt/google-cloud-sdk/platform/google_appengine/:\$PYTHONPATH
- EOF

- source /etc/profile.d/google-cloud-sdk.sh           **OR Log out and login again to apply the environment variables**

- curl -o /tmp/google-cloud-sdk.zip https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip /tmp/google-cloud-sdk.zip -d /opt && rm /tmp/google-cloud-sdk.zip && /opt/google-cloud-sdk/install.sh --usage-reporting false --bash-completion false --path-update false --additional-components pkg-python preview app

****************************************************************************** 
# Command to build / push the docker image

## Build the docker file
On a terminal: 
- sudo docker build -t dockerhub_username/docker_image_name:v1 "Dockerfilelocation"
    - Example: sudo docker build -t marcboissonneaultjda/jda_miniconda-gcloud-sdk:v1 .
> once build the image id will be shown, keep a note of that id because we may need it later on

## Push the docker image to DockerHub
- sudo docker push dockerhub_username/docker_image_name:v1

## Automated Build of the docker image
See [Automated Build page](http://docs.docker.com/docker-hub/builds/)
- You need to link docker hub to your github account and follow the instructions