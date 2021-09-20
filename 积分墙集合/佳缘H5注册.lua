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
	postdate.account = bid[work]['keyword']
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
	while os.time() - timeLine < rd(55,60) do
		if active("com.google.chrome.ios",1)then
			if d("chrome同意",true,2)then
			elseif d("chrome不谢谢",true,2)then
			elseif d("chrome输入网址")then
				click(314,515)
				mSleep(5000)
			elseif d("chrome输入界面")then
				inputText(url)
				click(381,1289)
				click(678,1293)
				return true
			end
		end	
	end
end


t['佳缘_男女']={ 0x7e9ffe, "667|30|0xff665e", 90, 3, 1138, 742, 1237 } --多点找色
    t['佳缘_输入_完成']={0x007aff, "0|0|0x007aff,1|-6|0x007aff",90,644,541,733,1034}
	t['佳缘_输入_完成1']={ 0x2c75f0, "", 90, 650, 747, 725, 788 } --多点找色	
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
t['注册完成界面3']={ 0x457401, "-34|-123|0xa8d591,-212|-125|0xa57433", 90, 18, 232, 475, 438 } --多点找色
t['注册完成界面4']={ 0xffffff, "-83|-4|0xe4c38d,107|109|0x457401,136|75|0xf8f8f2", 90, 38, 240, 347, 396 } --多点找色
function reg(name)
    high = 1
	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 密码 = false
	local 提交 = false
	local 后退 = false
	local 打码key = true
	urljy = "https://w.jiayuan.com/w/touch/ldy/new/jy/index.jsp?stid=hesheng2"
    if openchrome(urljy) then
		local timeLine = os.time()
		while (os.time()-timeLine < 150 ) do
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
						input[1]( yzm )
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
						input[1]( phone )
						delay(1)
						取号 = false
						验证码 = true
					end
				end
				d("佳缘_输入_完成",true)
				d("佳缘_输入_完成1",true)
				d("佳缘_输入手机号界面",true)
			
			elseif d("佳缘_已注册") then
			return false
			elseif d("注册完成界面1",true) or d("注册完成界面2",true)or d("注册完成界面3",true) or d("注册完成界面4",true) then
				return true
			end
        end
    end
