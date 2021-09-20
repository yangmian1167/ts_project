-- 积分墙对接
-- xtjfq.lua  

-- Create By TouchSpriteStudio on 16:26:24   
-- Copyright © TouchSpriteStudio . All rights reserved.
	
	

require("TSLib")
require("AWZ")
require("jiema")
require("tsp")
require("lzdm")

local var={}
local jfq={}

function awzstart() --获取设备需要的参数
--	local info = getOnlineName()
	local info = get_curren()
	print_r(info)
	if info ~= nil then
		jfq.idfa = strSplit(info[8],":")[2] -- idfa
		jfq.os_version = strSplit(info[3],":")[2] --系统版本
		jfq.device = readFile(userPath().."/lua/model.txt")[1] --机型(触动手动配置)
		jfq.udid = strSplit(info[4],":")[2] --udid
		return true
	end
end

function check_idfa(name)
	local url = "http://api.check.adzshd.com/RemoveEcho.ashx"
	local postArr = {}
	postArr.adid = bid[name]['adid']
	postArr.appid = bid[name]['appid']
	postArr.idfa = jfq.idfa
	postArr.udid =jfq.udid
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.os = jfq.device
	postArr.KeyWords = bid[name]['keyword']
	postArr.osversion = jfq.os_version 
	postArr.btype ='1'
--	log(postArr)
	local postdata = ''
	for k,v in pairs(postArr) do
		postdata = postdata .. '&'..k..'='..v
	end
	local res = url .."?"..postdata
	local getdata = get(res)
	if getdata ~= nil then
		log(getdata)
		if (getdata[jfq.idfa]) == '0' or (getdata[jfq.idfa])  == 0 then
			log("排重成功",'all')
			return true
		else
			log("idfa-排重失败",'all')
		end
	end	
end

function click_idfa(name)
	local url = "http://api.check.adzshd.com/SourceClick.ashx"
	local postArr = {}
	postArr.adid = bid[name]['adid']
	postArr.appid = bid[name]['appid']
	postArr.idfa = jfq.idfa
	postArr.udid =jfq.udid
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.mac = '02:00:00:00:00:00'
	postArr.os = jfq.device
	postArr.KeyWords = bid[name]['keyword']
	postArr.osversion = jfq.os_version 
	postArr.btype ='1'
--	postArr.callback = urlEncoder("http://hbapi.honghongdesign.cn/callbackurl/idfa/"..jfq.idfa)
	postArr.callback = urlEncoder("http://hbapi.honghongdesign.cn/callbackurl/idfa/478778")

--	log(postArr)
	local postdata = ''
	for k,v in pairs(postArr) do
		postdata = postdata .. '&'..k..'='..v
	end
	local res = url .."?"..postdata
	log(res)
	local getdata = get(res)
	if getdata ~= nil then
		log(getdata or "nil")
		if getdata["message"] == 'ok' and getdata["success"] == true then
			log("点击成功",'all')
			return true
		else
			log("idfa-点击失败",'all')
		end
	end
end


function up(other)
	local url = 'http://wenfree.cn/api/Public/idfa/'
	local idfalist ={}
	idfalist.service = 'Idfa.Idfa'
	idfalist.phonename = getDeviceName()
--	idfalist.phoneimei = getIMEI()
	idfalist.phoneos = jfq.os_version
	idfalist.idfa = jfq.idfa
	idfalist.ip = ip or get_ip() or '192.168.1.1'
	idfalist.account = bid[work]['keyword']
	idfalist.password = var.password
	idfalist.phone = phone
	idfalist.appid = bid[work]['appid']
	idfalist.name = work
	idfalist.other = other
	log( post(url,idfalist) )
end
function up_hb(other)
	local url = 'http://hb.wenfree.cn/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = work
	postdate.idfa = jfq.idfa
	postdate.phone = phone
--	postdate.password = password
	postdate.ip = ip or get_ip() or '192.168.1.1'
	postdate.other = other
--	postdate.account = account
	log(post(url,postdate))
	-- body
end


if not(t) then
    t = {}
end
local degree = 85
t['agree']={0xff5100,"-196|-35|0xff7f00,-507|24|0xf2f2f2",degree,48,1124,707,1274}
t['skip']={0xf2f2f2,"506|-8|0xff4800,-17|-45|0xf2f2f2",degree,43,1190,713,1319}

