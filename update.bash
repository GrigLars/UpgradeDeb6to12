#!/usr/bin/env bash

# THIS ONLY WORKS IN GENERIC SETUPS AND MAY BREAK THINGS, POSSIBLY IRREVOKABLY, FOR
#  UNUSAL SETUPS, KERNEL COMPILATIONS, DRIVERS, AND SO ON - USE AT OWN RISK!!!!

if [ "$(whoami)" != 'root' ]; then
	echo -e "\e[31;1m$0: ERROR: You have no permission to run $0 as non-root user.\e[0m"
	exit 1;
fi

## Handy guide
# Debian 6 squeeze
# Debian 7 wheezy
# Debian 8 jessi
# Debian 9 stretch
# Debian 10 buster   - "old old stable" about to expire as of this document 
# Debian 11 bullseye - old stable as of this document
# Debian 12 bookworm - current as of this document 

# Swap which with which.  This seems to break down between 8 and 9, when 
#  you have to change the conf from "archive" to the current ones
# More at https://wiki.debian.org/DebianReleases

OLD_AND_BUSTED=$(lsb_release -cs)
if [ -z $OLD_AND_BUSTED ]; then
	apt-get install lsb-release -y --force-yes
	OLD_AND_BUSTED=$(lsb_release -cs)
fi
# OLD_AND_BUSTED="squeeze"
# NEW_HOTNESS="wheezy"

# Handy space savers
apt-get clean
apt-get autoremove -y
    
# One last update
apt-get update 
apt-get upgrade -y --force-yes --allow-unathenticated

case "${OLD_AND_BUSTED}" in 
  squeeze) 
    # Debian 6 => 7
    NEW_HOTNESS="wheezy" 
    cp -vp --backup=numbered /etc/apt/sources.list /etc/apt/sources.list.bak
    rm -f /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian squeeze main' > /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian squeeze-lts main' >> /etc/apt/sources.list
    echo 'Acquire::Check-Valid-Until false;' >> /etc/apt/apt.conf
  ;;
  wheezy) 
    # Debian 7 => 8
    NEW_HOTNESS="jessie" 
    cp -vp --backup=numbered /etc/apt/sources.list /etc/apt/sources.list.bak
    rm -f /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian jessie main' > /etc/apt/sources.list
    echo 'deb-src http://archive.debian.org/debian jessie main' >> /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian-security/ jessie/updates main' >> /etc/apt/sources.list
    echo 'deb-src http://archive.debian.org/debian-security/ jessie/updates main' >> /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian jessie-updates main' >> /etc/apt/sources.list
    echo 'deb-src http://archive.debian.org/debian jessie-updates main' >> /etc/apt/sources.list
  ;;
  jessie) 
    # Debian 8 => 9
    NEW_HOTNESS="stretch" 
    cp -vp --backup=numbered /etc/apt/sources.list /etc/apt/sources.list.bak
    rm -f /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian stretch main' > /etc/apt/sources.list
    echo 'deb-src http://archive.debian.org/debian stretch main' >> /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian-security/ stretch/updates main' >> /etc/apt/sources.list
    echo 'deb-src http://archive.debian.org/debian-security/ stretch/updates main' >> /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian stretch-updates main' >> /etc/apt/sources.list
  ;;
  stretch) 
    # Debian 9 => 10
    NEW_HOTNESS="buster" 
    cp -vp --backup=numbered /etc/apt/sources.list /etc/apt/sources.list.bak
    rm -f /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian buster main' > /etc/apt/sources.list
    echo 'deb-src http://archive.debian.org/debian buster main' >> /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian-security/ buster/updates main' >> /etc/apt/sources.list
    echo 'deb-src http://archive.debian.org/debian-security/ buster/updates main' >> /etc/apt/sources.list
    echo 'deb http://archive.debian.org/debian buster-updates main' >> /etc/apt/sources.list
  ;;
  buster)
    # Debian 10 => 11
    NEW_HOTNESS="bullseye"
    sed -i "s/${OLD_AND_BUSTED}/${NEW_HOTNESS}/g" /etc/apt/sources.list
    sed -i "s/archive/deb/g" /etc/apt/sources.list
  ;;
  bullseye)
    # Debian 11 => 12
    NEW_HOTNESS="bookworm"
    sed -i "s/${OLD_AND_BUSTED}/${NEW_HOTNESS}/g" /etc/apt/sources.list
    sed -i "s/archive/deb/g" /etc/apt/sources.list
  ;;
  *)
    echo "I could not determine which Debian you were using from lsb_release or it is already on Debian 12 bookworm"
    exit 1
   ;;
esac

DEB_VERSION=$(cat /etc/debian_version)
echo -e "\e[37;1mDEBIAN ${DEB_VERSION} \e[0m\n"

sleep 3

apt-get update
apt-get upgrade -y --force-yes
apt-get dist-upgrade -y --force-yes

echo -e "----------------\n :: NOW REBOOT :: \n----------------\n"
exit 0;
