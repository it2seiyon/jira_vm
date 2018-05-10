#!/usr/bin/env bash
set -e

echo -e "##############################\nLINE NUMBER: "$LINENO"\n##############################"

HOSTNAME="jira"
echo ${HOSTNAME} > /etc/hostname
echo "127.0.0.1 ${HOSTNAME}" >> /etc/hosts
hostname ${HOSTNAME}

echo -e "##############################\nLINE NUMBER: "$LINENO"\n##############################"

# create swap space to handle memory hungry processes
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile	none	swap	sw	0	0" >> /etc/fstab

echo -e "##############################\nLINE NUMBER: "$LINENO"\n##############################"
cd /opt
wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-7.2.13.tar.gz
mv atlassian-*.tar.gz jira.tar.gz
tar -xf jira.tar.gz
mv /opt/atlassian-jira* /opt/jira

echo -e "##############################\nLINE NUMBER: "$LINENO"\n##############################"

cp /etc/apt/sources.list /etc/apt/sources.list.backup
sed -i -e '/^deb/s#http://.*archive.ubuntu.com/ubuntu#http://ftp.daumkakao.com/ubuntu#' -e '/^deb/s#http://.*security.ubuntu.com/ubuntu#http://ftp.daumkakao.com/ubuntu#' /etc/apt/sources.list

apt-get -y clean
apt-get -y -q update

echo -e "##############################\nLINE NUMBER: "$LINENO"\n##############################"
echo "install oracle java 1.8"
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer

echo 'export JAVA_HOME=/usr/lib/jvm/java-8-oracle' >> ~/.profile
echo 'export PATH=$PATH:/usr/lib/jvm/java-8-oracle/bin' >> ~/.profile
source ~/.profile

echo -e "make home directory"
mkdir /opt/jira-home

echo 'jira.home =/opt/jira-home' > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties

/opt/jira/bin/startup.sh


echo -e '  ___    ____     ____   ___       _  __  ____'
echo -e ' / _ \  / ___|   / ___| |_ _|     | |/ / |  _ \'
echo -e '| | | | \___ \  | |      | |      |   /  | |_) |'
echo -e '| |_| |  ___) | | |___   | |   _  | . \  |  _ <'
echo -e ' \___/  |____/   \____| |___| (_) |_|\_\ |_| \_\'
