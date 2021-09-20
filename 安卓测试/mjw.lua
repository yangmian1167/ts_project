require("TSLib")
require("aztsp")
local mjw_bid = "com.yztc.studio.plugin"
--一键新机
function mjw_n()
	local time_in = os.time()
	local time_out = 60
	while os.time() - time_in < time_out do
		if active(mjw_bid,5) then
			local res = httpGet("http://127.0.0.1:8181/api?reqCode=7001")
			local ts = require("ts")
			local res = ts.json.decode(res)
			if res.RespCode == "0" then
				log(res.Data.TaskId)
				mjw_TaskId = res.Data.TaskId
				return mjw_TaskId
			end	
		end	
	end
end
--一键新机并获取备份名
function mjw_new()
	local time_in = os.time()
	local time_out = 60
	if mjw_n() then
		while os.time() - time_in < time_out do
			local res = httpGet("http://127.0.0.1:8181/api?reqCode=7011&taskId="..mjw_TaskId)
			local ts = require("ts")
			local res = ts.json.decode(res)
			if res.RespCode == "0" then
--				log(res.Data.ConfigDir)
				mjw_name = strSplit(res.Data.ConfigDir,"env/")[2]
				log("新机成功,备份名："..mjw_name)
				return mjw_name
			end	
		end	
	end
end
--还原指定备份
function mjw_r(name)
	local time_in = os.time()
	local time_out = 60
	while os.time() - time_in < time_out do
		if active(mjw_bid,5) then
			local res = httpGet("http://127.0.0.1:8181/api?reqCode=7002&configDir=/sdcard/yztc/studioplugin/wipeKing/env/"..name)
			local ts = require("ts")
			local res = ts.json.decode(res)
			if res.RespCode == "0" then	
				log("正在还原..")	
				log(res.Data.TaskId)	
				mjw_TaskId = res.Data.TaskId
				return mjw_TaskId
			end	
		end	
	end
end
--还原指定备份判断状态
function mjw_ret(name)
	local time_in = os.time()
	local time_out = 60
	if mjw_r(name) then
		while os.time() - time_in < time_out do
			local res = httpGet("http://127.0.0.1:8181/api?reqCode=7011&taskId="..mjw_TaskId)
			local ts = require("ts")
			local res = ts.json.decode(res)
			if res.RespCode == "0" then
				log(res.Message)
				return true
			end	
		end	
	end
end	
--一键备份
function mjw_s(name)
	local time_in = os.time()
	local time_out = 60
	while os.time() - time_in < time_out do
		if active(mjw_bid,5) then
			local res = httpGet("http://127.0.0.1:8181/api?reqCode=7003")
			local ts = require("ts")
			local res = ts.json.decode(res)
			if res.RespCode == "0" then		
				log(res.Message)	
				mjw_TaskId = res.Data.TaskId
				return true
			end	
		end	
	end
end

--一键备份判断状态
function mjw_save()
	local time_in = os.time()
	local time_out = 60
	if mjw_s() then
		while os.time() - time_in < time_out do
			local res = httpGet("http://127.0.0.1:8181/api?reqCode=7011&taskId="..mjw_TaskId)
			local ts = require("ts")
			local res = ts.json.decode(res)
			if res.RespCode == "0" then
				log(res.Message)
				return true
			end	
		end	
	end
end	

--获取当前参数
function mjw_data(name)
	local new_data = readFile("sdcard/yztc/studioplugin/wipeKing/env/"..name.."/deviceInfo.xml")[3]
	local data = {
	 {"mjw_Imei","&quot;Imei&quot;:&quot;"},
	 {"mjw_Model","&quot;Model&quot;:&quot;"},
	 {"mjw_AndroidId","&quot;AndroidId&quot;:&quot;"},
	}
	for k ,v in ipairs(data) do
		res =strSplit(new_data,v[2])[2]
		res1 =strSplit(res,"&")[1]
--		log(res1)
		if k == 1 then
			Imei = res1
			log(Imei)
		elseif k == 2 then
			Model = res1
			log(Model)
		elseif k == 3 then
			AndroidId = res1
			log(AndroidId)
		end	
	end
--	log (data)
end	
mjw_new()
mjw_save()
mjw_data(mjw_name)
--new_data = readFile("sdcard/yztc/studioplugin/wipeKing/env/2021-07/26/_2021-07-26_15:09:49/deviceInfo.xml")[3]
----print_r(new_data)
----print_r(new_data.AndroidId)
--new_data=strSplit(new_data,"&quot;AndroidId&quot;:&quot;")[2]
--new_data=strSplit(new_data,"&")[1]
--print_r(new_data)

--mjw_new()
--mjw_save()
--mjw_ret("2021-07/26/_2021-07-26_15:09:49")










