function app()
	local timeLine = os.time()
	while os.time() - timeLine < rd(12,15) do
		if active(jfq.bid,1)then
			if d("agree",true,2)then
			elseif d("skip",true,2)then
			end
		end
		delay(1)
	end
	return true
end
t['chrome同意']={ 0xffffff, "-92|-28|0x2c75f0,98|11|0x2c75f0", 90, 261, 1193, 495, 1264 } --多点找色
t['chrome不谢谢']={ 0x2c75f0, "61|3|0x2c75f0", 90, 47, 1237, 192, 1294 } --多点找色
t['chrome输入网址']={ 0xea4335, "-31|-6|0x34a853,-177|-7|0xfbbc05,-295|-26|0x4285f4", 90, 179, 187, 577, 355 } --多点找色
t['chrome输入界面']={ 0x4285f4, "-14|11|0x34a853,-26|1|0xfbbc04,-15|-15|0xe94235", 90, 45, 65, 82, 104 } --多点找色
function openchrome(url)
	local timeLine = os.time()
	while os.time() - timeLine < rd(25,30) do
		if active("com.google.chrome.ios",1)then
			if d("chrome同意",true,2)then
			elseif d("chrome不谢谢",true,2)then
			elseif d("chrome输入网址")then
				click(331,525)
				mSleep(3000)
			elseif d("chrome输入界面")then
				inputText(url)
				click(381,1289)
				click(678,1293)
				return true
			end
		end	
	end
end

t['百合网-男女']={0x6cabfd, "354|1|0xff7a5e,145|-4|0x5eb4fb,146|-4|0xff9c5d",90,21,1121,732,1264}
t['百合网->']={0x969799, "-10|-10|0x969799,-10|11|0x969799,-7|0|0xffffff",90,528,1155,740,1323}
    t['百合网-弹窗->确定']={0x1989fa, "0|0|0x1989fa,0|-5|0x1989fa",90,594,627,739,889}
        t['百合网-弹窗->选择生日']={0x323233, "0|0|0x323233,250|-2|0x323233,500|-2|0x323233",90,22,964,709,1085}
        t['百合网-弹窗->选择居住地']={0x323233, "0|0|0x323233,227|3|0xffffff,393|0|0x323233",90,76,954,645,1089}
        t['百合网-弹窗->选择身高']={0x323233, "0|0|0x323233,-348|5|0xffffff,335|8|0xffffff",90,12,945,737,1110}
            t['百合网-弹窗->选择身高->5万']={0x323233, "0|0|0x323233,-12|-14|0xffffff,-7|-16|0x323233,-100|-21|0x323233,-91|-23|0xfcfcfc,-90|-24|0x383839",90,279,999,452,1051}
t['百合网-未婚-离异-失偶']={0xffffff, "0|0|0xffffff,245|3|0xff5f5e,513|-1|0xff5f5e,391|-27|0xffffff,391|-43|0xff5f5e",90,11,1130,708,1315}
t['百合网-随机昵称-发送']={0xff6968, "144|4|0xff5f5e,70|2|0xff5f5e,69|2|0xffffff,-59|-1|0xff5f5e",90,430,1152,732,1292}
t['百合网-请输入手机号']={0x969799, "0|0|0x969799,446|-19|0xff5f5e,530|20|0xff5f5e,478|1|0xffffff",90,16,1156,737,1285}
t['百合网-发送']={0xff5f5e, "0|0|0xff5f5e,3|-20|0xff5f5e,18|-3|0xffffff",90,568,597,742,1316}
--注册过
t['百合网-点击下载']={0xf2317d, "0|0|0xf2317d,141|118|0x0202ee,325|142|0x0000ee",90,10,865,733,1244}
t['百合网-清理输入']={0xffffff, "0|0|0xffffff,-1|-9|0xc8c9cc,104|18|0xff5f5e",90,505,623,735,1311}
    t['百合网-清理输入-完成']={0x007aff, "0|0|0x007aff,1|-6|0x007aff",90,644,541,733,1034}
--验证码
t['百合网-请输入验证码']={0x969799, "0|0|0x969799,388|-21|0xeeeeee,414|-17|0xffffff,442|-4|0xff5f5e",95,7,1152,732,1323}
t['百合网-请输入密码']={0x969799, "0|0|0x969799,391|-3|0xffffff,393|-3|0x969799,384|-3|0x969799,375|-3|0x999a9c,428|-3|0xffffff,429|-3|0xff5f5e",95,2,1138,733,1302}
t['百合网-注册完成']={0xff5f5e, "0|0|0xff5f5e,3|-18|0xffffff,203|-6|0xf0f0f0,202|-6|0xff5f5e,423|-17|0xfe6261",90,59,1133,655,1294}
t['百合网-卡住']={0x007aff, "0|0|0x007aff,-27|-96|0xff5f5e,-66|-120|0xff5f5e",90,565,605,740,1079}

