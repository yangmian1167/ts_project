require("TSLib")
awzbid = 'AWZ'
--解锁屏幕
function locks()
	local flag = deviceIsLock();
	if flag == 0 then
	--	log("未锁定");
	else
		unlockDevice(); --解锁屏幕
	end
end
--启动应用
function activeawz(app,t)
	local t = t or 0.5
	locks()
	local bid = frontAppBid();
	if bid ~= app then
		nLog(app.."，准备启动")
		runApp(app)
		mSleep(t*1000)
		return true
	end
end
--新机
function awz()
	openURL("IGG://cmd/newrecord");
	mSleep(3000)
	logTxt = '/var/mobile/iggresult.txt'
	out_time = os.time()
	while os.time()-out_time <= 10 do
		if activeawz(awzbid,2)then
		elseif file_exists(logTxt)then
			local new = readFile(logTxt)[1]
			if new == "1" then
				return true
			elseif new == "3" then
				toast('IP-->重复请注意',1)
				return true
			elseif new == '2' then
				toast('一键新机中',2)
			end
			mSleep(2000)
		end
		mSleep(1000* 3)
	end
end
--生效下一条
function awz_next()
	function nextrecord()
		local sz = require("sz");
		local http = require("szocket.http");
		local res, code = http.request("http://127.0.0.1:1688/cmd?fun=nextrecord");
		if code == 200 then
			local resJson = sz.json.decode(res);
			local result = resJson.result;
			nLog("the result is: " .. result);
			if tonumber(result) == 1 then
				return true
			elseif tonumber(result) == 200 then
				closeApp(frontAppBid())
				delay(2)
			end
		end	
	end
	
	out_time = os.time()
	while os.time()-out_time <= 10 do
		if activeawz(awzbid,2)then
		elseif nextrecord()then
			return true
		end
		mSleep(1000* 2)
	end
end

function renameCurrentRecord(name)
	local sz = require("sz");
	local http = require("szocket.http");
	local res, code = http.request("http://127.0.0.1:1688/cmd?fun=renamecurrentrecord&name="..name);
	if code == 200 then
		local resJson = sz.json.decode(res);
		local result = resJson.result;
		--nLog("the result is: " .. result);
		return true
	end	
end
--修改当前记录名
function reName(newName)
	timeLine = os.time()
	outTime = 60 * 0.5
	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		elseif renameCurrentRecord(newName)then
			return true
		end
		mSleep(1000)
	end
	nLog('重命令超时')
end

function newRecord()
	local sz = require("sz");
	local http = require("szocket.http");
	local res, code = http.request("http://127.0.0.1:1688/cmd?fun=newrecord");
	if code == 200 then
		local resJson = sz.json.decode(res);
		local result = resJson.result;
		nLog("the result is: " .. result);
		if result == 3 then
			--//IP地址重复
-- 			dialog('ip 地址重复', 3)
			return true
		elseif result == 1 then
			return true
		elseif result == 2 then
			toast('正在一键新机ing',1)
		end
	end	
end
--新机
function awzNew()
	timeLine = os.time()
	outTime = 60 * 0.5
	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		elseif newRecord() then
			return true
		end
		mSleep(1000)
	end
	nLog('新机超时')
end
--点击新机
if not(t) then
    t = {}
end
t['awz-一键新机横']={0xffffff, "-9|-110|0xffffff,0|-187|0x6f7179,-1|73|0x6f7179,-28|-65|0x6f7179", 90, 577, 445, 654, 724}
t['awz-一键新机竖']={0xffffff, "112|-4|0xffffff,189|0|0x6f7179,-72|0|0x6f7179,64|-28|0x6f7179", 90, 19, 585, 301, 653}
t['通用一键新机']={ 0x6f7179, "-201|-26|0x6f7179,11|-30|0x6f7179", 90, 28, 583, 298, 657 } --多点找色
function clickNew()
    closeApp(awzbid,0)
    delay(1)
	local timeLine = os.time()
	local outTime = 60 * 0.5
	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		elseif d("通用一键新机",true) or d("awz-一键新机横",true) or d("awz-一键新机竖",true) then
			mSleep(10000)
			return true
		end
		mSleep(1000)
	end
	nLog('新机超时')
end

function setCurrentRecordLocation(location)
	local sz = require("sz");
	local http = require("szocket.http");
	local res, code = http.request("http://127.0.0.1:1688/cmd?fun=setcurrentrecordlocation&location="..location);
	if code == 200 then
		local resJson = sz.json.decode(res);
		local result = resJson.result;
		--toast("the result is: " .. result, 2);
		if tonumber(result) == 1 then
			return true
		end
	end	
end

function NewPlace(location)
	timeLine = os.time()
	outTime = 60 * 0.5

	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		elseif setCurrentRecordLocation(location) then
			return true
		end
		mSleep(1000)
	end
	nLog('设置超时')
