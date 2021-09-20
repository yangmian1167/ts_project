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
	postArr.callback = urlEncoder("https://hbapi.honghongdesign.cn/callbackurl/idfa/"..jfq.idfa)
--	postArr.callback = urlEncoder("https://hbapi.honghongdesign.cn/callbackurl/id/623303")

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


t['立即体验']={ 0xffffff, "-232|-28|0x1eca5e,203|28|0x1cba55", 90, 65, 1052, 687, 1178 } --多点找色
t['同意']={ 0x0bc068, "-283|2|0xa4a5a9,39|-16|0x7bddad", 90, 177, 1041, 586, 1094 } --多点找色
t['通用广告X']={ 0xffffff, "-74|12|0x0f0f0f,82|14|0x0f0f0f,-33|32|0x494949,67|-7|0x494949", 90, 278, 1032, 475, 1088 } --多点找色
t['主页点我的']={ 0xd8d8d8, "-10|-20|0xfefefe,20|-23|0xfefefe,-1|25|0x9ca3b0", 90, 629, 1241, 685, 1326 } --多点找色
t['登录注册']={ 0x333333, "-32|168|0x03aaff,156|166|0x7a6bfa,159|0|0x333333", 90, 11, 109, 398, 437 } --多点找色
t['手机号界面']={ 0x19b955, "-106|-41|0x19b955,-72|77|0x19b955,-88|-324|0x19b955,-14|-321|0x19b955", 90, 214, 81, 698, 788 } --多点找色
t['验证码界面']={ 0x19b955, "151|59|0x19b955,54|-120|0x19b955,162|-125|0x19b955", 90, 485, 455, 712, 701 } --多点找色
t['tips_好']={ 0x007aff, "-314|-14|0x007aff", 90, 167, 755, 572, 830 } --多点找色
t['额度评估1']={ 0xffffff, "-318|-27|0x253239,51|58|0xaa8e67", 90, 180, 42, 608, 176 } --多点找色
t['额度评估2']={ 0xcccccc, "-284|-23|0x1d282d,69|48|0x887152", 90, 215, 54, 612, 138 } --多点找色
function reg(name)
	
	local TimeLine = os.time()
	local OutTime = 60*5

	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 密码 = false
	local 提交 = false
	local 后退 = false
	local 打码key = true
	
--	local 密码 = true
	local 提交过了 = false
	local movekey = 1
	取短信次数 = 0
	发验证码次数 = 0
	sex = rd(1,100)
	sex_key = 50
--	password = myRand(4,rd(8,12))
	password = 'AaDd112211'

	while os.time()-TimeLine < OutTime do
		if active(bid[name]['appbid'],2) then
			if d("手机号界面") then
				if 取号 then
					phone = dxcode.getPhone()
					number = phone
					if phone ~= nil or phone ~= '' then
						click(107,403)
						inputword(phone)
						click(68,676)
						取号 = false
						短信 = true	
					end
				elseif d("手机号界面",true) then
				end	
			elseif d("验证码界面") then
				if 短信 then
					yzm = dxcode.getMessage()
--						log(yzm)
					if yzm ~= nil or yzm ~= '' then
						click(87,409)
						delay(2.8)
						inputword(yzm)			
						提交 = true
						短信 = false
					end
				elseif d("验证码界面",true) then	
				end	
			elseif 提交 and d("额度评估1",true) or 提交 and d("额度评估1",true) then
				return true
--			elseif d("打码界面") then
--				delay(5)
--				lzScreen(497,465,654,563)
--				orcYZM()
--				click(179,526)
--				inputword(yzm_jg)
--				d("打码界面",true)
			elseif d("立即体验",true) then
			elseif d("同意",true) then
			elseif d("主页点我的",true) then
			elseif d("登录注册",true) then
			elseif d("通用广告X",true) then
			elseif d("tips_好",true) then
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
			ip = get_ip()
			if clickNew()then
				if awzstart()then
					delay(3)
					if check_idfa(name)then
						if click_idfa(name)then
							delay(rd(3,5))
							if reg(name) then
								up_hb("注册成功1")
								back_pass(task_id,"ok")
							end
						end
					end
				end
			end
		end
--	end
end


--[[]]
function main(v)
	vpnx()
	delay(3)
		
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