t['百合注册过的']={ 0x2a2af0, "-89|-5|0x9090f7,-225|-6|0x7676f5,-231|-117|0xfc6e27", 90, 23, 906, 627, 1123 } --多点找色
function reg(name)
    high = 1
	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 密码 = false
	local 提交 = false
	local 后退 = false
	local 打码key = true
    openchrome("http://m.baihe.com/regChat?channel=hscm&code=11")
    local timeLine = os.time()
    while (os.time()-timeLine < 220 ) do
        if d("百合网-男女",true,rd(1,2) ) then
        elseif d("百合网->",true ) then
        elseif d("百合网-卡住",true ) then
        elseif d("百合网-弹窗->确定" ) then
            if ( d("百合网-弹窗->选择生日") )then
                for i=1,rd(2,3) do
                    moveTo(125,850,125,1100,20)
                end
                for i=1,rd(2,3) do
                    moveTo(370,850,370,1100,20)
                end
                for i=1,rd(2,3) do
                    moveTo(622,850,622,1100,20)
                end
                d("百合网-弹窗->确定",true )
            elseif   d("百合网-弹窗->选择居住地")  then
                for i=1,rd(2,5) do
                    moveTo(125,1100,125,850,20)
                end
                for i=1,rd(2,5) do
                    moveTo(558,1100,558,850,20)
                end
                d("百合网-弹窗->确定",true )
            elseif   d("百合网-弹窗->选择身高")  then
                local movteaa = { 10,2,3 }
                for i=1,rd(1,movteaa[high] ) do
                    moveTo(558,1100,558,rd(850,1000),20)
                    delay(0.5)
                end
                high = high + 1
                d("百合网-弹窗->确定",true )
            end
        elseif d("百合网-未婚-离异-失偶",true ) then
        elseif d("百合网-随机昵称-发送",true ) then
            d("百合网-发送",true)
        elseif d("百合网-请输入密码",true) then
            input[1]( "Aa123456" )
            delay(1)
            d("百合网-发送",true)
            d("百合网-清理输入-完成",true)
        elseif d("百合网-请输入验证码",true) then
			if 验证码 then
				yzm = dxcode.getMessage() 
				if ( yzm  )then
					input[1]( yzm )
					delay(1)
					d("百合网-发送",true)
					delay(2)
					验证码 = false
				else
					delay(3)
				end
			end
            d("百合网-清理输入-完成",true)
        elseif d("百合网-请输入手机号",true,1,2)then
			if 取号 then
			phone = dxcode.getPhone() 
				if ( phone  )then
					input[1]( phone )
					delay(1)
					d("百合网-发送",true)
					delay(2)
					取号 = false
					验证码 = true
				end
			end
            d("百合网-清理输入-完成",true)

		elseif d("百合注册过的",true) then
		return false
        elseif d("百合网-注册完成",true) then
            return true
        end
        
    end
