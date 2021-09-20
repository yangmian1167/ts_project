
require("tsp")
require("api")
require("AWZ")

t = {}
t['i']={ 0x1886ff, "-1|-9|0x007aff", 90, 668, 403, 723, 603 } --多点找色
t['删除VPN']={ 0xff3b30, "-63|1|0xff3b30", 90, 299, 550, 453, 606 } --多点找色
t['删除VPN_删除']={ 0x7eb8f7, "-266|2|0x007aff", 90, 198, 721, 553, 769 } --多点找色
t['添加VPN配置']={ 0x007aff, "-58|3|0x007aff,129|13|0x3093ff", 90, 25, 197, 278, 285 } --多点找色
function ios13配置VPN()
	
	vpnname = "hbvpn1"
	server = "yhtip"
	password  = "Aa112211"
	miyao = "1"

	openURL("prefs:root=General&path=VPN")
	delay(3)
	while true do
		if d("i",true) then
		elseif d("删除VPN",true) then
		elseif d("删除VPN_删除",true) then
		elseif d("添加VPN配置",true) then
			delay(2)
			click(632,315)
			click(330,493)
			click(83,139)
			delay(2)
			click(248,469)
			inputword(vpnname)
			click(252,564)
			inputword(server)
			click(490,1289)
			click(253,657)
			inputword(vpnname)
			click(244,809)
			input(password)
			click(256,632)
			input(miyao)
			click(682,138)
			return true
		end
		delay(1)
	end
end

--服务器对接取号
function get_lx(url)
	local sz = require("sz")	
	local res = httpGet(url);
--	log(res)
	if res~= nil or res~= '' then
		return res
	end
end
function _Server_get()
	phone_name = getDeviceName()
	phone_imei = getDeviceID()
	log(phone_name)
	log(phone_imei)
	return{
		login=(function()
			return	
		end),
		getPhone = (function()
				RetStr = get_lx('http://sms.wenfree.cn/public/?service=App.Sms.GetPhone'.."&imei="..phone_imei.."&phonename="..phone_name)
				log(RetStr)
				local sz = require('sz')
				local cjson = sz.json
				RetStr = cjson.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						number = RetStr.data.phone
						log(number)
						local phone_title = (string.sub(number,1,3))
--						local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--						local blackPhone = {'144','141','142','143','144','145','146','147'}
--						local blackPhone = {}
--						for k,v in ipairs(blackPhone) do
--							if phone_title == v then
--								local lx_url =	'http://api.cafebay.cn/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
--								get_lx(lx_url);
--								log("拉黑->"..number)
--								return false
--							end
--						end
					end
				else
					log(RetStr)
				end
				mSleep(3000)
				return number
		end),
		 getMessage=(function()
			local Msg
            for i=1,25,1 do
				mSleep(3000)
				RetStr = get_lx("http://sms.wenfree.cn/public/?service=App.Sms.GetMessage".."&imei="..phone_imei.."&phonename="..phone_name)
				local sz = require('sz')
				local cjson = sz.json
				RetStr = cjson.decode(RetStr)
				log(RetStr);
				if RetStr then
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						Msg = RetStr.data.sms
						if type(tonumber(Msg))== "number" then log(Msg); return Msg 
						else
							Msg = RetStr.data.sms
							log(Msg)
							local i,j = string.find(Msg,"%d+")
							Msg = string.sub(Msg,i,j)
							if type(tonumber(Msg))== "number" then log(Msg); return Msg end
						end
					end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
				mSleep(3000)
            end
            return false
        end),
	
	
	}
	
end
dxcode = _Server_get()


-- openURL("http://m.baihe.com/regChat?channel=hscm&code=11")



t['佳缘_男女']={ 0x7e9ffe, "667|30|0xff665e", 90, 3, 1138, 742, 1237 } --多点找色
    t['佳缘_输入_完成']={0x007aff, "0|0|0x007aff,1|-6|0x007aff",90,644,541,733,1034}

