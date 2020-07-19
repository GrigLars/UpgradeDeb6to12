# How to upgrade a Debian 6 box to Debian 10

I had a bunch of appliances where I had to do this.  Here are my notes.  This is a little hasty, so it may run into random issues.  I really want to automate this with an ansible script at some point, but there are still too many "an update to this conf file has been made, do you wish to keep yours or update the maintainer's version" and the swap from GRUB 1.99 to the new 2.00 which... IMHO... is not an improvment. ***This may hose your system,*** especially if there are pre-compiled binaries or commands that won't work with Linux over 2.4 or 2.6.  This is very risky, *and you better know what you're doing here!*  In my case, it worked great, since I have i386 boxes.  But if you have weird Marvel kernels, old arm kernels, or device drivers that only work for one kernel type, you may have an unbootable system very suddenly with no way to back out.  In my case, these appliances had to be updated, or fail compliance, so if they were hosed, it wouldn't matter.  In the end, they worked really well for i386 "beige box routers."  

### The Debian 6-7 repositories went byebye 

... and in the future, like 8, 9, 10, etc... depending on when you read this. First, I had to replace the debian repos with ftp archive:

Add the following in your /etc/apt/sources.list, and comment everything else out:

    deb http://archive.debian.org/debian squeeze main
    deb http://archive.debian.org/debian squeeze-lts main

The second line will fail with an "expired" type message, so you also need to add the following in /etc/apt/apt.conf (and create it if it doesn't already exist):

    Acquire::Check-Valid-Until false;

You also have to check anything in /etc/apt/sources.list.d/ and /etc/apt/conf.d/

### Make an update script

Here are the names:

    Debian 11 Bullseye - testing as of this document
    Debian 10 Buster - current as of this document
    Debian 9 Stretch - old stable as of this document
    Debian 8 Jessie - "old old stable" about to expire as of this document
    Debian 7 Wheezy
    Debian 6 Squeeze

I then made this script where I changed the build names after each reboot.  It's in this repo as "update.bash"

If you run weird expired repositories, you can always remove them with this:

    sudo aptitude search “~o”

# Recommendations for upgrading from jessie LTS to stretch LTS

That script started to get weird one-off errors between 8 and 9, and that's because the archives don't work for current builds.  Comment out everything again, and then add these two lines:

    deb http://deb.debian.org/debian/ stretch main contrib non-free
    deb-src http://deb.debian.org/debian/ stretch main contrib non-free

    deb http://security.debian.org/ stretch/updates main contrib non-free
    deb-src http://security.debian.org/ stretch/updates main contrib non-free

Then keep going.  
