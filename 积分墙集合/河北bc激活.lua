
	
require("TSLib")
require("AWZ")
require("jiema")
require("tsp")
require("lzdm")
init(1)
local var={}
local jfq={}

function awzstart() --获取设备需要的参数
--	local info = getOnlineName()
	local info = get_curren()
	print_r(info)
	if info ~= nil then
		jfq.names = strSplit(info[1],":")[2] -- 应用名称
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
	postdate.phoneimei = jfq.names
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

t['游客登录1']={ 0x46d35e, "-171|-28|0x55eb55,17|-12|0x4dde5a", 90, 496, 577, 811, 676 } --多点找色
t['快速开始1']={ 0x8f3910, "-120|-22|0xe2a954,70|23|0xd78f28", 90, 532, 401, 804, 488 } --多点找色
t['菜单1']={ 0xadf2d3, "13|-29|0x181720,-9|-23|0xfafefc", 90, 37, 37, 97, 103 } --多点找色
t['返回1']={ 0xccf5ee, "-126|-13|0xc6fcf5,0|1|0xc6f3eb", 90, 62, 35, 234, 96 } --多点找色
t['确定1']={ 0xffffff, "-56|-17|0xf2ac42,13|1|0xef9812", 90, 728, 463, 885, 526 } --多点找色
t['免费摇奖1']={ 0xf8f1de, "-15|2|0xe94917,-7|34|0x208252", 90, 1117, 99, 1191, 178 } --多点找色
t['签到1']={ 0xffffff, "-107|-18|0xffd800,47|13|0xefaa00", 90, 513, 571, 828, 676 } --多点找色

t['游客登录2']={ 0x5e3a14, "-104|5|0xeabd6b,-206|-2|0x5e3a14", 90, 270, 546, 523, 614 } --多点找色
t['快速开始2']={ 0x7e3003, "-134|6|0xe5bd6f,-157|-1|0x9c602d", 90, 490, 525, 824, 624 } --多点找色
t['菜单2']={ 0xffd778, "27|-1|0x373038,-5|-15|0x403841", 90, 24, 21, 82, 66 } --多点找色
t['返回2']={ 0xe5e5e5, "-66|1|0xddb586,34|-2|0xe9e9e9", 90, 53, 20, 173, 63 } --多点找色
t['签到2']={ 0xfffdcf, "12|4|0xd2543d,-11|19|0xd6821d", 90, 490, 272, 600, 341 } --多点找色

t['游客登录3']={ 0xfaedca, "-164|-29|0xe68a0f,43|-1|0xe7633c", 90, 104, 613, 351, 674 } --多点找色
t['快速开始3']={ 0x9a410c, "-119|-25|0xffef5d,64|6|0xffd822", 90, 591, 548, 836, 627 } --多点找色
t['菜单3']={ 0xcff1ff, "13|4|0x0966b4,-12|14|0x077ace", 90, 13, 12, 70, 75 } --多点找色
t['返回3']={ 0xe7e9ff, "-95|-2|0xe7e9ff,-74|0|0xe7e9ff", 90, 51, 25, 289, 108 } --多点找色
t['确定3']={ 0xffffff, "-338|-24|0x4f94fc,-98|-15|0xfcc409", 90, 418, 479, 949, 550 } --多点找色
t['签到3']={ 0xe9c769, "-25|2|0xfff174,11|-18|0xfcf09c", 90, 272, 287, 434, 370 } --多点找色

function reg(name)
	local TimeLine = os.time()
	local OutTime = math.random(50,60)
	local sjshu = math.random(1,10)
	while os.time()-TimeLine < OutTime do
		if active(bid[name]['appbid'],2) then
			if d("游客登录1",true) then
			elseif d("游客登录2",true) then
			elseif d("游客登录3",true) then
			elseif sjshu < 8 then
				if d("快速开始1",true) then
				elseif d("菜单1",true) then
				elseif d("返回1",true) then
				elseif d("确定1",true) then
				elseif d("免费摇奖1",true) then
				elseif d("签到1",true) then
				elseif d("游客登录2",true) then
				elseif d("快速开始2",true) then
				elseif d("菜单2",true) then
				elseif d("返回2",true) then
				elseif d("签到2",true) then
				elseif d("游客登录3",true) then
				elseif d("快速开始3",true) then
				elseif d("菜单3",true) then
				elseif d("返回3",true) then
				elseif d("确定3",true) then
				elseif d("签到3",true) then
				end
			end
		end
		delay(1)
	end
	return true
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
					if reg(name) then
						up_hb("激活成功")
						back_pass(task_id,"ok")
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
