#!/bin/sh
# This can be run like this:
# apt update && apt install -y ca-certificates curl && source <(curl -s https://raw.githubusercontent.com/1-fares/docker_server_script/master/debian_install_software.sh)

if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

set -x

apt-get update && \
apt-get remove nano -y && \
apt-get upgrade -y && \
apt-get install -y \
	bash \
	vim \
	man \
	less \
	htop \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	software-properties-common \
	git \
	screen \
	autoconf \
	bison \
	libxml2-dev \
	libsqlite3-dev \
	libcurl4-openssl-dev \
	libssl-dev \
	pkg-config \
	zlib1g-dev \
	libzip-dev \
	g++ \
	&& \
echo "" > /etc/motd && \
echo "startup_message off" >> /etc/screenrc && \
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable" && \
apt-get update && \
apt-get install docker-ce -y && \
curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
echo "Next steps:" && \
echo "update-alternatives --config editor" && \
echo "git config --global credential.helper cache" && \
echo "usermod -aG docker USERNAME" && \
exit 0

exit 1
