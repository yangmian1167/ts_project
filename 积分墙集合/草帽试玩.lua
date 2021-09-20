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
	local url = "http://h5.yidaocaomao.com/api/quick/check"
	local postArr = {}
	postArr.channel = bid[name]['adid']
	postArr.taskId = bid[name]['appid']
	postArr.idfa = jfq.idfa
	postArr.udid =jfq.udid
	postArr.sysVersion = jfq.os_version
	postArr.deviceType = jfq.device
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.keyword = bid[name]['keyword']
--	postArr.callback = urlEncoder("https://hbapi.honghongdesign.cn/callbackurl/idfa/"..jfq.idfa)
	local postdata = ''
	for k,v in pairs(postArr) do
		postdata = postdata .. '&'..k..'='..v
	end
	local res = url .."?"..postdata
	log(res)
	local getdata = get(res)
	if getdata ~= nil then
		log(getdata)
		if (getdata['msg']) == "未安装，可以做任务！" then
			log("排重成功",'all')
			return true
		else
			log("idfa-排重失败",'all')
		end
	end	
end

function click_idfa(name)
	local url = "http://h5.yidaocaomao.com/api/quick/click"
	local postArr = {}
	postArr.channel = bid[name]['adid']
	postArr.taskId = bid[name]['appid']
	postArr.idfa = jfq.idfa
	postArr.udid =jfq.udid
	postArr.sysVersion = jfq.os_version
	postArr.deviceType = jfq.device
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.keyword = bid[name]['keyword']
	postArr.callback = urlEncoder("http://hbapi.honghongdesign.cn/callbackurl/idfa/"..jfq.idfa)

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
		if getdata["msg"] == "点击成功"  then
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


t['同意并继续使用']={ 0xffffff, "-207|-3|0xf1f6fe,-277|-15|0x4c8df4,59|30|0x4c8df4,67|-38|0xffffff", 90, 155, 853, 586, 968 } --多点找色
t['跳过']={ 0xffffff, "-69|-16|0x7d9bab,-30|1|0xffffff,20|10|0x7d9bab", 90, 600, 39, 712, 119 } --多点找色
t['我知道了']={ 0xffffff, "-167|-25|0x4c8df4,102|19|0x4c8df4,162|-37|0xffffff", 90, 174, 987, 578, 1073 } --多点找色
t['关注品牌我知道了']={ 0xf4f4f4, "-99|2|0xffffff,109|-479|0x5d260e,136|-445|0xec7742,145|-500|0x1a498c", 90, 150, 333, 592, 1020 } --多点找色
t['X类型1']={ 0xffffff, "8|-23|0xffffff,10|21|0xffffff,-12|12|0xffffff", 90, 620, 122, 697, 188 } --多点找色
t['X类型2']={ 0xffffff, "-9|10|0xffffff,24|-7|0xffffff", 90, 632, 127, 691, 183 } --多点找色
t['X类型3']={ 0xffffff, "-20|13|0xffffff,22|-9|0xffffff", 90, 628, 120, 695, 193 } --多点找色
t['弹窗界面']={ 0xffffff, "15|8|0xffffff,15|-5|0x6f6f6f,10|12|0x6f6f6f", 90, 350, 1091, 398, 1120 } --多点找色
t['弹窗界面2']={ 0xffffff, "0|-11|0x6f6f6f,14|0|0x6f6f6f", 90, 352, 1090, 400, 1118 } --多点找色
t['首页点我的']={ 0xd0021b, "-15|1|0xd0021b,-4|7|0xff5200,-5|35|0x333333", 90, 636, 1251, 677, 1324 } --多点找色
t['首页点我的1']={ 0x333333, "-553|-24|0x1ca7e2,-556|24|0x4c8df4", 90, 71, 1248, 690, 1323 } --多点找色
t['首页点我的2']={ 0x333333, "-546|0|0xdf3441,32|0|0x333333", 90, 69, 1302, 692, 1328 } --多点找色
t['我的界面点登陆']={ 0x997769, "0|21|0xd67d55,100|3|0x333333,190|16|0x363634", 90, 70, 110, 309, 227 } --多点找色
t['手机号注册界面']={ 0x4c8df4, "0|72|0x4c8df4,637|4|0x4c8df4,637|72|0x4c8df4", 90, 40, 593, 719, 863 } --多点找色
t['手机号注册界面_已注册号']={ 0x404040, "-323|20|0xffffff,-3|44|0x13233d,-437|-1|0x404040", 90, 130, 627, 610, 704 } --多点找色
t['手机号注册界面_获取验证码']={ 0xffffff, "-67|1|0xffffff,-158|-33|0x4c8df4,20|27|0x4c8df4", 90, 259, 636, 474, 767 } --多点找色
t['输入验证码界面']={ 0x606060, "-388|-44|0xbbbbbb,2|-43|0xd8d8d8,-387|0|0xacacac", 90, 27, 186, 444, 249 } --多点找色
t['设置密码界面']={ 0x606060, "-340|-41|0xb6b6b6,2|-43|0xd8d8d8,-338|-4|0xababab", 90, 30, 134, 389, 192 } --多点找色
t['设置密码界面_提交']={ 0xffffff, "-47|-16|0xffffff,-81|-34|0x4c8df4,57|14|0x4c8df4", 90, 270, 514, 472, 614 } --多点找色
t['激活小蓝卡']={ 0xffffff, "-128|-15|0x6eb8f9,91|-78|0x232a36,-76|-387|0x388cd6,102|-593|0xffffff", 90, 196, 288, 548, 983 } --多点找色
t['激活小蓝卡2']={ 0xffffff, "-137|1|0x68b3f4,97|-86|0x242b39,149|-479|0x338bd4,153|-573|0x4da9e8", 90, 106, 292, 632, 1024 } --多点找色
t['打码界面']={ 0x4c8df4, "14|-8|0x4c8df4,-316|-6|0x9f9f9f,-367|13|0xbababa,-304|15|0x6d6d6d", 90, 173, 654, 585, 702 } --多点找色


