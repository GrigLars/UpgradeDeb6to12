#!/bin/bash

# THIS ONLY WORKS IN GENERIC SETUPS AND MAY BREAK THINGS, POSSIBLY IRREVOKABLY, FOR
#  UNUSAL SETUPS, KERNEL COMPILATIONS, DRIVERS, AND SO ON - USE AT OWN RISK!!!!

if [ "$(whoami)" != 'root' ]; then
	echo -e "\e[31;1m$0: ERROR: You have no permission to run $0 as non-root user.\e[0m"
	exit 1;
fi

## Handy guide
# Debian 6 squeeze
# Debian 7 wheezy
# Debian 8 jessie - "old old stable" about to expire as of this document
# Debian 9 stretch - old stable as of this document
# Debian 10 buster - current as of this document
# Debian 11 bullseye - testing as of this document

# Swap which with which.  This seems to break down between 8 and 9, when 
#  you have to change the conf from "archive" to the current ones

OLD_AND_BUSTED="squeeze"
NEW_HOTNESS="wheezy"

# Handy space savers
apt-get clean
apt-get autoremove -y
    
# One last update
apt-get update 
apt-get upgrade -y --force-yes

DEB_VERSION=$(cat /etc/debian_version)
echo -e "\e[37;1mDEBIAN ${DEB_VERSION} \e[0m\n"

sed -i "s/${OLD_AND_BUSTED}/${NEW_HOTNESS}/g" /etc/apt/sources.list

apt-get update
apt-get upgrade -y --force-yes
apt-get dist-upgrade -y --force-yes

echo -e "----------------\n :: NOW REBOOT :: \n----------------\n"
exit 0;
