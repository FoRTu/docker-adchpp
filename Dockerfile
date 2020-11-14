FROM python:2.7.18-slim

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

LABEL maintainer="FoRTu" maintainer.website="https://github.com/FoRTu"

# Update > Instal dependencies >Build > clean unnecessary packages
RUN apt-get update && \
apt-get install curl swig ruby scons git build-essential libreadline-dev libssl-dev lua5.1 liblua5.1-0 pwgen -yq && \
mkdir -p /opt/source/adchpp && \
cd /opt/source/adchpp && \
git clone --branch master https://github.com/adricu/adchpp.git . && \
scons mode=release arch=x64 && \
cd build && \
cp -rp release-default-x64 /opt/adchpp && \
cp -rp /opt/source/adchpp/plugins/Script/examples /opt/adchpp/Scripts && \
cp -rp /opt/source/adchpp/etc /opt/adchpp/ &&\
mkdir -p /usr/local/lib/lua/5.1 && \
ln -s /opt/adchpp/bin/luadchpp.so /usr/local/lib/lua/5.1/luadchpp.so && \
rm -rf /opt/source && \
apt purge -y git curl scons build-essential && \
apt-get -y autoclean && \
apt-get -y autoremove && \
rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/* \
        /var/cache/debconf/*-old \
        /var/lib/apt/lists/* \
        /usr/share/doc/*

ADD start.sh /opt/adchpp/start.sh
ADD config /opt/adchpp/etc/
RUN chmod +x /opt/adchpp/start.sh

WORKDIR /opt/adchpp

EXPOSE 2780

CMD ["./start.sh"]
