-- 世纪佳缘-mac
-- sjjy.lua  

-- Create By TouchSpriteStudio on 21:25:52   
-- Copyright © TouchSpriteStudio . All rights reserved.
	
	




require("TSLib")
require("tsp")



var = {}
var.appbid = "com.netease.lotterynews";
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

--get函数
function get_lx(url)
	local sz = require("sz")
	local http = require("szocket.http")
	local res, code = http.request(url);
	if code == 200 then
		return res
	end
end

--来信平台
function _vCode_lx() --来信
	local User = 'api-18190-rKpL6bd'
	local Pass = '135246'
	local PID = '7226'
    local token,number = "6klqv7mnkm50knvwmqkbwbkq6l6anw0p",""
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				toast("获取token\n"..i.."次共5次")
                mSleep(1500)
				local lx_url = 'http://api.banma1024.net/api/do.php?action=loginIn&name='..User..'&password='..Pass
				log(lx_url)
                RetStr = get_lx(lx_url)
				if RetStr then
					RetStr = strSplit(RetStr,"|")
					if RetStr[1] == 1 or RetStr[1] == '1' then
						token = RetStr[2]
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
			local url___ = "http://api.banma1024.net/api/do.php?action=getPhone&sid="..PID.."&token="..token
			log(url___)
			RetStr = get_lx(url___)
			if RetStr ~= "" and  RetStr ~= nil then
				log(RetStr)
				RetStr = strSplit(RetStr,"|")
			end
			if RetStr[1] == 1 or RetStr[1]== '1' then
				number = RetStr[2]
				log(number)
				local phone_title = (string.sub(number,1,3))
				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://api.banma1024.net/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
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
				RetStr = get_lx("http://api.banma1024.net/api/do.php?action=getMessage&sid="..PID.."&token="..token.."&phone="..number)
				log(RetStr);
				if RetStr then
					local arr = strSplit(RetStr,"|") 
					if arr[1] == '1' then 
						Msg = arr[2]
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
			local lx_url =	'http://api.banma1024.net/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
			log("拉黑"..number..'\n'..lx_url);
            return get_lx(lx_url);
        end),
    }
end

local dxcode = _vCode_lx()


function rdclicks(x,y,n)
	if n == 0 then
		return false
	end
	for i=1,n do
		click(x,y,0.5)
	end
end

t['tps_提示同意']={ 0xf44b4b, "-6|0|0xf22222,-266|-3|0x6e6e6e,-281|-5|0x666666,-325|-5|0xffffff", 90, 144, 911, 586, 971 } --多点找色
t['tps_滑动弹窗']={ 0xff3333, "-57|2|0xff3333,-34|-9|0xffffff", 90, 247, 1018, 474, 1054 } --多点找色
t['tps_滑动弹窗_开启彩虹之旅']={ 0xffffff, "-113|-3|0xffffff,-184|-22|0xff3333,140|37|0xff3333", 90, 157, 877, 600, 990 } --多点找色
--t['tps_弹窗点X']={ 0xffffff, "-31|-24|0xffffff,31|21|0xffffff,-11|11|0xffffff", 90, 312, 909, 440, 1050 } --多点找色
t['tps_弹窗点X']={ 0xffffff, "-14|14|0xffffff,-1|27|0x808080,-31|23|0xffffff,30|-24|0xffffff", 90, 314, 829, 443, 1111 } --多点找色
t['返回箭头']={ 0xffffff, "13|0|0xf22222,16|-17|0xffffff,8|-19|0xf22222", 90, 14, 62, 48, 119 } --多点找色

t['主页点我的']={ 0x777777, "1|-7|0xffffff,-455|0|0x777777,-603|-32|0xf74a1e,-595|14|0xe71f12", 90, 34, 1243, 734, 1326 } --多点找色
t['我的界面点手机/邮箱']={ 0xff2222, "-17|0|0xffffff,27|44|0xf53c21,524|1066|0xf7471f,517|1118|0xe71f12,67|1099|0x777777", 90, 88, 110, 725, 1329 } --多点找色