end

--("116.7361382365_39.8887921413_北京老胡同")
function getAll()
	local sz = require("sz");
	local http = require("szocket.http");
	local res, code = http.request("http://127.0.0.1:1688/cmd?fun=getallrecordnames");
	if code == 200 then
		local resJson = sz.json.decode(res);
		local result = resJson.result;
		--toast("the result is: " .. result, 2);
		if tonumber(result) == 1 then
			return #readFile('/var/mobile/iggrecords.txt')
		end
	end	
end

function getAllmun()
	timeLine = os.time()
	outTime = 60 * 0.5
	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		else
			return getAll()
		end
		mSleep(1000)
	end
	nLog('设置超时')
end

----获取当前名
function getOnlineName()
	function getName()
		local sz = require("sz");
		local http = require("szocket.http");
		local res, code = http.request("http://127.0.0.1:1688/cmd?fun=getcurrentrecordparam");
		if code == 200 then
			local resJson = sz.json.decode(res);
			local result = resJson.result;
			--nLog("the result is: " .. result);
			if tonumber(result) == 1 then
				jg = readFile('/var/mobile/iggparams.txt')
		
				nLog(jg[1])
				awz_online_name = strSplit(jg[1],':')
				awz_online_name[2] = awz_online_name[2] 
				nLog(awz_online_name[2])
				return awz_online_name[2]
			end
		end	
	end
	timeLine = os.time()
	outTime = 60 * 0.5
	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		else
			return getName()
		end
		mSleep(1000)
	end
	nLog('设置超时')
end

-----获取当前设备参数
function get_curren()
	function getName()
		local sz = require("sz");
		local http = require("szocket.http");
		local res, code = http.request("http://127.0.0.1:1688/cmd?fun=getcurrentrecordparam");
		if code == 200 then
			local resJson = sz.json.decode(res);
			local result = resJson.result;
			--nLog("the result is: " .. result);
			if tonumber(result) == 1 then
				jg = readFile('/var/mobile/iggparams.txt')
				nLog(jg)
				return jg
			end
		end	
	end
	timeLine = os.time()
	outTime = 60 * 0.5
	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		else
			return getName()
		end
		mSleep(1000)
	end
	nLog('设置超时')
end

function awzstart() --获取设备需要的参数
--	local info = getOnlineName()
	local info = get_curren()
	print_r(info)
	if info ~= nil then
		idfa = strSplit(info[8],":")[2] -- idfa
		os_version = strSplit(info[3],":")[2] --系统版本
		device = readFile(userPath().."/lua/model.txt")[1] --机型(触动手动配置)
		udid = strSplit(info[4],":")[2] --udid
		return true
	end
end

function getTrueName_awz()
	local awz_name
	local awz_idfa
	function getTrueName()
		local sz = require("sz");
		local http = require("szocket.http");
		local res, code = http.request("http://127.0.0.1:1688/cmd?fun=getcurrentrecordparam");
		
		nLog(res)
		nLog(code)
		
		
		if code == 200 then
			local resJson = sz.json.decode(res);
			local result = resJson.result;
			--nLog("the result is: " .. result);
			if tonumber(result) == 1 then
				jg = readFile('/var/mobile/iggparams.txt')
				return jg[1],jg[4]		--name,idfa
			end
		end	
	end

	timeLine = os.time()
	outTime = 60 * 0.5
	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		else
			awz_name,awz_idfa = getTrueName()
			if awz_name and awz_idfa then
				nLog("awz_name->"..awz_name)
				nLog("awz_idfa->"..awz_idfa)
				return awz_name,awz_idfa
			else
				dialog("没有取到参数",2)
				closeApp(awzbid)
				mSleep(1000)
			end
		end
		mSleep(1000)
	end
end


--获取存储列表
function get_allrecord()
	function getName()
		local sz = require("sz");
		local http = require("szocket.http");
		local res, code = http.request("http://127.0.0.1:1688/cmd?fun=getallrecordnames");
		if code == 200 then
			local resJson = sz.json.decode(res);
			local result = resJson.result;
			--nLog("the result is: " .. result);
			if tonumber(result) == 1 then
				jg = readFile('/var/mobile/iggrecords.txt')
				log(jg)
				return jg
			end
		end	
	end
	timeLine = os.time()
	outTime = 60 * 0.5
	while (os.time()-timeLine < outTime) do
		if activeawz(awzbid,3)then
		else
			return getName()
		end
		mSleep(1000)
	end
	nLog('设置超时')
end
--生效指定记录
function get_allrecord_get(names)
	local sz = require("sz");
	local http = require("szocket.http");
	for k, v in pairs(get_allrecord()) do
		if v == times then
			local res, code = http.request("http://127.0.0.1:1688/cmd?fun=activerecord&record="..v);
			return true
		end	
	end
end


nLog('AWZ 加截完成')
















