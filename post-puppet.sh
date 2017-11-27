#!/bin/bash
#https://github.com/ffnord/ffnord-puppet-gateway

VPN_NUMBER=0
DOMAIN="kiel.freifunk.net"
TLD=ffki
IP6PREFIX=fda1:384a:74de:4242

sed -i 's/( //;s/ )//g' /etc/ffnord

# firewall config
build-firewall

#fastd ovh config
cd /etc/fastd/ffki-mvpn/
git clone https://github.com/Tarnatos/kiel-gw-peers backbone
touch /usr/local/bin/update-fastd-gw
cat <<-EOF>> /usr/local/bin/update-fastd-gw
#!/bin/bash

cd /etc/fastd/ffki-mvpn/backbone
git pull -q
EOF
chmod +x /usr/local/bin/update-fastd-gw

# check if everything is running:
check-services
echo 'maintenance off if needed !'
echo 'adapt hostname in the OVH-template /etc/cloud/templates/hosts.debian.tmpl and reboot'
echo 'add "include peers from "nord-gw-peers-ovh";" to fastd.conf'