t['手机号登录界面']={ 0x555555, "7|33|0xb8b8b8,8|36|0x818181,204|-2|0x9d9d9d,210|35|0xaaaaaa", 90, 58, 198, 306, 260 } --多点找色
	t['手机号登录界面_同意条款']={ 0xd2d2d2, "0|3|0xffffff,0|19|0xffffff,0|21|0xd2d2d2", 90, 66, 1226, 101, 1253 } --多点找色
	t['手机号登录界面_快捷登录']={ 0xffffff, "-179|-30|0xf22222,221|34|0xf22222", 90, 89, 742, 664, 853 } --多点找色
	t['手机号登录界面_获取验证码']={ 0x666666, "-22|-6|0x6e6e6e,-44|-6|0xffffff,53|3|0x666666", 90, 509, 346, 692, 408 } --多点找色
	
t['注册成功界面']={ 0xf6451f, "1|22|0xf7451f,-160|13|0xffffff,-165|12|0x777777,-593|31|0x7b7b7b,-593|52|0x686868", 90, 36, 1243, 715, 1321 } --多点找色
function reg()
	local timeline = os.time()
	local outTimes = 60 * 3
	local 手机号 = true
	local 短信 = false
	local 提交 = false
	var.password  = "AaDd112211"
	while os.time()-timeline < outTimes do
		if active(var.appbid,5) then
			if 提交 and d('注册成功界面') then
				up('注册成功')
				return true
			elseif d('手机号登录界面') then
				if d('手机号登录界面_同意条款',true) then
				elseif 手机号 then
					var.phone = dxcode.getPhone()
					if var.phone then
						click(144,379)
						input[3](var.phone)
						手机号 = false
						短信 = true
					end
				elseif 短信 then	
						if d('手机号登录界面_获取验证码',true) then
						else	
							var.sms = dxcode.getMessage()
							if var.sms then
	--							input[3](var.sms)
								click(140,492)
								input[3](var.sms)
								短信 = false
								提交 = true
							else
								return false
							end	
						end
				elseif 提交 then
					if d('手机号登录界面_快捷登录',true) then
						up('点击注册')
					else
						
					end	
				end
			
			elseif d('主页点我的',true) then
			elseif d('我的界面点手机/邮箱',true) then
			else
				if d('tps_滑动弹窗_开启彩虹之旅',true) then
				elseif d('tps_滑动弹窗') then
					moveTo(470,562,230,556)
				elseif d('tps_提示同意',true) then
				elseif d('返回箭头',true) then
				elseif d('tps_弹窗点X',true) then
				end
			end	
		end
		
		delay(2)
	end

end
--function reg()
--	local timeline = os.time()
--	local outTimes = 60 * 1
--	local 手机号 = true
--	local 短信 = false
--	var.password  = "AaDd112211"
--	local fix_info = false
	
--	while os.time()-timeline < outTimes do
--		if active(var.appbid,5) then
--			if d('填写资料') or d('上传头像_跳过') then
--				return true
--			elseif d('手机号注册界面') then
--				if 手机号 then
--					var.phone = dxcode.getPhone()
--					if var.phone then
--						click(354,326)
--						input[3](var.phone)
--						手机号 = false
--						短信 = true
--					end
--				elseif 短信 then	
--					if d('手机号注册界面_获取验证码',true) then
--					else	
--						var.sms = dxcode.getMessage()
--						if var.sms then
--							input[3](var.sms)
--							click(187,437)
--							input[3](sms)
--							短信 = false
--							提交 = true
--							up('点击注册')
--						else
--							return false
--						end	
--					end
--				end
--			elseif 提交 then
--				if d('填写资料') then
--					up('填写资料')
--					return true
--				end
--			end	
--		end
		
--		delay(2)
--	end

--end


