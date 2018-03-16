# fork from: https://github.com/mapero/docker-openvpn
# Original credit: https://github.com/jpetazzo/dockvpn
# and https://github.com/kylemanna/docker-openvpn
# Leaner build then Ubunutu
FROM debian:jessie


MAINTAINER or0or1  <or0or1@yeah.net>

RUN echo "deb http://ftp.debian.org/debian/ jessie main non-free contrib" > /etc/apt/sources.list && \
    apt-get update && \ 
    apt-get install -y openvpn  iptables git-core libmysqlclient18 libmysqlclient-dev build-essential autoconf automake libtool supervisor  python-pip python-dev python-pycparser python-yaml python-jinja2  python-markupsafe python-msgpack python-html5lib  python-lxml wget

RUN apt-get -y install  libpython2.7-minimal:amd64 libpython2.7-stdlib:amd64 libpython-stdlib:amd64 python2.7-minimal python-apt python-apt-common python-colorama python-concurrent.futures python-croniter python-crypto python-cryptography python-dateutil python-hiredis python-html5lib python-jinja2 python-lxml python-markupsafe python-msgpack python-mysqldb python-ndg-httpsclient python-pkg-resources python-pycparser python-pycurl python-redis python-requests python-setuptools  python-tornado python-tz python-yaml python-zmq
     

RUN echo "deb http://openresty.org/package/debian jessie openresty" >> /etc/apt/sources.list && \
    wget -qO - https://openresty.org/package/pubkey.gpg | apt-key add -  && \
    apt-get update && \
    LC_ALL=C DEBIAN_FRONTEND=noninteractive  apt-get -y install openresty && \
    opm get openresty/lua-resty-upload && \
    mkdir /var/log/nginx
RUN cd /tmp && \
    git clone https://github.com/chantra/openvpn-mysql-auth.git && \
    cd openvpn-mysql-auth && \
    ./autogen.sh && \
    ./configure && \
    make && \
    cp -a src/.libs/libopenvpn-mysql-auth.so* /usr/local/lib/ && \
    apt-get -y remove build-essential autoconf automake libtool && \
    apt-get -y  autoremove && \
    apt-get -y clean && \
    rm -rf /tmp/* 

RUN apt-get -y install python-simplejson

# Update checkout to use tags when v3.0 is finally released
RUN cd /tmp/ && \
  git clone https://github.com/OpenVPN/easy-rsa.git /usr/local/share/easy-rsa && \
  cd /usr/local/share/easy-rsa && \
  git checkout -b tested 89f369c5bbd13fbf0da2ea6361632c244e8af532 && \
  ln -s /usr/local/share/easy-rsa/easyrsa3/easyrsa /usr/local/bin
  #COPY lib/libopenvpn-mysql-auth.so /usr/local/lib

RUN pip install rfw

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/local/share/easy-rsa/easyrsa3
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

VOLUME ["/etc/openvpn"]

# Internally uses port 1194, remap using docker
EXPOSE 1194/udp
EXPOSE 7393

ADD scripts/init.py /init.py
ADD scripts/run.sh /run.sh

RUN rm -rf /etc/openvpn/*
COPY conf/openvpn/ovpn_env.sh /etc/openvpn
COPY conf/rfw/ /etc/rfw/
COPY conf/supervisor/all.conf /etc/supervisor/conf.d/all.conf
COPY conf/resty/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY conf/resty/resty /usr/local/openresty/nginx/conf/resty 
#WORKDIR /etc/openvpn
#CMD ["ovpn_run"]


ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*
RUN chown nobody:root /usr/local/openresty/nginx/html

CMD [ "/usr/bin/supervisord", "-n",  "-c", "/etc/supervisor/supervisord.conf" ]
