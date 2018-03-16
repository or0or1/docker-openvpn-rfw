#!/usr/bin/python
# -*- coding:utf-8 -*-

import time,datetime
import requests,simplejson,os

time.sleep(10)

ip="192.168.1.77"
port="9111"
url="http://${ip}:${port}/vpn/query"
data={}
data["key"]="wrxdyuihguomnjpljjjjjjjjxhiop9ikm"
data["method"]="query"
data["dbbase"]="accounts"
#data["sql"]="select a.clientip, b.permitip  from vpn_inf as a, vpn_permit_ips as b where a.uid = b.uid"
data["sql"]="select b.uid,  c.account,  a.clientip, a.serverip,  b.permitip  from vpn_inf as a, vpn_permit_ips as b, accounts as c  where a.uid = b.uid and a.uid = c.id"
headers = {'content-type': 'application/json'}
r = requests.post(url, data=simplejson.dumps(data), headers=headers)
print r.text

bcode=simplejson.loads(r.text)

key="df022737ad732f60df7712c2725bd9e"
for item in bcode["data"]:
  print item["clientip"], item["permitip"]
  tdata={}
  tdata["key"]=key
  tdata["source"]=item["clientip"]
  temp={}
  temp["destination"]=item["permitip"]
  temp["target"]="accept"
  temp["action"]="add"
  tdata["data"]=temp
  url="http://${ip}:${port}/vpn/rfw/add"
  r = requests.post(url, data=simplejson.dumps(tdata), headers=headers)
  print r.text
  print "-------"
  ttdata={}
  ttdata["name"]=item["account"]
  ttdata["uid"]=str(item["uid"])
  ttdata["key"]=key
  ttdata["action"]="add"
  ttdata["ipseg"]="192.167"
  url="http://${ip}:${port}/vpn/account/on"
  print ttdata 
  r = requests.post(url, data=simplejson.dumps(ttdata), headers=headers)
  print r.text

fname="/usr/local/openresty/nginx/html/init"
f=open(fname,'a+')
f.close()

