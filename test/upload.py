
import os
import requests,json

url="http://192.168.1.77:9111/vpn/upload"
#url="http://192.168.1.219:8000/upload"

name="test"
path="./"+name
f=open(path, 'rb')
data={}
data["name"]=name
data["data"]=f.read()
r = requests.post(url, data=json.dumps(data))
print r.url,r.text