end
t['佳缘_立即参加']={ 0xfff4f0, "-191|-19|0xff734d,108|31|0xff5269,108|-43|0xf9d0c2", 90, 183, 922, 546, 1061 } --多点找色
t['佳缘_完善资料']={ 0xfd7d76, "-192|-4|0xffffff,-446|-40|0xff9575,26|-46|0xfc6c6a", 90, 87, 268, 718, 353 } --多点找色
t['佳缘_完善资料_男女']={ 0xc5c5c5, "-360|-19|0xc5c5c5,-302|-28|0xececec,39|27|0xececec", 90, 127, 772, 646, 911 } --多点找色
t['佳缘_完善资料_出生']={ 0xf98f70, "-51|-2|0xf99375,3|17|0xfbbaa7", 90, 21, 519, 111, 565 } --多点找色
t['佳缘_完善资料_所在地']={ 0xffffff, "-14|2|0xffffff,-74|-33|0xfe6857,79|17|0xff5963", 90, 283, 1076, 489, 1196 } --多点找色
t['佳缘_完善资料_婚姻状态']={ 0xd5d5d7, "-53|-24|0xbcbcbf,-56|-3|0xeaeaeb,3|-27|0xefeff0", 90, 301, 683, 447, 793 } --多点找色
t['佳缘_完善资料_学历']={ 0x8e8e93, "-6|135|0x8e8e93,-1|271|0x8e8e93,2|402|0x96969b,-8|543|0x8e8e93", 90, 326, 512, 423, 1177 } --多点找色
t['佳缘_完善资料_收入']={ 0x8e8e93, "49|142|0x8e8e93,60|276|0x8e8e93,24|420|0x8e8e93,49|532|0x8e8e93", 90, 305, 509, 439, 1229 } --多点找色
t['佳缘_手机号界面']={ 0xff7e45, "-91|2|0xff7e45,-26|-15|0xff7e45", 90, 493, 168, 618, 392 } --多点找色
t['佳缘_手机号界面_获取验证码']={ 0xff7e45, "-120|42|0xff7e45", 90, 489, 527, 629, 769 } --多点找色
t['佳缘_手机号界面_确定']={ 0xffffff, "-38|4|0xffffff,-67|-29|0xff6857,58|25|0xff5c61", 90, 304, 603, 466, 1047 } --多点找色
t['佳缘_已注册']={ 0xff2380, "-615|-23|0xfe5e51,-553|59|0xfc6da2,-36|100|0xfc6da2,-135|17|0x666666", 90, 25, 144, 737, 330 } --多点找色
t['佳缘_滑动弹窗']={ 0x66d200, "-15|0|0x5aab0e,29|2|0xf9f9f9,15|2|0x66d200", 90, 141, 770, 623, 839 } --多点找色
t['佳缘_滑动点']={ 0x0c361b, "", 80, 231, 444, 614, 741 } --多点找色
t['佳缘_滑动点1']={ 0x00453e, "", 80, 250, 446, 616, 742 } --多点找色
t['滑动不吻合']={ 0xde715b, "-431|-16|0xde715b,-50|-16|0xde715b", 90, 142, 701, 610, 739 } --多点找色

    t['佳缘_输入_完成']={0x007aff, "0|0|0x007aff,1|-6|0x007aff",90,644,541,733,1034}
	t['佳缘_输入_完成1']={ 0x2c75f0, "", 90, 650, 747, 725, 788 } --多点找色	
	t['注册完成界面1']={ 0xfeecf2, "-180|-17|0xf85b75,180|8|0xf83c84,220|-35|0xf83a84", 90, 50, 825, 688, 932 } --多点找色
t['注册完成界面2']={ 0xffffff, "-64|-20|0xf1deb2,89|12|0xffd83d,186|138|0xfdfdef,195|139|0x53b871", 90, 26, 204, 420, 436 } --多点找色
t['注册完成界面3']={ 0x457401, "-34|-123|0xa8d591,-212|-125|0xa57433", 90, 18, 232, 475, 438 } --多点找色
function reg2(name)
    high = 1
	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 密码 = false
	local 提交 = false
	local 后退 = false
	local 打码key = true
	urljy = "https://m.jiayuan.com/register/matching.php?from=fengyue"
    openchrome(urljy)
    local timeLine = os.time()
    while (os.time()-timeLine < 150 ) do
        if d("佳缘_完善资料",true ) then
			if d("佳缘_完善资料_男女",true,rd(1,2) ) then
			elseif d("佳缘_完善资料_出生" ) then
				click((48+(150*(rd(0,4)))),(774+(120*rd(0,3))))
				
			elseif d("佳缘_完善资料_所在地" ) then	
				for i=1,rd(1,3) do
                    moveTo(534,775,528,854,20)
                end	
				click(371,1214)
			elseif d("佳缘_完善资料_婚姻状态",true ) then
			elseif d("佳缘_完善资料_学历",true,rd(1,5) )then
			elseif d("佳缘_完善资料_收入",true,rd(1,5) )then
			
			end	
		elseif d("佳缘_手机号界面" )then
			if 取号 then
				click(455,615)
				phone = dxcode.getPhone() 
				if ( phone  )then
					input[1]( phone )
					delay(1)
					d("佳缘_输入_完成",true)
					取号 = false
					验证码 = true
				end
			elseif 验证码 then
				if d("佳缘_手机号界面_获取验证码",true) then
				else	
					yzm = dxcode.getMessage() 
					if ( yzm  )then
						click(320,719)
						input[1]( yzm )
						delay(1)
						d("佳缘_输入_完成",true )
						delay(1)
						d("佳缘_手机号界面_确定",true )
						验证码 = false
					else
						delay(3)
					end	
				end
			end
		elseif d("佳缘_滑动弹窗" ) then
			if d("滑动不吻合")then
				delay(2)
				click(216,909)
			elseif d("佳缘_滑动点") or d("佳缘_滑动点1") then
				moveTo(140,800,x,y,20)
			end
		elseif d("佳缘_立即参加",true ) then
		elseif d("注册完成界面1",true) or d("注册完成界面2",true) then
            return true	
		elseif d("佳缘_已注册" ) then
			return false
		end
    end
