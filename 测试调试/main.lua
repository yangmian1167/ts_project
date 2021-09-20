require("TSLib")
--require("AWZ")
require("tsp")


--writePasteboard("https://m.qgzwedptv.cn/b_APB.php?4A55D6EF=TfSKASvNqE1Jscoj")

function print_r(t)
	local print_r_cache={}
	local function sub_print_r(t,indent)
		if (print_r_cache[tostring(t)]) then
			nLog(indent.."*"..tostring(t))
		else
			print_r_cache[tostring(t)]=true
			if (type(t)=="table") then
				for pos,val in pairs(t) do
					if type(pos) == "string" then
						pos = "'"..pos.."'"
					end
					if (type(val)=="table") then
						nLog(indent.."["..pos.."] = {   --"..tostring(t))
						sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
						nLog(indent..string.rep(" ",string.len(pos)+6).."},")
					elseif (type(val)=="string") then
						nLog(indent.."["..pos.."] = ".."'"..val.."',")
					else
						nLog(indent.."["..pos.."] = "..tostring(val)..",")
					end
				end
			else
				nLog(indent..tostring(t))
			end
			mSleep(50)
		end
	end
	if (type(t)=="table") then
		nLog("{  --"..tostring(t))
		sub_print_r(t,"	")
		nLog("}")
	elseif (type(t)=="string") then
		nLog(t)
	end
end


	function logawz()
		local sz = require("sz");
		local http = require("szocket.http");
		local res, code = http.request("http://127.0.0.1:1688/cmd?fun=getallrecordnames");
		if code == 200 then
			local resJson = sz.json.decode(res);
			
			local result = resJson.result;
			nLog("the result is: " .. result);
			if tonumber(result) == 1 then
				jg = readFile('/var/mobile/iggrecords.txt')
				print_r(jg)
				return true
			elseif tonumber(result) == 200 then
				closeApp(frontAppBid())
				delay(2)
			end
		end	
	end
awzbid = "AWZ"

--按日期提取当天数据
function callbackinfo()
  url = "http://ymapi.wenfree.cn/?s=App.Bhapi.Get";
  postArr = {};
  postArr["name"] =  "百合婚恋"
  postArr["date"] =  "2021-06-12"
  taskData = post(url, postArr);
  if taskData then
	log(taskData["data"])  
    return taskData["data"]
  else
    log(taskData)
    return false
  end
end
t = {}
	
t['i']={ 0x1886ff, "-1|-9|0x007aff", 90, 668, 403, 723, 603 } --多点找色
t['删除VPN']={ 0xff3b30, "-63|1|0xff3b30", 90, 299, 550, 453, 606 } --多点找色
t['删除VPN_删除']={ 0x7eb8f7, "-266|2|0x007aff", 90, 198, 721, 553, 769 } --多点找色
t['添加VPN配置']={ 0x007aff, "-58|3|0x007aff,129|13|0x3093ff", 90, 25, 197, 278, 285 } --多点找色
t['tips好']={ 0xb1d0f4, "19|29|0x60a9f9,25|1|0xc8dcf3,-4|30|0xaacdf4", 90, 343, 682, 407, 885  } --多点找色
t['tips取消']={ 0x007aff, "283|5|0x007aff,98|-249|0x000000,221|-259|0x000000", 90, 189, 455, 560, 854 } --多点找色
function ios13配置VPN()
	local vpnname = "cradc"
	local server = "a05.cndtip.com"
	local password  = "cradc"
	local miyao = "888888"
	openURL("prefs:root=General&path=VPN")
	delay(3)
	while true do
		if d("tips好",true) then
		elseif d("tips取消",true) then
		elseif d("i",true) then
		elseif d("删除VPN",true) then
		elseif d("删除VPN_删除",true) then
		elseif d("添加VPN配置",true) then
			delay(2)
			click(632,315)
			click(330,493)
			click(83,139)
			delay(2)
			click(248,469)
			inputword(vpnname)
			click(252,564)
			inputword("a05")
			click(500,564)
			inputText(".cndtip.com")
--			inputword(server)
--			click(490,1289)
			click(253,657)
			inputword(vpnname)
			click(244,809)
			input[1](password)
			click(256,632)
			input[1](miyao)
			click(682,138)
			return true
		end
		delay(1)
	end
end
--for i = 1,2 do
--ios13配置VPN()
--end

function get_ip()
	local http = require("szocket.http")
	local res, code = http.request("http://pv.sohu.com/cityjson?ie=utf-8",30);
	if code ~= nil then
		local i,j = string.find(res, '%d+%.%d+%.%d+%.%d+')
		return string.sub(res,i,j)
	end
end
--ip = get_ip()

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

--awzstart()
--nLog(ip)
--nLog(idfa)
--inputText("周一一")
--openURL("http://yjy.yylxjt.com/sx/me/#/download")



--toast("1111111111111",1)

t['qiang']={ 0xfe2c79, "-47|-83|0xfef7dc,-7|37|0xf8e8c6,58|-108|0xff0f60,-14|27|0xf8e9c8", 90, 302, 634, 444, 825 } --多点找色

while true do
	if d("qiang",true ) then
	end	
end	













	