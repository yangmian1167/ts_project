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
	idfalist.service = 'idfa.idfa'
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

t['tips同意']={ 0xffffff, "-99|-21|0x1288f0,51|14|0x1288f0", 90, 386, 871, 668, 979 } --多点找色
t['首页']={ 0xffffff, "-17|-10|0x1288f0,2|28|0x2d96f2", 90, 43, 1245, 110, 1333 } --多点找色
t['注册登录按钮']={ 0x1288f0, "-431|-63|0x1288f0,3|-64|0x1288f0", 90, 94, 633, 635, 776 } --多点找色
t['重新获取']={ 0x1388ef, "-45|9|0x208ae6,-15|5|0x1288f0", 90, 505, 546, 653, 582 } --多点找色
t['打钩']={ 0x2481d2, "-5|-2|0xffffff,-10|-12|0x2481d2", 90, 94, 803, 136, 835 } --多点找色
t['消息中心_完成']={ 0x2190fb, "-23|-1|0xffffff,-42|0|0x2190fb,-7|17|0x2190fb", 90, 22, 258, 96, 555 } --多点找色
t['返回箭头']={ 0xd6d6d6, "0|-35|0xdedede,-5|-5|0x989898", 90, 35, 61, 71, 106 } --多点找色
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
			if d("注册登录按钮") then
				if 取号 then
					phone = dxcode.getPhone()
					number = phone
					if phone ~= nil or phone ~= '' then
						click(323,578)
						delay(2)
						inputword(number)
						取号 = false
						短信 = true	
					end
					delay(2)
				elseif d("重新获取") and 短信 then
					yzm = dxcode.getMessage()
						log(yzm)
						if yzm ~= nil or yzm ~= '' then
							click(167,562)
							delay(2.8)
							inputword(yzm)			
							提交 = true
							短信 = false
						end
				elseif not d("打钩") then
					click(119,826)
				elseif d("注册登录按钮",true) then
				end	
			elseif d("首页") then
				click(598,92)
			elseif d("tips同意",true) then
			elseif d("消息中心_完成") then
				up("注册成功")
				return true
			end
		end
		delay(1)
	end
	if d("返回箭头") and 提交 then
		up("注册成功<")
		return true
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
					if openchrome("http://yjy.yylxjt.com/sx/me/#/download") then
						delay(15)
						if reg(name) then
							back_pass(task_id,"ok")
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
--		dxcode = _vCode_df()
		dxcode = _vCode_lh()
		nLog("act")
		callbackapi(work)
	
end
--]]
