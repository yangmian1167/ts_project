require("TSLib")
require("aztsp")



function post(url,arr)
	local ts = require("ts")
	--format 参数仅支持 Android ts.so v1.1.4 及其以上版本
	--tstab = "tstab"此参数不能修改
	tab = {tstab = "tstab",header_send = {typeget = "android"} , body_send = arr ,format ="utf-8" }
	code,header_resp, body_resp = ts.httpPost(url,tab)
	if body_resp and body_resp ~= "" then
		body_resp = ts.json.decode(body_resp)
		log(body_resp)
	else
		log("请求失败")	
	end	
end

function up()
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local postdate = {}
	postdate.name = 'ceshi0000000011'
	postdate.idfa = "ceshi000012345632"
	postdate.password = "ceshi0000123456"
	postdate.phone = "ceshi0000123456"
	postdate.other = "ceshi0000123456"
	log(post(url,postdate))
end

--领取任务
function get_task()
	local sz = require("sz")
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.gettask'
	local postArr = {}
	postArr.phonename = phonename or getDeviceName()
	postArr.imei = phoneimei or sz.system.serialnumber()
	local taskData = post(url,postArr)
	
	if taskData ~= nil then
		print_r(taskData)
		if taskData.data == "新增手机" or taskData.data == "暂无任务" then
			nLog(taskData.data)
			delay(30)
			return false
		else
			return taskData.data
		end
	end
end

if not(t) then
    t = {}
end
t['切换IP']={ 0x0000ff, "-173|-26|0x0000ff,7|90|0xff0000,-172|56|0xff0000", 90, 236, 910, 485, 1075 } --多点找色
function gzip()
	local time_in = os.time()
	local time_out = 60
	while os.time() - time_in < time_out do
		if active("com.deruhai.guangzi",5) then
			if d("切换IP",true) then
				delay(3)
				if get_ip() then
					return true
				end	
			end	
		end	
	end	
end	
function get_ip()
	local res = httpGet("http://pv.sohu.com/cityjson?ie=utf-8",30);
	log(res)
	if res then
		local i,j = string.find(res, '%d+%.%d+%.%d+%.%d+')
		return string.sub(res,i,j)
	end
end
ip = get_ip()
log (ip)


