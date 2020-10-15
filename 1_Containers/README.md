## Packer directory

Contains configuration and scrips to create Ubuntu-18.04 box with Packer.

Usage: `packer build ubuntu1804`

Note: it is possible to use existing iso image of Ubuntu 18.04. Download it [here](http://cdimage.ubuntu.com/ubuntu/releases/bionic/release/ubuntu-18.04.5-server-amd64.iso) and put in Ubuntu_18.04/iso directory.


## Vagrant directory

Vagrant configuration for Ubuntu-18.04: Vagrantfile with Ansible provision and port forwarding

Usage: `vagrant up --no-provision && vagrant provision`

## Docker directory

devtest.sh - bash script to start Docker container with nginx, port fowarding 8080:80 and mounted nginx/etc directory.

Dockerfile_task contains Dockerfile to run Ubuntu container with apache2, JDK and ntp.
Create image: `sudo docker build -t ubuntu_apache .`.
Run container: `sudo docker run -d -it --name grek_apache2 -p 8081:80 ubuntu_apache`
You can find this image on [Dockerhub](https://hub.docker.com/r/skeptic2000/ubuntu_apache).


TODO: build the same machine for QEMU, provide mariadb instead of mysql, Docker-compose tasks