end
t['佳缘_立即参加']={ 0xffffff, "-99|-10|0xffffff,-307|-30|0xf86d6d,220|27|0xf73a85,234|-92|0xf96472", 90, 71, 691, 705, 901 } --多点找色
t['佳缘_完善资料']={ 0xf1c6fc, "-83|-51|0xffb8a1,453|-21|0xffada1,535|-40|0xff9d94", 90, 14, 210, 726, 291 } --多点找色
t['佳缘_完善资料_男女']={ 0xc5c5c5, "361|10|0xc5c5c5,335|18|0xe6e6e6,-39|18|0xf3f3f3,-40|121|0xd6d5d5,347|121|0xffffff", 90, 69, 787, 673, 995 } --多点找色
t['佳缘_完善资料_出生']={ 0xfaae98, "-73|-22|0xfeeae4,3|-29|0xfccabb,-41|1|0xfde1d9", 90, 24, 538, 120, 581 } --多点找色
t['佳缘_完善资料_所在地']={ 0xffffff, "-46|-1|0xffffff,-257|-31|0xb0b0b0,249|-21|0xb0b0b0,273|-39|0xffffff", 90, 78, 1152, 679, 1239 } --多点找色
t['佳缘_完善资料_婚姻状态']={ 0x080808, "-38|-9|0x000000,-27|0|0x000000,-1|14|0x3a3a3a", 90, 342, 679, 409, 710 } --多点找色
t['佳缘_完善资料_学历']={ 0x000000, "-8|139|0x000000,-7|289|0x1f1f1f,6|429|0x000000,-7|560|0x3c3c3c", 90, 330, 548, 415, 1151 } --多点找色
t['佳缘_完善资料_收入']={ 0x000000, "-2|142|0x000000,-2|285|0x000000,4|415|0x000000,-2|547|0x070707", 90, 322, 543, 419, 1158 } --多点找色
t['佳缘_手机号界面']={ 0xf83f84, "-132|-7|0xf83f84,-103|-6|0xf83f84,-62|-8|0xf83f84", 90, 339, 160, 555, 464 } --多点找色
t['佳缘_手机号界面_获取验证码']={ 0xf83b84, "-145|-6|0xf86d6d", 90, 494, 504, 695, 741 } --多点找色
t['佳缘_手机号界面_确定']={ 0xffffff, "-236|-24|0xf96770,159|26|0xf83e83,279|-33|0xffffff", 90, 70, 836, 679, 932 } --多点找色
t['佳缘_已注册']={ 0xff2380, "-615|-23|0xfe5e51,-553|59|0xfc6da2,-36|100|0xfc6da2,-135|17|0x666666", 90, 25, 144, 737, 330 } --多点找色
t['佳缘_滑动弹窗']={ 0x66d200, "-15|0|0x5aab0e,29|2|0xf9f9f9,15|2|0x66d200", 90, 141, 770, 623, 839 } --多点找色
t['佳缘_滑动点']={ 0x0c361b, "", 80, 231, 444, 614, 741 } --多点找色
t['佳缘_滑动点1']={ 0x00453e, "", 80, 250, 446, 616, 742 } --多点找色
t['滑动不吻合']={ 0xde715b, "-431|-16|0xde715b,-50|-16|0xde715b", 90, 142, 701, 610, 739 } --多点找色

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
    if openchrome(urljy) then
		local timeLine = os.time()
		while (os.time()-timeLine < 150 ) do
			if d("佳缘_完善资料",true ) then
				if d("佳缘_完善资料_男女",true,rd(1,2) ) then
				elseif d("佳缘_完善资料_出生" ) then
					click((48+(150*(rd(0,4)))),(774+(120*rd(0,3))))
					
				elseif d("佳缘_完善资料_所在地" ) then	
					for i=1,rd(1,3) do
						moveTo(528,854,534,775,20)
					end	
					click(371,1214)
				elseif d("佳缘_完善资料_婚姻状态",true ) then
				elseif d("佳缘_完善资料_学历",true,rd(1,5) )then
				elseif d("佳缘_完善资料_收入",true,rd(1,5) )then
				
				end	
			elseif d("佳缘_手机号界面" )then
				if 取号 then
					click(254,589)
					phone = dxcode.getPhone() 
					if ( phone  )then
						input[1]( phone )
						delay(1)
						d("佳缘_输入_完成",true)
						d("佳缘_输入_完成1",true)
						取号 = false
						验证码 = true
					end
				elseif 验证码 then
					if d("佳缘_手机号界面_获取验证码",true) then
					else	
						yzm = dxcode.getMessage() 
						if ( yzm  )then
							click(232,689)
							input[1]( yzm )
							delay(1)
							d("佳缘_输入_完成",true )
							d("佳缘_输入_完成1",true)
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
			elseif d("注册完成界面1",true) or d("注册完成界面2",true)or d("注册完成界面3",true)or d("注册完成界面4",true) then
				return true	
			elseif d("佳缘_已注册" ) then
				return false
			end
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
	urljy = "https://m.jiayuan.com/register/matching.php?from=shuchuan"
    if openchrome(urljy) then
		local timeLine = os.time()
		while (os.time()-timeLine < 150 ) do
			if d("佳缘_完善资料",true ) then
				if d("佳缘_完善资料_男女",true,rd(1,2) ) then
				elseif d("佳缘_完善资料_出生" ) then
					click((48+(150*(rd(0,4)))),(774+(120*rd(0,3))))
					
				elseif d("佳缘_完善资料_所在地" ) then	
					for i=1,rd(1,3) do
						moveTo(528,854,534,775,20)
					end	
					click(371,1214)
				elseif d("佳缘_完善资料_婚姻状态",true ) then
				elseif d("佳缘_完善资料_学历",true,rd(1,5) )then
				elseif d("佳缘_完善资料_收入",true,rd(1,5) )then
				
				end	
			elseif d("佳缘_手机号界面" )then
				if 取号 then
					click(254,589)
					phone = dxcode.getPhone() 
					if ( phone  )then
						input[1]( phone )
						delay(1)
						d("佳缘_输入_完成",true)
						d("佳缘_输入_完成1",true)
						取号 = false
						验证码 = true
					end
				elseif 验证码 then
					if d("佳缘_手机号界面_获取验证码",true) then
					else	
						yzm = dxcode.getMessage() 
						if ( yzm  )then
							click(232,689)
							input[1]( yzm )
							delay(1)
							d("佳缘_输入_完成",true )
							d("佳缘_输入_完成1",true)
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
			elseif d("注册完成界面1",true) or d("注册完成界面2",true)or d("注册完成界面3",true)or d("注册完成界面4",true) then
				return true	
			elseif d("佳缘_已注册" ) then
				return false
			end
		end
	end