t['填资料1界面']={ 0x000000, "-10|-12|0xfefefe,285|4|0x000000,290|16|0xfefefe,296|19|0x000000,303|19|0xfefefe", 90, 29, 134, 362, 208 } --多点找色
t['填资料1界面ios10']={ 0x5a5c5d, "-39|-10|0x565859,-182|-18|0x7e7f7f,-186|5|0x979899,6|6|0xf1f1f1", 90, 271, 62, 484, 106 } --多点找色
	t['填资料1界面_请输入昵称']={ 0xd9d9d9, "-13|-3|0xd9d9d9,-28|-8|0xd9d9d9,-89|1|0xd9d9d9,-98|-1|0xd9d9d9", 90, 176, 386, 334, 432 } --多点找色
	t['填资料1界面_请输入昵称ios10']={ 0xe4e4e4, "-102|-17|0xf3f3f3,-100|7|0xeeeeee,35|-19|0xf2f2f2,44|-15|0xf4f4f4", 90, 175, 280, 338, 318 } --多点找色
	t['填资料1界面_男女比例']={ 0xfed9e7, "-380|2|0xdaeeff,-348|46|0xd1edff,24|48|0xfedfe4", 90, 114, 471, 623, 569 } --多点找色
	t['填资料1界面_生日未选择']={ 0xd9d9d9, "6|8|0xd9d9d9,82|-4|0xf3f3f3,84|6|0xdadada,84|17|0xdbdbdb", 90, 545, 607, 644, 651 } --多点找色
	t['填资料1界面_地区未选择']={ 0xd9d9d9, "6|8|0xd9d9d9,82|-4|0xf3f3f3,84|6|0xdadada,84|17|0xdbdbdb", 90, 544, 701, 645, 739 } --多点找色
	t['填资料1界面_下一步']={ 0x333333, "0|-2|0x979797,-44|-9|0x333333,29|-3|0x353535", 90, 605, 58, 713, 109 } --多点找色
t['填资料2界面']={ 0x000000, "-2|0|0xa2a2a2,-3|1|0xfefefe,285|19|0x000000,287|20|0x545454,290|20|0xfefefe", 90, 19, 130, 339, 204 } --多点找色	
t['填资料2界面ios11']={ 0xa3a3a3, "-6|51|0xa0a0a0,281|22|0x555555,303|16|0x585858,314|15|0xababab", 90, 29, 139, 389, 215 } --多点找色

	t['填资料2界面_身高未选择']={ 0xefefef, "-2|-21|0xf8f8f8,-85|-18|0xf4f4f4,-88|2|0xf5f5f5,-9|5|0xe4e4e4", 95, 545, 389, 643, 431 } --多点找色
	t['填资料2界面_学历未选择']={ 0xe0e0e0, "0|7|0xd9d9d9,8|21|0xdcdcdc,79|-4|0xd9d9d9,76|7|0xffffff", 95, 540, 484, 652, 520 } --多点找色
	t['填资料2界面_月薪未选择']={ 0xe0e0e0, "0|7|0xd9d9d9,8|21|0xdcdcdc,79|-4|0xd9d9d9,76|7|0xffffff", 95, 546, 576, 646, 612 } --多点找色
	t['填资料2界面_婚史未选择']={ 0xe0e0e0, "0|7|0xd9d9d9,8|21|0xdcdcdc,79|-4|0xd9d9d9,76|7|0xffffff", 95, 546, 666, 646, 704 } --多点找色
t['完成']={ 0x2099ff, "11|4|0x1493ff,35|16|0x1c97ff,21|10|0x2b9eff,37|-1|0xa2d4ff", 90, 649, 837, 718, 881 } --多点找色
	t['完成_生日']={ 0x696969, "-6|12|0xa1a1a1,51|27|0x333333,51|0|0x4e4e4e,51|-1|0xffffff", 90, 342, 839, 405, 875 } --多点找色	
	t['完成_所在地区']={ 0xbebebe, "-2|26|0xaeaeae,123|0|0x737373,124|25|0x949494,98|-1|0x848484", 90, 305, 838, 441, 877 } --多点找色
	t['完成_身高']={ 0xe8e8e8, "1|0|0xb3b3b3,-11|20|0xc0c0c0,49|3|0xa2a2a2,47|29|0xb6b6b6", 90, 337, 836, 413, 878 } --多点找色
	t['完成_学历']={ 0x868686, "-4|6|0xbdbdbd,4|28|0xb5b5b5,56|2|0x646464,51|28|0xaaaaaa", 90, 340, 839, 411, 874 } --多点找色
	t['完成_月薪']={ 0xc7c7c7, "1|0|0x4e4e4e,-3|26|0xb1b1b1,55|1|0x6a6a6a,52|27|0x939393", 90, 344, 838, 407, 879 } --多点找色
	t['完成_婚史']={ 0x969696, "-2|0|0x606060,-4|28|0x787878,53|4|0x7b7b7b,56|26|0xe9e9e9", 90, 334, 837, 413, 879 } --多点找色
	
	