end
function reg3(name)
    high = 1
	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 密码 = false
	local 提交 = false
	local 后退 = false
	local 打码key = true
	urljy = "https://m.baihe.com/ditchReg?channel=sgjz&code=1"
    openchrome(urljy)
    local timeLine = os.time()
    while (os.time()-timeLine < 150 ) do
        if d("佳缘_完善资料",true ) then
			if d("佳缘_完善资料_男女",true,rd(1,2) ) then
			elseif d("佳缘_完善资料_出生" ) then
				click((48+(150*(rd(0,4)))),(774+(120*rd(0,3))))
				
			elseif d("佳缘_完善资料_所在地" ) then	
				for i=1,rd(1,3) do
                    moveTo(534,775,528,854,20)
                end	
				click(371,1214)
			elseif d("佳缘_完善资料_婚姻状态",true ) then
			elseif d("佳缘_完善资料_学历",true,rd(1,5) )then
			elseif d("佳缘_完善资料_收入",true,rd(1,5) )then
			
			end	
		elseif d("佳缘_手机号界面" )then
			if 取号 then
				log("dianjiquhao")
				click(455,615)
				phone = dxcode.getPhone() 
				if ( phone  )then
					input[1]( phone )
					delay(1)
					d("佳缘_输入_完成",true)
					取号 = false
					验证码 = true
				end
			elseif 验证码 then
				if d("佳缘_手机号界面_获取验证码",true) then
				else	
					yzm = dxcode.getMessage() 
					if ( yzm  )then
						click(315,712)
						input[1]( yzm )
						delay(1)
						d("佳缘_输入_完成",true )
						delay(1)
						d("佳缘_手机号界面_确定",true )
						验证码 = false
					else
						delay(3)
					end	
				end
			end
		elseif d("佳缘_滑动弹窗" ) then
			if d("滑动不吻合")then
				delay(2)
				click(216,909)
			elseif d("佳缘_滑动点") or d("佳缘_滑动点1") then
				moveTo(140,800,x,y,20)
			end
		elseif d("佳缘_立即参加",true ) then
		elseif d("注册完成界面1",true) or d("注册完成界面2",true)or d("注册完成界面3",true) then
            return true	
		elseif d("佳缘_已注册" ) then
			return false
		end
    end
end
function back_pass(task_id,success)
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.backpass'
	local postArr = {}
	postArr.task_id = task_id
	postArr.success = success
	nLog( post(url,postArr) )
end


function callbackapi(name)
--	if ios13配置VPN()then
		if false or vpn() then
			delay(3)
			if clickNew()then
				if awzstart()then
					delay(3)
	--				if check_idfa(name)then
	--					if click_idfa(name)then
	--						delay(rd(3,5))
							if bid[name]['keyword'] == "1" then
								if reg(name) then
									up_hb("注册成功1")
									back_pass(task_id,"ok")			
									改密 = math.random(1,10)
									if 改密 <= 5 then
										repassword(name)
									end
								end
							elseif bid[name]['keyword'] == "2" then
								if reg2(name) then
									up_hb("注册成功1")
									back_pass(task_id,"ok")
									改密 = math.random(1,10)
									if 改密 <= 5 then
										repassword(name)
									end
								end
							elseif bid[name]['keyword'] == "3" then
								if reg3(name) then
									up_hb("注册成功1")
									back_pass(task_id,"ok")
									改密 = math.random(1,10)
									if 改密 <= 5 then
										repassword(name)
									end
								end
							end	
	--					end
	--				end
				end
			end
		end
--	end
end


--[[]]
function main(v)
	vpnx()
	delay(3)
		ip = get_ip()
		nLog(v)
		work = v.work
		task_id = v.task_id
		bid={}
		bid[work]={}
		bid[work]['adid']=v.adid
		bid[work]['keyword']=v.keyword
		bid[work]['appbid']=v.appbid
		bid[work]['appid']=v.appid
		dxcode = _Server_newget()
		nLog("act")
		callbackapi(work)
end
--]]
