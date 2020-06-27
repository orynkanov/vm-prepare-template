#!/bin/bash

:> /etc/machine-id
rm -f /etc/ssh/*key*

sed -i '/^UUID=*/d' /etc/sysconfig/network-scripts/ifcfg-e*
yum clean all

sys-unconfig
