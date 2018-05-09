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

cp -R /vagrant/lib/ /opt/

cd /opt

#wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-7.0.2-jira-7.0.2-x64.bin
#wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-7.9.0-x64.bin
wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-7.2.13-x64.bin

echo -e '  ___    ____     ____   ___       _  __  ____'
echo -e ' / _ \  / ___|   / ___| |_ _|     | |/ / |  _ \'
echo -e '| | | | \___ \  | |      | |      |   /  | |_) |'
echo -e '| |_| |  ___) | | |___   | |   _  | . \  |  _ <'
echo -e ' \___/  |____/   \____| |___| (_) |_|\_\ |_| \_\'
