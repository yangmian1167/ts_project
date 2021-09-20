
require("TSLib")
require("tsp")

--get函数
--function get_lx(url)
--	local sz = require("sz")
--	local http = require("szocket.http")
--	local res, code = http.request(url);
--	delay(2)
--	if code == 200 then
--		return res
--	end
--end
function get_lx(url)
	local sz = require("sz")	
	local res = httpGet(url);
--	log(res)
	if res~= nil or res~= '' then
		return res
	end
end

--服务器对接取号
function _Server_get()
	phone_name = getDeviceName()
	phone_imei = getDeviceID()
	log(phone_name)
	log(phone_imei)
	return{
		login=(function()
			return	
		end),
		getPhone = (function()
				RetStr = get_lx('http://sms.wenfree.cn/public/?service=App.Sms.GetPhone'.."&imei="..phone_imei.."&phonename="..phone_name)
				log(RetStr)
				if RetStr then
					local sz = require('sz')
					local cjson = sz.json
					RetStr = cjson.decode(RetStr)
					log(RetStr)
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						number = RetStr.data.phone
						log(number)
						local phone_title = (string.sub(number,1,3))
--						local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--						local blackPhone = {'144','141','142','143','144','145','146','147'}
--						local blackPhone = {}
--						for k,v in ipairs(blackPhone) do
--							if phone_title == v then
--								local lx_url =	'http://api.cafebay.cn/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
--								get_lx(lx_url);
--								log("拉黑->"..number)
--								return false
--							end
--						end
					end
				else
					log(RetStr)
				end
				mSleep(3000)
				return number
		end),
		 getMessage=(function()
			local Msg
            for i=1,25,1 do
				mSleep(3000)
				RetStr = get_lx("http://sms.wenfree.cn/public/?service=App.Sms.GetMessage".."&imei="..phone_imei.."&phonename="..phone_name)
				if RetStr then
					local sz = require('sz')
					local cjson = sz.json
					RetStr = cjson.decode(RetStr)
					log(RetStr);
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						Msg = RetStr.data.sms
						if type(tonumber(Msg))== "number" then log(Msg); return Msg 
						else
							Msg = RetStr.data.sms
							log(Msg)
							local i,j = string.find(Msg,"%d+")
							Msg = string.sub(Msg,i,j)
							if type(tonumber(Msg))== "number" then log(Msg); return Msg end
						end
					end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
				mSleep(3000)
            end
            return false
        end),
	
	
	}
	
end

--服务器对接取号
function _Server_newget()
	phone_name = getDeviceName()
	phone_imei = getDeviceID()
	log(phone_name)
	log(phone_imei)
	return{
		login=(function()
			return	
		end),
		getPhone = (function()
				RetStr = get_lx('http://sms.wenfree.cn/public/?s=App.SmsNew.GetPhone'.."&imei="..phone_imei.."&phonename="..phone_name)
				log(RetStr)
				if RetStr then
					local sz = require('sz')
					local cjson = sz.json
					RetStr = cjson.decode(RetStr)
					log(RetStr)
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						number = RetStr.data.phone
						log(number)
						local phone_title = (string.sub(number,1,3))
--						local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--						local blackPhone = {'144','141','142','143','144','145','146','147'}
--						local blackPhone = {}
--						for k,v in ipairs(blackPhone) do
--							if phone_title == v then
--								local lx_url =	'http://api.cafebay.cn/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
--								get_lx(lx_url);
--								log("拉黑->"..number)
--								return false
--							end
--						end
					end
				else
					log(RetStr)
				end
				mSleep(3000)
				return number
		end),
		getPhoneagain = (function()
				RetStr = get_lx('http://sms.wenfree.cn/public/?s=App.SmsNew.GetPhone'.."&imei="..phone_imei.."&phonename="..phone_name.."&phone="..phone)
				log(RetStr)
				if RetStr then
					local sz = require('sz')
					local cjson = sz.json
					RetStr = cjson.decode(RetStr)
					log(RetStr)
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						number = RetStr.data.phone
						log(number)
						local phone_title = (string.sub(number,1,3))
--						local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--						local blackPhone = {'144','141','142','143','144','145','146','147'}
--						local blackPhone = {}
--						for k,v in ipairs(blackPhone) do
--							if phone_title == v then
--								local lx_url =	'http://api.cafebay.cn/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
--								get_lx(lx_url);
--								log("拉黑->"..number)
--								return false
--							end
--						end
					end
				else
					log(RetStr)
				end
				mSleep(3000)
				return number
		end),
		 getMessage=(function()
			local Msg
            for i=1,25,1 do
				mSleep(3000)
				RetStr = get_lx("http://sms.wenfree.cn/public/?s=App.SmsNew.getMessage".."&imei="..phone_imei.."&phonename="..phone_name)
				if RetStr then
					local sz = require('sz')
					local cjson = sz.json
					RetStr = cjson.decode(RetStr)
					log(RetStr);
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						Msg = RetStr.data.sms
						if type(tonumber(Msg))== "number" then log(Msg); return Msg 
						else
							Msg = RetStr.data.sms
							log(Msg)
							local i,j = string.find(Msg,"%d+")
							Msg = string.sub(Msg,i,j)
							if type(tonumber(Msg))== "number" then log(Msg); return Msg end
						end
					end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
				mSleep(3000)
            end
            return false
        end),
	
	
	}
	