t['上传头像_跳过']={ 0x363839, "-424|88|0x000000,-417|89|0xfefefe,-361|356|0xd8d8d8,-317|385|0xfefefe", 90, 30, 57, 725, 652 } --多点找色
local degree = 85

	t['填资料2/完成注册']={0xf84680,"242|-38|0xf83a85,-256|20|0xf96c6e",degree,47,800,682,1000}
	local degree = 85

		t['主界面——完成']={0xff1a83,"-13|19|0xff2b7e,-24|7|0xff5071",degree,16,1226,132,1320}
	
function 填资料()
	local timeline = os.time()
	local outTimes = 60 * 2
	local 比例男 = math.random(1,100)
	while os.time()-timeline < outTimes do
		if active(var.appbid,5) then
			if d('主界面——完成')then
				up('完整注册')
				return true
			elseif d('填资料2界面') or d('填资料2界面ios11') then
				if d('填资料2界面_身高未选择',true) then
				elseif d('填资料2界面_身高未选择' ,true) then
				elseif d('填资料2界面_学历未选择' ,true) then
				elseif d('填资料2界面_月薪未选择' ,true) then
				elseif d('填资料2界面_婚史未选择' ,true) then
				elseif d('填资料2/完成注册' ,true,1,3) then
					delay(8)
				end
			elseif d('填资料1界面') or d('填资料1界面ios10') then
				if d('填资料1界面_下一步',true) then
				elseif d('填资料1界面_请输入昵称') or d('填资料1界面_请输入昵称ios10') then
					click(586,409)
				elseif d('填资料1界面_男女比例') then
					
					if 比例男 < 50 then
						click(167,520)
					else
						click(516,510)
					end	
				elseif d('填资料1界面_生日未选择',true) then
				elseif d('填资料1界面_地区未选择',true) then
				end
	
			elseif d('完成') then
				if d('完成_生日') then
					local 随机1 = math.random(1,5) 
					local 随机2 = math.random(1,3) 
					local 随机3 = math.random(1,3) 
					for i = 1 , 随机1 do
						click(234,1055)
					end	
					for i = 1 , 随机2 do
						click(381,1058)
					end	
					for i = 1 , 随机3 do
						click(518,1052)
					end	
					d('完成',true)
				elseif d('完成_所在地区') then
					local 随机4 = math.random(1,10) 
					local 随机5 = math.random(1,10) 
					for i = 1 , 随机4 do
						click(201,1178)
					end
					for i = 1 , 随机5 do
						click(547,1186)
					end	
					d('完成',true)
				elseif d('完成_身高') then
					if 比例男 < 50 then
						for i = 1 ,math.random(4,8) do
							moveTo(387,1114,386,915)
						end
					else
						for i = 1 ,math.random(3,4) do
							moveTo(387,1114,386,915)
						end
					end
					d('完成',true)
				elseif d('完成_学历') then
					for i = 1 , math.random(1,5) do
						click(379,1185)
					end	
					d('完成',true)
				elseif d('完成_月薪') then	
					for i = 1 , math.random(1,4) do
						click(379,1185)
					end	
					d('完成',true)
				elseif d('完成_婚史') then
					click(379,1185)
					d('完成',true)
				else
					d('完成',true)
				end	
			else
				d('上传头像_跳过',true)
			end	
		end
		delay(1)
	end
end


function up(other)
	local url = 'http://hb.wenfree.cn/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = '网易红彩'
	postdate.idfa = var.phone
	postdate.password = var.password
	postdate.other = other
	log(post(url,postdate))
	-- body
end

--function up(other)
--	local url = 'http://wenfree.cn/api/Public/idfa/'
--	local postdate = {}
--	postdate.service = 'Idfa.Idfa'
--	postdate.name = '世纪佳缘'
--	postdate.idfa = var.phone
--	postdate.password = var.password
--	postdate.other = other
--	log(post(url,postdate))
--	-- body
--end

--require("AWZ")

function all()
	while true do
		vpn.off()
		if  false or vpn.on() then
			delay(3)
			dxcode.login()
			if sys.clear_bid(var.appbid)then
				if reg()then
--					填资料()
				end
			end
		end
	end
end

while (true) do
	local ret,errMessage = pcall(all)
	if ret then
	else
		log(errMessage)
		dialog(errMessage, 10)
		mSleep(2000)
	end
end