t['佳缘_弹窗_确定']={ 0xffa875, "", 90, 660, 740, 719, 804 } --多点找色
t['佳缘_弹窗_学历界面']={ 0x8f8f8f, "50|28|0x4e4e4e,56|1|0xb1b1b1", 90, 338, 736, 408, 782 } --多点找色
t['佳缘_弹窗_居住地']={ 0xe6e6e6, "89|28|0x959595,90|5|0xcacaca,5|29|0xbebebe", 90, 315, 740, 429, 779 } --多点找色
t['佳缘_弹窗_婚姻']={ 0xd9d9d9, "-3|5|0xc5c5c5,58|28|0xc5c5c5,58|1|0xc5c5c5", 90, 334, 745, 415, 780 } --多点找色
t['佳缘_弹窗_月收入']={ 0xebebeb, "-2|28|0x7c7c7c,86|28|0x656565,69|-1|0xebebeb", 90, 321, 741, 427, 781 } --多点找色
t['佳缘_输入手机号界面']={ 0xffc09b, "-44|-14|0xffae7f,58|23|0xffab7a,-16|14|0xffffff,45|-11|0xffffff", 90, 585, 1162, 728, 1227 } --多点找色
t['佳缘_验证码界面']={ 0xffffff, "-272|-40|0xad91ff,228|20|0x4775fb,240|-21|0x4474fb", 90, 63, 436, 690, 743 } --多点找色
t['佳缘_验证码界面_发送验证码']={ 0xffc4a2, "-113|-1|0xffd4bc,-114|15|0xffbc95,0|15|0xffcdb1", 90, 462, 479, 690, 580 } --多点找色

t['佳缘_已注册']={ 0xffffff, "-147|-20|0x93c0ff,108|14|0x93c0ff,198|-118|0xb5d2fc,0|-71|0x373737", 90, 130, 475, 614, 710 } --多点找色
t['注册完成界面1']={ 0xfeecf2, "-180|-17|0xf85b75,180|8|0xf83c84,220|-35|0xf83a84", 90, 50, 825, 688, 932 } --多点找色
t['注册完成界面2']={ 0xffffff, "-64|-20|0xf1deb2,89|12|0xffd83d,186|138|0xfdfdef,195|139|0x53b871", 90, 26, 204, 420, 436 } --多点找色
function reg()
    high = 1
	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 密码 = false
	local 提交 = false
	local 后退 = false
	local 打码key = true
    openURL("https://w.jiayuan.com/w/touch/ldy/new/jy/index.jsp?stid=hesheng2")
    local timeLine = os.time()
    while (os.time()-timeLine < 120 ) do
        if d("佳缘_男女",true,rd(1,2) ) then
        elseif d("佳缘_弹窗_确定" ) then
            if   d("佳缘_弹窗_学历界面")  then
                for i=1,rd(2,5) do
                    moveTo(372,1112,380,1032,20)
                end
                d("佳缘_弹窗_确定",true ) 

            elseif   d("佳缘_弹窗_居住地")  then
				for i=1,rd(1,8) do
                    moveTo(192,1203,188,1035,20)
                end	
				for i=1,rd(2,5) do
                    moveTo(569,1205,571,1027,20)
                end	
                d("佳缘_弹窗_确定",true ) 
			elseif   d("佳缘_弹窗_婚姻")  then
				moveTo(384,1113,388,1019,20)
                d("佳缘_弹窗_确定",true ) 			
			elseif   d("佳缘_弹窗_月收入")  then
				for i=1,rd(2,5) do
                    moveTo(372,1112,380,1032,20)
                end
               d("佳缘_弹窗_确定",true ) 
			else
				--生日界面
				for i=1,rd(2,5) do
                    moveTo(124,982,123,1055,20)
                end
				for i=1,rd(2,5) do
                    moveTo(365,1184,1377,1046,20)
                end
				for i=1,rd(2,5) do
                    moveTo(619,1182,621,1041,20)
                end
				d("佳缘_弹窗_确定",true ) 
			end
        elseif d("佳缘_验证码界面") then
			if d("佳缘_验证码界面_发送验证码",true) then
			elseif 验证码 then
				yzm = dxcode.getMessage() 
				if ( yzm  )then
					click(138,535)
					input( yzm )
					delay(2)
					验证码 = false
				else
					delay(3)
				end
			end	
			d("佳缘_输入_完成",true)
            d("佳缘_验证码界面",true)
        elseif d("佳缘_输入手机号界面") then
			if 取号 then
				click(169,1208)
				phone = dxcode.getPhone() 
				if ( phone  )then
					input( phone )
					delay(1)
					取号 = false
					验证码 = true
				end
			end
            d("佳缘_输入_完成",true)
            d("佳缘_输入手机号界面",true)
		
		elseif d("佳缘_已注册") then
		return false
        elseif d("注册完成界面1",true) or d("注册完成界面2",true) then
            Idfa()
            return true
        end
        
    end
end

vpn()
while true do
reg()

end