end
t['ps佳缘_登录界面']={ 0xfcacbb, "334|52|0xfc9ec2,428|-10|0xffffff", 90, 65, 583, 705, 691 } --多点找色
t['找回密码']={ 0x4a95d5, "", 90, 546, 737, 673, 771 } --多点找色
t['密码登录']={ 0x4a95d5, "", 90, 73, 515, 198, 555 } --多点找色
t['找回密码界面1']={ 0x8f8f8f, "12|39|0xd7d7d7,56|-9|0xcecece,39|50|0xececec", 90, 319, 166, 381, 229 } --多点找色
t['找回密码界面1_获取验证码']={ 0xfb92b6, "-163|-34|0xf85579,74|16|0xf84082", 90, 218, 627, 525, 712 } --多点找色
t['找回密码界面1_正在验证码']={ 0xffffff, "-216|-28|0xc8c9cc,98|23|0xc8c9cc", 90, 144, 618, 558, 727 } --多点找色
t['找回密码界面2']={ 0xcecece, "-65|10|0xc6c6c6,-65|48|0xd7d7d7,-30|48|0xb1b1b1", 90, 315, 160, 389, 231 } --多点找色
t['找回密码界面2_提交']={ 0xf83c84, "-347|-38|0xf95977", 90, 129, 453, 615, 818 } --多点找色
t['注册完成_账号验证']={ 0x4a90e2, "-588|-348|0x000000,-530|-269|0x4a95d5,-83|-274|0x4a95d5", 90, 20, 125, 720, 579 } --多点找色
t['注册完成_上传头像']={ 0xffffff, "-125|-32|0xf96f6c,265|15|0xf84e7c,-56|-244|0x35d8bc,277|-281|0xe17ed9", 90, 118, 941, 634, 1321 } --多点找色

t['佳缘_滑动弹窗1']={ 0x66d200, "-11|-2|0xd2eeb7,15|-9|0x66d200", 90, 142, 756, 643, 823 } --多点找色


function repassword(name)
	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 密码 = false
	local 提交 = false
	local 后退 = false
	local 打码key = true
	local timeLine = os.time()
    while (os.time()-timeLine < 160 ) do
		if active(bid[name]["appbid"],5 )then
			if d("找回密码",true) then
			elseif d("密码登录",true) then
			elseif d("佳缘_滑动弹窗1" ) then
				if d("滑动不吻合")then
					delay(2)
					click(216,909)
				elseif d("佳缘_滑动点") or d("佳缘_滑动点1") then
					moveTo(140,800,(x+20),y,20)
				end
			elseif d("找回密码界面1" ) then
				if 取号 then
					click(300,354)
					phone = dxcode.getPhoneagain() 
					if ( phone  )then
						input[1]( phone )
						delay(1)
						d("佳缘_输入_完成",true)
						验证码 = true
						取号 = false
						
					end	
				elseif d("找回密码界面1_获取验证码",true) then
				elseif 验证码 and d("找回密码界面1_正在验证码") then	
					yzm = dxcode.getMessage() 
					if ( yzm  )then
						click(149,448)
						inputword( yzm )
						delay(3)
						d("ps佳缘_登录界面",true )
						密码 = true
						验证码 = false
					else
						delay(3)
					end	
				end
			elseif d("找回密码界面2" ) then
				if 密码 then
					click(123,323)
					input[1]("as123456")
					click(113,414)
					input[1]("as123456")
					提交 = true
					密码 = false
				end	
				d("找回密码界面2_提交",true )
			
			elseif 提交 and d("注册完成_账号验证") or 提交 and d("注册完成_上传头像") then
				up_hb("改密成功")
				return true
			end
		end	
		delay(1)
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
										delay(60)
										repassword(name)
									end
								end
							elseif bid[name]['keyword'] == "3" then
								if reg3(name) then
									up_hb("注册成功1")
									back_pass(task_id,"ok")
									改密 = math.random(1,10)
									if 改密 <= 5 then
										delay(60)
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
--		if bid[work]['appid'] == "德芙" then
--			dxcode1 = _vCode_df()
--		elseif bid[work]['appid'] == "流星云" then
--			log("流星云")
--			dxcode1 = _vCode_lh()
--		end
		nLog("act")
		callbackapi(work)
end
--]]