end

function _vCode_df() --德芙
			
	local User = '18129871167'
	local Pass = 'yangmian121'
	local PID = bid[work]["adid"]
--	local PID = "10480----48Y42T"
--    local token,number = "o1m4I8yS7a5J+EzthHmPm119e0exKFl0pNb7SUaWKYQAjL4PCRQtFAlphPVgppTkv8JKVMwsB1EcrPQ/ViGQ8U/TszHXsXpWzVlZ9YkR3sAr5dEJFTbfFEJYmLv9y+nzCkbckqqdBACcBla/bPm3VMxhzI02wn+7/c97qQKhA1c=",""	
    local token,number = "m1zWqI35YyuPnyhVEo0ImtghaLCUvKp+qNxShk6n8tq6+Bmg0hbnw7KaQbG4PvwRNKF6+swHTySwP1fCgeaXa6vWOMeRzj1QZ65553Kedlhs5qTMXRGVSb5GJioDfmnGuD912260pJs7DW6vPve0hL8+ap4v+n8Ns46MswLu2ew=",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				toast("获取token\n"..i.."次共5次")
                mSleep(1500)
				local lx_url = 'http://api.do889.com:81/api/logins?username='..User..'&password='..Pass
				log(lx_url)
                RetStr = get_lx(lx_url)
				log(RetStr)
				if RetStr then
					local sz = require('sz')
					local cjson = sz.json
					RetStr = cjson.decode(RetStr)
					if  RetStr.message == '登录成功' then
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
				local url___ = "http://api.do889.com:81/api/get_mobile?token="..token.."&project_id="..PID.."&operator=4"
--				local url___ = "http://api.do889.com:81/api/get_mobile?token="..token.."&project_id="..PID
				RetStr = get(url___)
				log(RetStr)
				if RetStr then
					if  RetStr.message == 'ok' then
						number = RetStr.mobile
						log(number)
					end
					local phone_title = (string.sub(number,1,2))
--					local blackPhone = {'14','17'}
--					local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
	--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
	--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
					local blackPhone = {}
					for k,v in ipairs(blackPhone) do
						if phone_title == v then
							local lx_url =	'http://api.yumoyumo.com/api/yhlh?token='..token..'&number='..number..'&id='..PID
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
				local url___ = "http://api.do889.com:81/api/get_message?token="..token.."&project_id="..PID.."&phone_num="..number
				log(url___)
				RetStr = get(url___)	
				log(RetStr)
				if RetStr then
					if  RetStr.message == 'ok' then
						Msg = RetStr.code
--						local i,j = string.find(Msg,"%d+")
--						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				delay(3)
				toast(tostring(RetStr).."\n"..i.."次共25次")
            end
            return false
        end),
	   
        addBlack=(function()
			local lx_url =	'http://api.yumoyumo.com/api/yhlh?token='..token..'&number='..number..'&id='..PID
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end



function _vCode_lh() --蓝狐
	local User = 'api-t4TRnuxO'
	local Pass = 'yangmian121'
	local PID = "12359"
    local token,number = "A2F8A6CA8FE8E7BF4B3D3D8EFA0004C6FC9401FB93385B",""
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				toast("获取token\n"..i.."次共5次")
                mSleep(1500)
				local lx_url = 'http://www.liuxing985.com:81/sms/api/login?username='..User..'&password='..Pass
				log(lx_url)
                RetStr = get_lx(lx_url)
				local sz = require('sz')
				local cjson = sz.json
				RetStr = cjson.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.msg == success or RetStr.msg == 'success' then
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
			local url___ = "http://www.liuxing985.com:81/sms/api/getPhone?token="..token.."&sid="..PID.."&ascription=1"
			log(url___)
			RetStr = get_lx(url___)
			if RetStr ~= "" and  RetStr ~= nil then
				local sz = require('sz')
				local cjson = sz.json
				RetStr = cjson.decode(RetStr)
				log(RetStr)
			end
			if RetStr.msg == success or RetStr.msg== 'success' then
				number = RetStr.phone
				log(number)
				local phone_title = (string.sub(number,1,2))
--				local blackPhone = {'14','17'}
				local blackPhone = {}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://www.huli667.com:81/sms/api/Addblack/?iid='..PID..'&phone='..number..'&token='..token
						get_lx(lx_url);
						log("拉黑->"..number)
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
				RetStr = get_lx("http://www.liuxing985.com:81/sms/api/getMessage?token="..token.."&sid="..PID.."&phone="..number)
				log(RetStr);
				if RetStr ~= "" and  RetStr ~= nil then
					local sz = require('sz')
					local cjson = sz.json
					RetStr = cjson.decode(RetStr)
					log(RetStr)
				end
				if RetStr then
					if RetStr.msg == success or RetStr.msg== 'success' then
						Msg = RetStr.sms
						local i,j = string.find(Msg,"%d+")
						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
            end
            return false
        end),
        addBlack=(function()
			local lx_url =	'http://www.huli667.com:81/sms/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..'&json=2'
			log("拉黑"..number..'\n'..lx_url);
            return get_lx(lx_url);
        end),
    }
end

