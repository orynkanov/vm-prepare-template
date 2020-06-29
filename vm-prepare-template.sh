#!/bin/bash

if [[ ! -f /etc/centos-release ]]; then
    echo OS not CentOS. This script only for CentOS!
    exit 1
fi

:> /etc/machine-id
rm -f /etc/ssh/*key*

rm -f ~root/.bash_history
unset HISTFILE

sed -i '/^UUID=*/d' /etc/sysconfig/network-scripts/ifcfg-eth0

OSVER=$(grep -o '[0-9]' /etc/centos-release | head -n1)

if [[ $OSVER -eq 7 ]]; then
    history -c
    yum clean all
    sys-unconfig
elif [[ $OSVER -eq 8 ]]; then
    history -c
    dnf clean all
    poweroff
fi
