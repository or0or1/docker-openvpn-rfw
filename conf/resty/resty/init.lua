
local resty_md5 = require "resty.md5"
local upload = require "resty.upload"
local str = require "resty.string"
local fname = "/usr/local/openresty/nginx/html/init"


local cjson = require("cjson")
local method = ngx.var.request_method
ngx.log(ngx.ERR,method)

if method == "POST" then
  ngx.req.read_body()
  local temp = ngx.req.get_body_data()
  local args=cjson.decode(temp)
  
  local key=args["key"]
 
  local mykey="df022737ad732f60df7712c2725bd9e"
  if key ~= mykey then
    ngx.say(cjson.encode({status="nook",err="unvalid request"}))
    return
  end
  local cont={}
  file = io.open(fname, "w+")
  if not file then
      cont["status"]="nook"
      cont["err"]="failed to open file ".. fname
  else
    file:write("")
    file:close()
    file = nil
    cont["status"]="ok"
    cont["err"]=""
  end
  os.execute("python /init.py")
  ngx.say(cjson.encode(cont))


end

