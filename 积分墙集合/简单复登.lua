

require("TSLib")
require("AWZ")
--require("ALS")
require("tsp")

local var={}
local jfq={}


function start()
	local info = getOnlineName()
--	local info = get_curren()
	print_r(info)
	jfq.idfa = strSplit(info[8],":")[2]
	jfq.os_version = strSplit(info[3],":")[2]
	jfq.device = strSplit(info[3],":")[2]
	jfq.udid = strSplit(info[4],":")[2]
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

t={}
local degree = 85
t['agree']={0xff5100,"-196|-35|0xff7f00,-507|24|0xf2f2f2",degree,48,1124,707,1274}
t['skip']={0xf2f2f2,"506|-8|0xff4800,-17|-45|0xf2f2f2",degree,43,1190,713,1319}

function appagain(name)
--	url = "https://uri6.com/tkio/iqA3Era?idfa=__idfa__&bid=__bid__&youdao_conv_id=__sponsor_id__&subchannel=__content_id__"
--	openURL(url)
--	delay(15)
	local timeLine = os.time()
	while os.time() - timeLine < rd(30,35) do
		if active(bid[name]['appbid'],1)then
			if d("agree",true,2)then
			elseif d("skip",true,2)then
			end
		end
		delay(1)
	end
	return true
end
--任务返回完成
function back_pass(task_id,success)
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.backpass'
	local postArr = {}
	postArr.task_id = task_id
	postArr.success = success
	nLog( post(url,postArr) )
end

--按日期提取指定日期数据
function callbackinfo()
  url = "http://ymapi.wenfree.cn/?s=App.Bhapi.Get";
  postArr = {};
  postArr["name"] =  work
  postArr["date"] =  bid[work]['keyword']
  taskData = post(url, postArr);
  if taskData then
	log(taskData["data"])  
    return taskData["data"]
  else
    log(taskData)
    return false
  end
end
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
	delay(3)
	if vpn() then
		delay(3)
		ip = get_ip()
		if awz_next() then
			if	awzstart() then
				if appagain(work) then
--						up('复登成功')
						back_pass(task_id,"ok")
				end
			end
		end
	end
end





