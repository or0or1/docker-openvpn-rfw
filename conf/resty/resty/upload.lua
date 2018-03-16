local resty_md5 = require "resty.md5"
local upload = require "resty.upload"
local str = require "resty.string"
local dst_dir = "/etc/openvpn/ccd"

function get_filename(res)  
    local filename = ngx.re.match(res,'(.+)filename="(.+)"(.*)')  
    if filename then   
        return filename[2]  
    end  
end  

function handle_uploading()
    local chunk_size = 500*1024 
    local form, err = upload:new(chunk_size)
    if not form then
        ngx.log(ngx.ERR, "failed to new upload: ", err)
        ngx.exit(500)
    end
    local md5 = resty_md5:new()
    file_name = ""
    file = nil
    while true do
        local typ, res, err = form:read()

        if not typ then
             ngx.say("failed to read: ", err)
             return
        end

        if typ == "header" then
            file_name = get_filename(res[2])
            if file_name then
                file = io.open(dst_dir .. "/" .. file_name, "w+")
                if not file then
                    ngx.say("failed to open file ", file_name)
                    return
                end
            end

         elseif typ == "body" then
            if file then
                file:write(res)
                md5:update(res)
            end

        elseif typ == "part_end" then
            if file then
                file:close()
                file = nil
            end
            local md5_sum = md5:final()
            md5:reset()
            ngx.log(ngx.ERR, "md5:", str.to_hex(md5_sum))
            ngx.say("md5:",  str.to_hex(md5_sum))

        elseif typ == "eof" then
            break

        else
            -- do nothing
        end
    end
    if file_name then
       return dst_dir .. "/" .. file_name
    else 
       return  "filename not get"
    end
end

handle_uploading()


