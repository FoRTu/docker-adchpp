#!/bin/bash

PASS=${ADCHPP_PASS:-$(pwgen -s 12 1)}

if [ ! -d "/data" ]; then
	mkdir -v /data
fi

if [ ! -f "/data/adchpp.xml" ]; then
	cp --verbose /opt/adchpp/etc/adchpp.xml /data
fi

if [ ! -f "/data/Script.xml" ]; then
	cp --verbose /opt/adchpp/etc/Script.xml /data
fi

if [ ! -d "/data/Scripts" ]; then
	cp --verbose -rp /opt/adchpp/Scripts /data/Scripts
fi

if [ ! -f "/data/en_settings.txt" ]; then
        cp --verbose /opt/adchpp/etc/en_settings.txt /data
fi

if [ ! -f "/data/fl_settings.txt" ]; then
        cp --verbose /opt/adchpp/etc/fl_settings.txt /data
fi

if [ ! -f "/data/li_settings.txt" ]; then
        cp --verbose /opt/adchpp/etc/li_settings.txt /data
fi

if [ ! -f "/data/settings.txt" ]; then
        cp --verbose /opt/adchpp/etc/settings.txt /data
fi

if [ ! -f "/data/motd.txt" ]; then
	cp --verbose /opt/adchpp/etc/motd.txt /data
fi

if [ ! -f "/data/users.txt" ]; then
	echo -n "[{\"password\":\"${PASS}\",\"nick\":\"HubAdmin\",\"level\":10}]" > /data/users.txt
	echo "Created admin user with username HubAdmin"
	echo "password: ${PASS}"
	echo "Saved on users.txt"
fi

/opt/adchpp/bin/adchppd -c /data
