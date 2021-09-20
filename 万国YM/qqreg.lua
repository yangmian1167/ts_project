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

--jieguo  = llsGameToken()
--nLog(jieguo)

--update_token()

log(frontAppBid())


if t==nil then
    t ={}
end
t['隐私保护-同意并继续']={0x0ea8fc, "0|0|0x0ea8fc,-136|-8|0xf7e1c6,-362|-406|0xd30000,-378|-402|0xf7e1c6",90,176,88,1130,662}
--t['绑定手机-绑定']={0x09bf06, "0|0|0x09bf06,-228|-4|0x0ac007,-219|-133|0x65615c,-223|-231|0x65615c,-20|-452|0x33312e",90,375,104,712,702}
t['绑定手机-绑定']={ 0xfabf50, "0|10|0xd81201,-36|-10|0xffe180,11|-33|0xe687d9,29|-24|0xfeac40", 90, 411, 186, 512, 275 } --多点找色7
    t['绑定手机-绑定按钮']={0xffffff, "0|0|0xffffff,-8|-29|0x09c306,14|22|0x09bd07",90,760,526,896,631}
t['绑定手机-获取验证码']={0xfdf1e3, "0|0|0xfdf1e3,-70|-9|0x33312e,61|1|0x33302e,-21|-2|0xfef3e6",90,1002,149,1263,546}
t['实名制-提交']={0xffffff, "0|0|0xffffff,-348|21|0x09bd07,391|-20|0x09c307",90,380,504,1269,708}
t['更新-确定']={0x00c2ff, "0|0|0x00c2ff,-340|0|0xdd3c33,-194|-109|0x0079ac,-245|-290|0xc7c4b7",90,331,168,977,594}
t['万国觉醒-注册成功']={0xffad00, "0|0|0xffad00,23|-164|0x022f43,-37|-582|0xdf9432,-262|-590|0xefa542",90,0,0,1440,980}

t['弹窗-提示确认']={0x007aff, "0|0|0x007aff,46|-8|0x007aff,41|-152|0x000000,43|-162|0x000000",90,427,285,896,486}
t['弹窗-提示确认2']={0x007aff, "0|0|0x007aff,39|-163|0x000000",90,543,278,801,487}
t['弹窗-提示取消']={0x007aff, "0|0|0x007aff,273|1|0x007aff,171|-188|0x000000",90,412,265,868,503}
t['弹窗-游戏提示']={0x1274ba, "0|0|0x1274ba,2|-22|0x00d4ff,-38|65|0x00648e,-70|74|0xc5c2b6,-58|-282|0xc7c4b7",90,397,149,811,634}
t['弹窗-网络错误']={0x1176bc, "0|0|0x1176bc,54|0|0x00c2fe,-16|-290|0x858278,-18|-300|0x858278",90,343,161,989,582}

t['QQ下->登录']={0x007aff, "0|0|0x007aff,-142|-274|0x0abe06,21|-313|0x09c308",90,392,102,664,594}
-- t['QQ下->登录']={0x007aff, "0|0|0x007aff,-28|-88|0xffffff,-33|-98|0xeb1c26",90,375,176,875,624}
t['登录游戏成功']={0xa4fcff, "0|0|0xa4fcff,45|8|0xd9a148,87|32|0xfcfcfc",90,28,624,191,748}
t['rok-封号']={0x1176bc, "0|0|0x1176bc,168|2|0x00bffb,214|-1|0x1176bc,86|-288|0x858278",90,310,109,999,616}
t['弹窗-已经注册']={0x007aff, "0|0|0x007aff,110|-127|0x000000,112|-130|0xf9f9f9,112|-132|0x000000,-84|-177|0x000000,-273|-1|0x007aff",90,425,247,919,505}
t['切换帐号界面']={0x33312e, "0|0|0x33312e,-3|3|0xfef3e7,-112|337|0x09c507,505|416|0x09bb07,-144|-1|0x33312e",90,385,118,1252,674}
t['未注册']={0x007aff, "0|0|0x007aff,25|-180|0x000000,122|-142|0xf9f9f9,124|-143|0x000000,38|-5|0x007aff",90,406,244,927,507}



t['QQ登录']={ 0xeb1c26, "-30|-11|0xffffff,15|-11|0xffffff,-3|-8|0xfaad08,-3|-30|0xffffff,37|-25|0xfef3e7", 90, 424, 274, 737, 591 } --多点找色
t['QQ登录界面']={ 0xffffff, "-6|12|0x12b7f5,-6|14|0xffffff,-563|-27|0x12b7f5,560|20|0x12b7f5", 90, 36, 180, 1314, 716 } --多点找色
--t['QQ登录完成界面']={ 0x007aff, "-8|6|0x007aff,-27|3|0x027bff,-1141|4|0x007aff,-1142|2|0x55a4fa", 90, 99, 297, 1312, 335 } --多点找色
t['QQ登录完成界面7']={ 0x007aff, "-38|-3|0x027bff,-45|-5|0x0b7ffe", 90, 1206, 345, 1321, 420 } --多点找色
t['QQ登录完成界面']={ 0x007aff, "-9|0|0x007aff,-49|-13|0x097efe,-49|8|0x047cff", 90, 1226, 283, 1296, 329 } --多点找色7
t['QQ登录完成界面1']={ 0x007aff, "-22|-5|0x027bff", 90, 1221, 365, 1298, 403 } --多点找色
t['QQ账户已绑定提示']={ 0xf9f9f9, "-9|0|0x007aff,-238|0|0x007aff,-247|3|0xf7f6f6,-277|3|0x007aff,-161|-172|0x000000,-115|-175|0x000000", 90, 424, 262, 924, 507 } --多点找色
t['正在登录ing']={ 0x0089df, "126|-435|0xfac02f,351|-433|0xfdd12e,478|-317|0xfb786c,389|-252|0x69323a", 90, 230, 188, 1179, 687 } --多点找色
t['正在登录ing2']={ 0x07b0ff, "1|18|0x0060a8", 90, 346, 652, 371, 689 } --多点找色

