
docker-compose  up -d
docker-compose  exec openvpn-mysql  ovpn_genconfig -u udp://vpn.test.com:1194
docker-compose  exec openvpn-mysql  ovpn_initpki

cp conf/openvpn/mysql-auth.conf data/openvpn/
cp conf/openvpn/openvpn.conf data/openvpn/

sh ./done

docker-compose  exec openvpn-mysql easyrsa build-client-full  testasdfghjkl 

