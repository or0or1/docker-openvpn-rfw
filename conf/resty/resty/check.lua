
local dst_dir = "/etc/openvpn/ccd"


local cjson = require("cjson")
local method = ngx.var.request_method
ngx.log(ngx.ERR,method)

if method == "POST" then
  ngx.req.read_body()
  local temp = ngx.req.get_body_data()
  local args=cjson.decode(temp)
  ngx.log(ngx.ERR,cjson.encode(args)) 
  local name=args["name"]
  local fname=dst_dir .. "/" .. name
  
  local bcode={}
  bcode["status"]="ok"
  file = io.open(fname, "ro")
  if not file then
      bcode["exist"]=0
  else
      bcode["exist"]=1
  end

  ngx.say(cjson.encode(bcode))


end

