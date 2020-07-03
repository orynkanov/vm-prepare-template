#!/bin/bash

if [[ ! -f /etc/centos-release ]]; then
    echo OS not CentOS. This script only for CentOS!
    exit 1
fi
OSVER=$(grep -o '[0-9]' /etc/centos-release | head -n1)
if [[ $OSVER -eq 7 ]]; then
    yum update -y all && echo 'update all - OK'
    yum install -y epel-release && echo 'install epel - OK'
    yum install -y bash-completion mc htop wget screen qemu-guest-agent tuned && echo 'install pkgs - OK'
elif [[ $OSVER -eq 8 ]]; then
    dnf upgrade -y all && echo 'update all - OK'
    dnf install -y epel-release && echo 'install epel - OK'
    dnf install -y bash-completion mc htop wget screen qemu-guest-agent tuned && echo 'install pkgs - OK'
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
