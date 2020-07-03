#!/bin/bash

if [[ ! -f /etc/centos-release ]]; then
    echo OS not CentOS. This script only for CentOS!
    exit 1
fi
OSVER=$(grep -o '[0-9]' /etc/centos-release | head -n1)
if [[ $OSVER -eq 7 ]]; then
    yum update -y all
    yum install -y epel-release
    yum install -y bash-completion mc htop wget screen qemu-guest-agent tuned
elif [[ $OSVER -eq 8 ]]; then
    dnf update -y all
    dnf install -y epel-release
    dnf install -y bash-completion mc htop wget screen qemu-guest-agent tuned
fi

systemctl enable tuned --now
tuned-adm profile virtual-guest

#clear
:> /etc/machine-id
rm -f /etc/ssh/*key*
rm -f /root/.bash_history
unset HISTFILE
sed -i '/^UUID=*/d' /etc/sysconfig/network-scripts/ifcfg-eth0
if [[ $OSVER -eq 7 ]]; then
    history -c
    yum clean all
elif [[ $OSVER -eq 8 ]]; then
    history -c
    dnf clean all
fi
