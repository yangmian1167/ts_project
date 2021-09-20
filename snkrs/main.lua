require("TSLib")
require("tsp")
require("nameStr")
--require("AWZ")


var = {}
var.appbid = "com.nike.onenikecommerce";
var.phone = ''
var.password = ''
t={}

sys = {
	clear_bid = (function(bid)
		closeApp(bid)
		delay(1)
		os.execute("rm -rf "..(appDataPath(bid)).."/Documents/*") --Documents
		os.execute("rm -rf "..(appDataPath(bid)).."/Library/*") --Library
		os.execute("rm -rf "..(appDataPath(bid)).."/tmp/*") --tmp
		clearPasteboard()
		--[[
		local path = _G.const.cur_resDir
		os.execute(
			table.concat(
				{
					string.format("mkdir -p %s/keychain", path),
					'killall -SIGSTOP SpringBoard',
					"cp -f -r /private/var/Keychains/keychain-2.db " .. path .. "/keychain/keychain-2.db",
					"cp -f -r /private/var/Keychains/keychain-2.db-shm " .. path .. "/keychain/keychain-2.db-shm",
					"cp -f -r /private/var/Keychains/keychain-2.db-wal " .. path .. "/keychain/keychain-2.db-wal",
					'killall -SIGCONT SpringBoard',
				},
				'\n'
			)
		)
		
		]]
		clearAllKeyChains()
		clearIDFAV() 
		--clearCookies()
		delay(2)
		return true
	end)
}

--function start()
--	local info = getOnlineName()
----	local info = get_curren()
--	print_r(info)
--	jfq.idfa = strSplit(info[8],":")[2]
--	jfq.os_version = strSplit(info[3],":")[2]
--	jfq.device = strSplit(info[3],":")[2]
--	jfq.udid = strSplit(info[4],":")[2]
--end

function up(name,other)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or getDeviceName()
--	idfalist.phoneimei = phoneimei or '12312321321312'
--	idfalist.phoneos = phoneos or jfq.os_version
	idfalist.name = name
	idfalist.idfa = var.phone 
	idfalist.ip = ip or get_ip() or '192.168.1.1'
	idfalist.account = account or ''
	idfalist.password = password 
	idfalist.phone = var.phone 
	idfalist.other = other
	return post(url,idfalist)
end

function _vCode_fz() --飞猪新
			
	local User = '9a27326e-b377-4b96-a05f-acbc3389c7fd'
	local Pass = 'shuai888'
	local PID = '5672'
    local token,number = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmM3NTYzMThjNGVmMjY1ZGVlNTgzZmEiLCJhcGlBY2NvdW50IjoiOWEyNzMyNmUtYjM3Ny00Yjk2LWEwNWYtYWNiYzMzODljN2ZkIiwiaWF0IjoxNjEwMTY2Mjc0fQ.S8RTZVdNMP12yeOI16FvbJd3jjhuYMeIPdi0QVowTqY",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				toast("获取token\n"..i.."次共5次")
                mSleep(1500)
				local lx_url = 'http://hainanhongyu.com/api/yhdl?password='..Pass..'&apiAccount='..User
				log(lx_url)
                RetStr = get(lx_url)
				local sz = require('sz')
				local cjson = sz.json
