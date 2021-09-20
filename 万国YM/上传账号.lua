require("tsp")
require('api')
require('token')
require("AWZ")
require ("TSLib")




init(1)
info = {}
info.api = 'http://sms.wenfree.cn/public/'
_app = {}
_app.bid = 'com.lilithgames.rok.ios.offical'
__reg = true

function getphone2()
    local url = 'http://103.91.211.167/api/specified?sid=274&phone='..info.phone..'&token=75044e220f7e11eb81a2008cfa0433f8'
    local res = get_(url)
    log(res)
    if res then
        local ress = split(res,'|')
        if ress[1] == 0 or ress[1] == '0' then
            return true
        end
    end
end

	
function read_File(file)
     assert (file, "file open failed" )
     local fileTab = {}
     local line = file:read()
     while  line  do
         print( "get line" ,line)
         table.insert(fileTab,line)
         line = file:read()
     end
     return  fileTab
end
 
function write_File(file,fileTab)
     assert (file, "file open failed" )
     for  i,line in ipairs(fileTab)  do
         print( "write " ,line)
         file:write(line)
         file:write( "\n" )
     end
end
 
function delete_File(filePath)
     print( "start" )
	local filePath =  '/var/mobile/getqqdate.txt' 
     local fileRead = io.open(filePath)
     if  fileRead then
         local tab = read_File(fileRead)
         fileRead:close()
         table. remove (tab,1)
         local fileWrite = io.open(filePath, "w" )
         if  fileWrite then
             write_File(fileWrite,tab)
             fileWrite:close()
         end
     end
end
 



function upall()
    if 是否注册过 then
        update_token_already()
    else
        update_token()
    end
end



--本地储存token
function qqdate_token()
    local RokToken = llsGameToken();
    local qqdate_path = '/var/mobile/qqdatelocal.txt'
    writeFileString(qqdate_path,RokToken[2],'a',1)
end

--本地取QQ号
function qqdate_get()
	local qqdate_path = '/var/mobile/getqqdate.txt'
	qq_date = readFile(qqdate_path)
	if qq_date then
		qq_date = split(qq_date[1],'----')
		return qq_date
	end	
end



function update_token()
    local RokToken = llsGameToken();
    local info ={}
    info['cradid']=info.cradid
    info['phone']=info.phone
    info['token']=RokToken[1]
    info['idfa']=RokToken[2]
--    info['qq']=qq[1]..'-'..qq[2]
    info['s']='Rok.Token'
    _api_rok(info)
end

function update_token_already()
    local RokToken = llsGameToken();
    local info ={}
    info['cradid']=info.cradid
    info['phone']=info.phone
    info['token']=RokToken[1]
    info['idfa']=RokToken[2]
    info['note']='别人注册'
    info['s']='Rok.Token'
    _api_rok(info)
end

function phone_already()
    local posta ={}
    posta['arr']= '{"phone":'..info.phone..'}'
    posta['table']='rok_already'
    posta['id']=''
    posta['s']='Index.update'
    log(posta)
    _api_rok(posta)
end

function _api_rok(info)
    local url = 'http://ymrok.honghongdesign.cn/';
    log(post(url,info));
end

update_token()