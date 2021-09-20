-- 积分墙对接
-- xtjfq.lua  

-- Create By TouchSpriteStudio on 16:26:24   
-- Copyright © TouchSpriteStudio . All rights reserved.
	
	
	

	
	
	
	
-- 积分墙对接
-- xiaoq.lua  

-- Create By TouchSpriteStudio on 13:15:24   
-- Copyright © TouchSpriteStudio . All rights reserved.





require("TSLib")
require("AWZ")
--require("ALS")
require("tsp")

local var={}
local jfq={}


--jfq.url = 'http://ad.masaike2018.com/ad/'
--jfq.model = ''
--jfq.adid = '1185'
--jfq.appid = '1487600417'
--jfq.keyword	= '花束'
--jfq.idfa = ''
--jfq.os_version = ''
--jfq.device = 'iPhone10,2'
--jfq.udid = ''
--jfq.callback = true
--jfq.name = '聊天话术神器'
--jfq.source = 'hbmh'
--jfq.channel = 'mz'
--jfq.bid = 'com.mei.kingkong'


function start()
	local info = getOnlineName()
--	local info = get_curren()
	print_r(info)
	jfq.idfa = strSplit(info[8],":")[2]
	jfq.os_version = strSplit(info[3],":")[2]
	jfq.device = strSplit(info[3],":")[2]
	jfq.udid = strSplit(info[4],":")[2]
end


function up(name,other)
	local url = 'http://wenfree.cn/api/Public/idfa/'
	local idfalist ={}
	idfalist.service = 'Idfa.Idfa'
	idfalist.phonename = getDeviceName()
--	idfalist.phoneimei = getIMEI()
	idfalist.phoneos = jfq.os_version
	idfalist.idfa = jfq.idfa
	idfalist.ip = get_ip()
	idfalist.account = jfq.device
	idfalist.password = var.password
	idfalist.phone = var.phone
	idfalist.appid = bid[name]['appid']
	idfalist.name = name
	idfalist.other = other
	log( post(url,idfalist) )
end

t={}
local degree = 85
t['agree']={0xff5100,"-196|-35|0xff7f00,-507|24|0xf2f2f2",degree,48,1124,707,1274}
t['skip']={0xf2f2f2,"506|-8|0xff4800,-17|-45|0xf2f2f2",degree,43,1190,713,1319}

function app(name)
--	url = "https://uri6.com/tkio/iqA3Era?idfa=__idfa__&bid=__bid__&youdao_conv_id=__sponsor_id__&subchannel=__content_id__"
--	openURL(url)
--	delay(15)
	local timeLine = os.time()
	while os.time() - timeLine < rd(15,18) do
		if active(bid[name]['appbid'],1)then
			if d("agree",true,2)then
			elseif d("skip",true,2)then
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

function main(v)
	nLog(v)
	work = v.work
	task_id = v.task_id
	bid={}
	bid[work]={}
	bid[work]['adid']=v.adid
	bid[work]['keyword']=v.keyword
	bid[work]['appbid']=v.appbid
	bid[work]['appid']=v.appid
	nLog("act")

	----------------------------------
	vpnx()
--	delay(3)
--	openURL("prefs:root=General&path=VPN")
--	delay(3)
--	click(695,459)
--	click(687,90)
	
--	click(274,770)
--	inputText('Aa112211')
--	click(253,613)
--	inputText('1')
--	click(692,88)
	delay(3)
	if vpn() then
		delay(3)
--			if awzNew() then
			if awz_next() then
				delay(4)
				start()
				if app(work) then
					up(work,'激活成功')
					back_pass(task_id,"ok")
				end
			end	
		delay(2)
	end
end