t['滑动拼图界面']={ 0xf0f6fd, "-33|-12|0x007aff,31|11|0x007aff,36|-9|0x007aff", 90, 398, 532, 935, 605 } --多点找色
--t['滑动拼图界面']={ 0x8da869, "", 90, 393, 134, 934, 662 } --多点找色



t['tips账号密码不正确']={ 0x12b7f5, "0|-1|0x6fd3f9,-455|-115|0xe6e6e6,-448|46|0x12b7f5,-183|166|0x999999,3|118|0xe1e2e6", 90, 378, 208, 960, 590 } --多点找色
t['QQ登录_tips账号登录异常']={ 0x808080, "-100|-23|0x808080,-830|20|0x808080,-827|-22|0x808080,-491|0|0xffffff,-492|-1|0xc3c3c3", 90, 67, 95, 1245, 180 } --多点找色

function qqreg_game()
	登录key = true
	提交key = false
	qq = qqdate_get()
	local timeline = os.time()
	while os.time()-timeline < 60 * 3 do
		if active(_app.bid,8)then
			if  d('QQ登录_tips账号登录异常') then
				delete_File(filePath)
				return true
			end	
			if d('隐私保护-同意并继续',true)then
			elseif d( '未注册',true,1,3 ) then
			    return false
			elseif d('绑定手机-绑定')  then
			    delay(2)
			    moveTo(600,500,600,200,10)
			    delay(2)
			elseif d('QQ登录',true)  then
			elseif d('QQ登录界面') or d('QQ登录完成界面') then
				if 登录key then
					click(121,284)
					info.phone = qq[1]
					input(info.phone)
					d('QQ登录完成界面',true)
					d('QQ登录完成界面1',true)
					delay(2)
					click(99,404)
					input(qq[2])
					d('QQ登录完成界面',true)
					d('QQ登录完成界面1',true)
					登录key = false
--				else
--					click(68,29)
				end	
				if d('QQ登录完成界面',true) then
				elseif d('QQ登录界面',true) then
					if  d('QQ登录_tips账号登录异常') then
						delete_File(filePath)
						return true
					end	
					delay(3)
				end
				
		    elseif d('实名制-提交') then
                getCrad();
                log(info)
                click(639, 336)
                keyDown("Clear")
                keyUp("Clear")
                delay(1)
                inputStr(info.cardname)
                delay(1)
                click(74, 152)
                click(622, 443)
                keyDown("Clear")
                keyUp("Clear")
                delay(1)
                inputStr(info.cardnumber)
                delay(1)
                click(74, 152)
                d('实名制-提交',true)
				提交key = true
			elseif d('更新-确定') or d('万国觉醒-注册成功') or d('登录游戏成功')or d('rok-封号') then
                qqdate_token()
				update_token()
				delete_File(filePath)
			    return true
			elseif 提交key and d('正在登录ing') then
					delay(10)
					qqdate_token()
					update_token()
					delete_File(filePath)
					return true			
			elseif d('QQ账户已绑定提示',true) then
--					delay(10)
--					qqdate_token()
--					update_token()
--					delete_File(filePath)
--					return true
					提交key = true
			else
				if d('弹窗-提示确认',true)then
			    elseif d('弹窗-提示确认2',true)then
--			    elseif d('弹窗-提示取消',true)then
			    elseif d('弹窗-游戏提示',true)then
			    elseif d('弹窗-网络错误',true,1)then
				elseif d('tips账号密码不正确') then
					delete_File(filePath)
					return true
				elseif d('滑动拼图界面')then
					click(840,634)
					delay(3)
					moveTo_(492,573,800,576,5,30)
					delay(3)
					if  d('QQ登录_tips账号登录异常')  then
						delete_File(filePath)
						return true
					end	
					moveTo_(492,573,839,576,5,30)
					delay(1)
					if  d('QQ登录_tips账号登录异常')then
						delete_File(filePath)
						return true
					end	
			    else
--			        click(74, 152)
			    end
		    end
		end
		delay(1)
	end
