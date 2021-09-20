require('tsp')

--读文件
function readFile_(path)
	local path = path or '/var/mobile/Media/TouchSprite/lua/account.txt'
    local file = io.open(path,"r");
    if file then
        local _list = '';
        for l in file:lines() do
            _list = _list..l
        end
        file:close();
        return _list
    end
end
--取帐号token
function llsGameToken()
	local appbid = 'com.lilithgames.rok.ios.offical'
	local AccountInfo = appDataPath(appbid).."/Documents/AccountInfo.json"
	local account = readFile_(AccountInfo)
	if (account) then
	    local allinfo = account
    	local sz = require("sz")
        local json = sz.json
        account = json.decode(account)
        if(account[1]['app_token'])then
            return {account[1]['app_token'],allinfo}
        end
	end
	return account
end

function update_token()
    local RokToken = llsGameToken();
    local info_ ={}
    info_['token']=RokToken[1]
    info_['idfa']=RokToken[2]
    -- info_['city']=__game.city
    info_['fighting']=__game.fighting
    info_['red']=__game.red
    info_['s']='Rok.Token'
    _api_rok(info_)
end

--写入
function writeFile_(info,way,path)
	local path = path or '/var/mobile/Media/TouchSprite/lua/account.txt'
	local way = way or 'a'
	local f = assert(io.open(path, way))
    f:write(info)
	f:write('')
    f:close()
end

--取帐空闲帐号
function AccountInfoBack()

	local sz = require("sz")
	local json = sz.json
	local appbid = 'com.lilithgames.rok.ios.offical'
	local AccountInfo = appDataPath(appbid).."/Documents/AccountInfo.json"

    local url = 'http://ymrok.honghongdesign.cn/';
    local arr = {}
    arr['s']='RokGetToken.Rest'
    arr['imei']= __game.imei
    arr['note']= __game.note
    arr['phone_name']= __game.phone_name

	local account_ = post(url,arr)
	log(account_)
	local token = account_.data.idfa
	__game.qu = account_.data.qu
	__game.wei_ui = json.decode( account_.data.web_ui )
	__game.weizi = account_.data.weizi
	__game.qus = account_.data.qus
	writeFile_( token ,'w',AccountInfo)
	closeApp(appbid,1)
	mSleep(2000)
end


-- __game={}
-- update_token()


