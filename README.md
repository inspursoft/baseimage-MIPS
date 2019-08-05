# Create Base Docker Images by Using Febootstrap.
## 1. Introduction of Febootstrap
  `Febootstrap` is a tool that allows us to make native OS base images, such as Centos, Ubuntu and other operating systems. It can also specify the installation of specific software into the image, which makes it easier for us to understand and control the composition of the base image. Finally, the base image is expanded into an application image to finally deploy the service.

## 2. Installation of Febootstrap
  Since the `Febootstrap` does not exist in the default source on the Kylin7 system, it cannot be installed directly with yum. But you can download the rpm package on Kylin6.<br>
  Here is the link: http://download.cs2c.com.cn/neokylin/server/releases/6.0/ls_64/Packages/<br>
  Here is the Febootstrap and its dependent rpm package. Download to the local, and install directly.(`rpm -ivh *.rpm`)<br>
```
fakechroot-2.9-24.5.ns6.0.01.mips64el.rpm
fakeroot-libs-1.12.2-22.2.ns6.0.1.mips64el.rpm
fakechroot-libs-2.9-24.5.ns6.0.01.mips64el.rpm
febootstrap-2.7-1.2.ns6.0.1.mips64el.rpm
fakeroot-1.12.2-22.2.ns6.0.1.mips64el.rpm
```
## 3. Operations of Febootstrap
```
febootstrap -i bash -i wget neokylin7 neokylin-base-1.0 http://download.cs2c.com.cn/neokylin/server/releases/7.0/ls_64
```
parameter description:
* -i `Package that needs to be installed, for example, install bash, wget here`
* neokylin7      `Operating system version`
* neokylin-base-1.0  `Image directory, for example, generate neokylin-base-1.0 directory in the current directory here`
* http://download.cs2c.com.cn/neokylin/server/releases/7.0/ls_64    `Mirror OS source address`

Download the directory after installation (equivalent to a complete local system directory of Kylin7)
```
[root@10 neokylin-base-1.0]# ll
总用量 60
lrwxrwxrwx  1 root root    7 7月  30 17:05 bin -> usr/bin
dr-xr-xr-x  2 root root 4096 4月  16 2018 boot
drwxr-xr-x  5 root root 4096 4月  16 2018 dev
drwxr-xr-x 50 root root 4096 7月  30 17:06 etc
drwxr-xr-x  2 root root 4096 4月  16 2018 home
lrwxrwxrwx  1 root root    7 7月  30 17:05 lib -> usr/lib
lrwxrwxrwx  1 root root    9 7月  30 17:05 lib32 -> usr/lib32
lrwxrwxrwx  1 root root    9 7月  30 17:05 lib64 -> usr/lib64
drwxr-xr-x  2 root root 4096 4月  16 2018 media
drwxr-xr-x  2 root root 4096 4月  16 2018 mnt
drwxr-xr-x  2 root root 4096 4月  16 2018 opt
dr-xr-xr-x  2 root root 4096 4月  16 2018 proc
dr-xr-x---  2 root root 4096 4月  16 2018 root
drwxr-xr-x 11 root root 4096 7月  30 17:06 run
lrwxrwxrwx  1 root root    8 7月  30 17:05 sbin -> usr/sbin
drwxr-xr-x  2 root root 4096 4月  16 2018 srv
dr-xr-xr-x  2 root root 4096 4月  16 2018 sys
drwxrwxrwt  7 root root 4096 7月  30 17:06 tmp
drwxr-xr-x 13 root root 4096 7月  30 17:05 usr
drwxr-xr-x 18 root root 4096 7月  30 17:06 var
```
Package and import the current directory into the image
```
tar -c .|docker import - fanzhihai/neokylin-base:1.0

[root@10 neokylin-base-1.0]# docker images | grep neokylin-base
fanzhihai/neokylin-base                                1.0                  a07b57ac80ea        3 days ago          525 MB
```

At this point, we use Febootstrap to create and extend the image of the specified software based on the Kylin7 OS system. We can run the image and go to the container to view the system version and whether the specified software is installed.
```
[root@10 neokylin-base-1.0]# docker run -it fanzhihai/neokylin-base:1.0 bash

bash-4.2# uname -a
Linux f750f537df59 3.10.0-693.21.1.ns7.007.mips64el #1 SMP PREEMPT Wed May 23 19:09:06 CST 2018 mips64el mips64el mips64el GNU/Linux

bash-4.2# cat /etc/issue          
NeoKylin Linux Server release 7.0 (loongson)
Kernel \r on an \m

bash-4.2# cat /etc/yum.repos.d/ns7-mips.repo 
[ns7-mips64el-os]
name=NeoKylin Linux Advanced Server 7 - Os
baseurl=http://download.cs2c.com.cn/neokylin/server/releases/7.0/ls_64/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-neokylin-release
enabled=1

[ns7-mips64el-extras]
name=NeoKylin Linux Advanced Server 7 - Addons
baseurl=http://download.cs2c.com.cn/neokylin/server/everything/7.0/ls_64/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-neokylin-release
enabled=0

[ns7-mips64el-updates]
name=NeoKylin Linux Advanced Server 7 - Updates
baseurl=http://download.cs2c.com.cn/neokylin/server/updates/7.0/ls_64/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-neokylin-release
enabled=0

bash-4.2# wget --version
GNU Wget 1.14 built on linux-gnu.

+digest +https +ipv6 +iri +large-file +nls +ntlm +opie +ssl/openssl 

Wgetrc: 
    /etc/wgetrc (system)
......

bash-4.2# bash --version
GNU bash, version 4.2.46(2)-release (mips64el-koji-linux-gnu)
Copyright (C) 2011 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
......
```
