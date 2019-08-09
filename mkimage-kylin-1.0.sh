#!/bin/bash

set -e

usage() {
	echo usage: $0 REPO TARGET
	echo
	echo EXAMPLES
        echo mkimage-febootstrap Kylin7 kylin-base
        echo mkimage-febootstrap Centos7 /tmp/centos
	exit 1
}

if [ $# -ne 2 ];
then
    usage
fi

febootstrap -i bash -i yum $1 $2 http://download.cs2c.com.cn/neokylin/server/releases/7.0/ls_64
