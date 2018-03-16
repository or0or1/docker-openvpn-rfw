# docker-openvpn-rfw初始化步骤：

1,创建数据库并导入数据

  mysql -uroot -p accounts < sql/init.sql 

2,修改配置文件docker-compose.yml

  设置ip和路径(端口保持不变）; 基于安全的原因，7393、8000需要设置为内网ip。
      - "1194:1194/udp"
      - "7393:7393"
      - "8000:8080"


3,执行

  sh ./script/init.sh

  在整个过程，需要输入密码和确认密码。之后输入域名vpn.test.com，并在此输入之前的密码。

4, 执行
  sh ./script/key.sh 

  把test.ovpn里面的key，替换到ovpn/example.ovpn, 修改vpn服务器地址, 产生一个新的ovpn文件，提供给用户使用

注意：
  部署更多vpn节点，请把这里的整个目录复制过去，执行done即可。不能也不用重新初始化，否则用户只能登录众多节点中的一个。