end
t['正在登录ing1']={ 0x0065b0, "-27|-16|0x0cb2fe,-25|-2|0x006bba,148|-504|0x8d8780,156|-336|0x4da9e8", 90, 349, 654, 398, 681 } --多点找色
function qqreg_game2()
	登录key = true
	提交key = false
	qq = qqdate_get()
	local timeline = os.time()
	while os.time()-timeline < 60 * 3 do
		if active(_app.bid,8)then
			if  d('QQ登录_tips账号登录异常') then
				delete_File(filePath)
				return true
			end	
			if d('隐私保护-同意并继续',true)then
			elseif d( '未注册',true,1,3 ) then
			    return false
			elseif d('绑定手机-绑定')  then
			    delay(2)
			    moveTo(600,500,600,200,10)
			    delay(2)
			elseif d('QQ登录',true)  then
			elseif d('QQ登录界面') or d('QQ登录完成界面') then
				if 登录key then
					click(121,284)
					info.phone = qq[1]
					input(info.phone)
					d('QQ登录完成界面',true)
					delay(2)
					click(99,404)
					input(qq[2])
					click(1265,386)
					d('QQ登录完成界面',true)
					登录key = false
--				else
--					click(68,29)
				end	
				if d('QQ登录完成界面',true) then
				elseif d('QQ登录界面',true) then
					if  d('QQ登录_tips账号登录异常') then
						delete_File(filePath)
						return true
					end	
					delay(3)
				end
				
		    elseif d('实名制-提交') then
                getCrad();
                log(info)
                click(516,410)
                keyDown("Clear")
                keyUp("Clear")
                delay(1)
                inputStr(info.cardname)
                delay(1)
                click(74, 152)
                click(521,514)
                keyDown("Clear")
                keyUp("Clear")
                delay(1)
                inputStr(info.cardnumber)
                delay(1)
                click(74, 152)
                d('实名制-提交',true)
				提交key = true
			elseif d('更新-确定') or d('万国觉醒-注册成功') or d('登录游戏成功')or d('rok-封号') then
                qqdate_token()
				update_token()
				delete_File(filePath)
			    return true
			elseif 提交key and d('正在登录ing2') then
					delay(10)
					qqdate_token()
					update_token()
					delete_File(filePath)
					return true			
			elseif d('QQ账户已绑定提示',true) then
--					delay(10)
--					qqdate_token()
--					update_token()
--					delete_File(filePath)
--					return true
					提交key = true
			else
				if d('弹窗-提示确认',true)then
			    elseif d('弹窗-提示确认2',true)then
--			    elseif d('弹窗-提示取消',true)then
			    elseif d('弹窗-游戏提示',true)then
			    elseif d('弹窗-网络错误',true,1)then
				elseif d('tips账号密码不正确') then
					delete_File(filePath)
					return true
				elseif d('滑动拼图界面')then
					click(840,634)
					delay(3)
					moveTo_(492,573,800,576,5,30)
					delay(3)
					if  d('QQ登录_tips账号登录异常')  then
						delete_File(filePath)
						return true
					end	
					moveTo_(492,573,839,576,5,30)
					delay(1)
					if  d('QQ登录_tips账号登录异常')then
						delete_File(filePath)
						return true
					end	
			    else
--			        click(74, 152)
			    end
		    end
		end
		delay(1)
	end
end
sys = {
	clear_bid = (function(bid)
		closeApp(bid)
		delay(1)
		os.execute("rm -rf "..(appDataPath(bid)).."/Documents/*") --Documents
		os.execute("rm -rf "..(appDataPath(bid)).."/Library/*") --Library
		os.execute("rm -rf "..(appDataPath(bid)).."/tmp/*") --tmp
		clearPasteboard()
		--[[
		local path = _G.const.cur_resDir
		os.execute(
			table.concat(
				{
					string.format("mkdir -p %s/keychain", path),
					'killall -SIGSTOP SpringBoard',
					"cp -f -r /private/var/Keychains/keychain-2.db " .. path .. "/keychain/keychain-2.db",
					"cp -f -r /private/var/Keychains/keychain-2.db-shm " .. path .. "/keychain/keychain-2.db-shm",
					"cp -f -r /private/var/Keychains/keychain-2.db-wal " .. path .. "/keychain/keychain-2.db-wal",
					'killall -SIGCONT SpringBoard',
				},
				'\n'
			)
		)
		
		]]
		clearAllKeyChains()
		clearIDFAV() 
		--clearCookies()
		delay(2)
		return true
	end)
}
--简单清理
function clearOneAccount()
	log('简单清理')
	local sonlist={
		'/tmp/',
		'/Library/',
	}
	for k,v in ipairs(sonlist)do
		local dataPath = appDataPath(_app.bid)
		local AllPath = dataPath..v
		log(AllPath)
		delFile(AllPath)
	end
end
--[[]]
function all()
	vpnx()
    delay(2)
	if vpn() then
		if clickNew() then
--		clearOneAccount();
--		sys.clear_bid(_app.bid)
		qqreg_game2()
		end
	end
end

while (true) do
	local ret,errMessage = pcall(all)
	if ret then
	else
	    vpnx();
		log(errMessage)
		dialog(errMessage, 10)
		mSleep(2000)
	end
end
--]]











