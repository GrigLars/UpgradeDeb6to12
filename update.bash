#!/bin/bash

# THIS ONLY WORKS IN GENERIC SETUPS AND MAY BREAK THINGS, POSSIBLY IRREVOKABLY, FOR
#  UNUSAL SETUPS, KERNEL COMPILATIONS, DRIVERS, AND SO ON - USE AT OWN RISK!!!!


## Handy guide
# Debian 6 Squeeze
# Debian 7 Wheezy
# Debian 8 Jessie - "old old stable" about to expire as of this document
# Debian 9 Stretch - old stable as of this document
# Debian 10 Buster - current as of this document
# Debian 11 Bullseye - testing as of this document

# Swap which with which.  This seems to break down between 8 and 9, when 
#  you have to change the conf from "archive" to the current ones

    old_and_busted="squeeze"
    new_hotness="wheezy"

# Handy space savers
    sudo apt-get clean
    sudo apt-get autoremove -y
    
# One last update
    sudo apt-get update 
    sudo apt-get upgrade -y --force-yes

    version=$(cat /etc/debian_version)
    echo -e "\e[37;1mDEBIAN $version \e[0m\n"

    sudo sed -i 's/$old_and_busted/$new_hotness/g' /etc/apt/sources.list

    sudo apt-get update
    sudo apt-get upgrade -y --force-yes
    sudo apt-get dist-upgrade -y --force-yes


    echo -e "----------------\n :: NOW REBOOT :: \n----------------\n"
