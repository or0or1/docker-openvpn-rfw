
local resty_md5 = require "resty.md5"
local upload = require "resty.upload"
local str = require "resty.string"
local dst_dir = "/etc/openvpn/ccd"


local cjson = require("cjson")
local method = ngx.var.request_method
ngx.log(ngx.ERR,method)

if method == "POST" then
  ngx.req.read_body()
  local temp = ngx.req.get_body_data()
  local args=cjson.decode(temp)
  
  local name=args["name"]
  local data=args["data"]
  local action=args["action"]
  local fname=dst_dir .. "/" .. name
  
  local cont={}
  file = io.open(fname, "w+")
  if not file then
      cont["status"]="nook"
      cont["err"]="failed to open file ".. fname
  else
    file:write(data)
    file:close()
    file = nil
    if action == "delete" then
      os.remove(fname)
      ngx.log(ngx.ERR, "delete "..name)
    end
    cont["status"]="ok"
    cont["err"]=""
  end

  ngx.say(cjson.encode(cont))


end

