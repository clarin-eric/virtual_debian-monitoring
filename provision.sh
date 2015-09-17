#!/bin/sh -ex

DEBIAN_FRONTEND='noninteractive' export DEBIAN_FRONTEND
APT_LISTCHANGES_FRONTEND='none' export APT_LISTCHANGES_FRONTEND

apt-get update -qq
apt-get install -y --force-yes 'software-properties-common'
add-apt-repository -y 'ppa:formorer/icinga'
apt-get install -y --force-yes 'icinga-core' 'python' 'python-pip'
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

cd '/srv/monitoring/'
mkdir -p lib/spool lib/rw run/icinga cache/icinga lib/icinga/spool/checkresults lib/icinga/rw log/icinga
sed -i "s/\/var\///g" 'icinga.cfg'
sed -i "s/\/etc\/icinga\/resource.cfg/resource.cfg/g" 'icinga.cfg'
printf '%s\n' '$USER1$=/usr/lib/icinga/plugins\n$USER3$=/etc/icinga/probes' > 'resource.cfg'

# python 'configuration/config_generation/config_generation_centerregistry.py' --nopull --nocleanup