function reg(name)
	
	local TimeLine = os.time()
	local OutTime = 60*3

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
			if d("手机号注册界面") then
				if 取号 then
					phone = dxcode.getPhone()
					number = phone
					if phone ~= nil or phone ~= '' then
						delay(2)
						click(293,814)
						click(69,1248)
--						delay(2.8)
						click(280,598)
						inputword(phone)
						取号 = false
						短信 = true	
					end
				elseif d("手机号注册界面_获取验证码",true) then
					delay(5)
				elseif d("手机号注册界面_已注册号") then
					return false
				else
				end	
			elseif d("输入验证码界面") then
				if 短信 then
					yzm = dxcode.getMessage()
--						log(yzm)
					if yzm ~= nil or yzm ~= '' then
						delay(2.8)
						inputword(yzm)			
						密码 = true
						短信 = false
					end
				end	
			elseif 密码 and d("设置密码界面") then
				if d("设置密码界面_提交",true) then
					提交 = true
				else	
					click(72,400)
					input[1](password)
				end
			elseif 提交 and d("激活小蓝卡") or 提交 and d("激活小蓝卡2") then
				return true
			elseif d("打码界面") then
				delay(5)
				lzScreen(497,465,654,563)
				orcYZM()
				click(179,526)
				inputword(yzm_jg)
				d("打码界面",true)
			elseif d("首页点我的",true) then
			elseif d("首页点我的1",true) then
			elseif d("首页点我的2",true) then
			elseif d("我的界面点登陆",true) then
			elseif d("同意并继续使用",true) then
			elseif d("跳过",true) then
			elseif d("我知道了",true) then
			elseif d("关注品牌我知道了",true) then
			elseif d("弹窗界面") and d("X类型1",true) then
			elseif d("弹窗界面2") and d("X类型2",true) then
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