--				RetStr = cjson.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.result == '成功' then
						token = RetStr.token
						log('token='..token,true)
						break
					end
				else
					log(RetStr)
				end
			end
			return RetStr;
        end), 
		getPhone=(function()
				local RetStr=""
--				local url___ = "http://103.91.211.167/api/getPhone?sid="..PID.."&token="..token.. "&operator=exclude4"
				local url___ = "http://hainanhongyu.com/api/yhqh_s?token="..token.."&id="..PID..'&cardType=1'..'&pingtaika=1'
				log(url___)
				RetStr = get(url___)
				local sz = require('sz')
				local cjson = sz.json
--				RetStr = cjson.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.result == '成功' then
						number = RetStr.number
						log(number)
					end
					local phone_title = (string.sub(number,1,3))
	--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
	--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
	--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
					local blackPhone = {}
					for k,v in ipairs(blackPhone) do
						if phone_title == v then
							local lx_url =	'http://hainanhongyu.com/api/yhlh?token='..token..'&number='..number..'&id='..PID
							get(lx_url);
							log("拉黑->"..number)
							delay(3)
							return false
						end
					end
					return number
				end
		end),
		getMessage=(function()
			local Msg
            for i=1,25,1 do
				mSleep(3000)
				local url___ = "http://hainanhongyu.com/api/yhjm?token="..token.."&id="..PID.."&number="..number..'&apiAccount='..User
				log(url___)
				RetStr = get(url___)	
				log(RetStr)
				if RetStr then
					local sz = require('sz')
					local cjson = sz.json
--					RetStr = cjson.decode(RetStr)
					if  RetStr.result == '成功' then
						Msg = RetStr.verificationCode
--						local i,j = string.find(Msg,"%d+")
--						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
            end
            return false
        end),
	   
        addBlack=(function()
			local lx_url =	'http://hainanhongyu.com/api/yhlh?token='..token..'&number='..number..'&id='..PID
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
dxcode = _vCode_fz()













t['加入']={ 0x111111, "-29|7|0x111111,-31|7|0x7f7f7f,-97|-29|0xffffff,-307|-2|0xfdfdfd,-183|45|0xffffff", 90, 18, 1065, 594, 1206 } --多点找色
t['注册界面and继续']={ 0xffffff, "-7|2|0xffffff,-287|-21|0x000000,297|32|0x000000,312|-40|0xffffff", 90, 24, 493, 727, 1176 } --多点找色
t['注册界面and继续_发送验证码']={ 0x111111, "-38|-1|0x111111,-116|-27|0xe5e5e5,44|19|0xe5e5e5,46|-28|0xe5e5e5", 90, 477, 336, 713, 472 } --多点找色

t['键盘_完成']={ 0x007aff, "14|-7|0x007aff,-36|-6|0x007aff,-13|-9|0x007aff", 90, 551, 712, 727, 882 } --多点找色

t['tips_操作失败']={ 0x111111, "-18|0|0x595959,-224|-258|0x969696,101|-172|0x757575,-120|-122|0x757575", 90, 150, 522, 617, 837 } --多点找色



function reg()
	local timeline = os.time()
	local outTimes = 60 * 2
	local 手机号 = true
	local 短信 = false
	local 提交 = false
	var.password  = "AaDd112211"
	local fix_info = false
	
	while os.time()-timeline < outTimes do
		if active(var.appbid,5) then
			if d('注册界面and继续') or d('键盘_完成') then
				if 手机号 then
					var.phone = dxcode.getPhone()
					if #var.phone == 11 then
						delay(2)
						click(185,542)
--						input[3](var.phone)
						input[3](var.phone)
						手机号 = false
						短信 = true
					end
				elseif 短信 then	
					if d('注册界面and继续_发送验证码',true) then
					else	
						var.sms = dxcode.getMessage()
						if #var.sms == 6 then
							click(125,646)
							input[3](var.sms)
--							up('点击注册')
							短信 = false
							提交 = true
							
--						else
--							return false
						end	
					end
				elseif 提交 then
					if d('注册界面and继续',true) then
						up('nike','提交注册')
						toast('注册结束',1)
						提交 = false
						return true
					end
				end
			else
				if d('加入',true) then
				elseif	d('tips_操作失败',true) then
				end
			end	
		end
		delay(1)
	end
end



t['填资料界面and加入']={ 0xffffff, "-8|0|0x0d0d0d,-18|-10|0x5e5e5e,-269|-36|0x000000,329|26|0x000000", 90, 9, 980, 743, 1332} --多点找色
t['填资料界面']={ 0xa5a5a5, "-397|-32|0xb0b0b0,-384|-48|0xe0e0e0,22|-48|0xc4c4c4,40|-42|0x414141", 90, 50, 86, 658, 311 } --多点找色
t['日期界面']={ 0x007aff, "-100|-1|0x007aff,-662|5|0x007aff,-629|3|0x007aff", 90, 5, 821, 729, 890 } --多点找色
t['输入邮件界面']={ 0xdadada, "-392|-48|0x949494,0|-48|0xb9b9b9,11|-38|0xcccccc,-398|-9|0xc0c0c0", 90, 116, 95, 615, 303 } --多点找色
t['电子邮件保存界面']={ 0xffffff, "-324|-27|0x000000,279|11|0x000000,276|-25|0x000000", 90, 33, 585, 717, 719 } --多点找色
t['主界面']={ 0xcccccc, "-7|-16|0xe9e9e9,-377|1|0xe5e5e5,-558|2|0xafafaf,-588|-3|0xffffff,-584|-10|0xcfcfcf,-562|5|0x111111", 90, 50, 1244, 700, 1310 } --多点找色
function 填资料()
	local timeline = os.time()
	local outTimes = 60 * 2
	local 填资料姓名密码 = true
	local 日期性别 = true
	local 邮箱 = true
	password = 'Aa112211'
	while os.time()-timeline < outTimes do
		if active(var.appbid,5) then
			if d('填资料界面') or d('键盘_完成') then
				if 填资料姓名密码 then
					click(131,511)
					input[1](xin[math.random(1,#xin)])
					delay(2)
					click(462,429)
					input[1](ming[math.random(1,#ming)])
					click(98,543)
					input[1](password)
					填资料姓名密码 = false
					日期性别 = true
					
				elseif 日期性别 then
					if d('日期界面') then
						for i = 1 , math.random(3,5) do
							moveTo(223,994,227,1151)
							mSleep(500)
						end						
						for i = 1 , math.random(3,5) do
							moveTo(364,1004,374,1128)
							mSleep(500)
						end						
						for i = 1 , math.random(3,5) do
							moveTo(535,1000,528,1123)
							mSleep(500)
						end
						delay(2)
						d('日期界面',true)
						--性别
						click(313,773)
						日期性别 = false
					else
						click(117,611)
					end
				end	
			elseif d('输入邮件界面') or d('键盘_完成') then
				if 邮箱 then
					delay(2)
					click(131,493)
					input[1](myRand(5,9))
					邮箱 = false
				end
				d('电子邮件保存界面',true)
			elseif d('填资料界面and加入',true) then
			elseif d('主界面') then
				up('nike','注册完成')
				toast('注册完成',1)
				return true
			end	
		end
		delay(1)
	end
end

function main()
	vpnx()
	delay(3)
	if vpn() then
		delay(3)	
		sys.clear_bid(var.appbid)
		if reg() then
			填资料()
		end

	end
end

while (true) do
	local ret,errMessage = pcall(main)
	if ret then
	else
		nLog(errMessage)
--		sys.alert(errMessage, 3)
		delay(5)
	end
end
ceshi
