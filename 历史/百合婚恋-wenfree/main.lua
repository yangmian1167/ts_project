



require("TSLib")
require("tsp")



var = {}
var.appbid = "com.baihe.online";
var.phone = ''
var.password = ''
t={}




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
	local User = 'a15240678777'
	local Pass = 'Tyx168777'
	local PID = '1723'
    local token,number = "",""
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				toast("获取token\n"..i.."次共5次")
                mSleep(1500)
				local lx_url = 'http://api.smskkk.com/api/do.php?action=loginIn&name='..User..'&password='..Pass
				log(lx_url)
                RetStr = get_lx(lx_url)
				if RetStr then
					RetStr = strSplit(RetStr,"|")
					if RetStr[1] == 1 or RetStr[1] == '1' then
						token = RetStr[2]
						nLog('token='..token,true)
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
--			nLog('jinru')
			RetStr = get_lx("http://api.smskkk.com/api/do.php?action=getPhone&sid="..PID.."&token="..token)
			if RetStr ~= "" and  RetStr ~= nil then
				RetStr = strSplit(RetStr,"|")
				nLog(RetStr)
			end
			if RetStr[1] == 1 or RetStr[1]== '1' then
				number = RetStr[2]
				log(number)
				local phone_title = (string.sub(number,1,3))
				local blackPhone = {'144','141','142','143','144','145','146','147'}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://api.smskkk.com/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
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
                RetStr = get_lx("http://api.smskkk.com/api/do.php?action=getMessage&sid="..PID.."&token="..token.."&phone="..number)
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
			local lx_url =	'http://api.smskkk.com/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
			log("拉黑"..number..'\n'..lx_url);
            return get_lx(lx_url);
        end),
    }
end




local dxcode = _vCode_lx()
dxcode.login()

t['登录界面——注册']={0xff676f, "-317|3|0xff7272,-254|8|0xffffff,-474|10|0xffffff,172|6|0xfffcfc",90,15,48,735,200} --多点找色
t['注册界面']={0xff6c6b, "-1|-1|0xffeaea,-201|-33|0xffffff,-202|0|0xf34252,-491|-38|0xffffff,-536|2|0xffffff",90,16,53,736,241} --多点找色
	t['注册界面——手机号']={0xcacacf, "43|-13|0xffffff,41|-26|0xc7c7cc",90,233,352,508,426} --多点找色
	t['注册界面——立即注册']={0xffffff, "284|-49|0xff2e6d,-317|44|0xff7330,-19|-4|0xff514f",90,30,563,720,734} --多点找色
	t['注册界面——账号异常']={ 0xffffff, "-132|37|0xffffff,-199|-19|0x666666,52|47|0x666666,61|-10|0x666666", 90, 222, 707, 533, 811 } --多点找色
t['输入验证码界面']={0xfc6e27, "92|-10|0xf9f9f9,94|-12|0xfc6e27,92|13|0xfc6e27,434|3|0xeeeeee,435|3|0x000000,432|8|0x000000",90,11,52,481,116} --多点找色
--t['基本信息界面']={0xfc6e27, "15|-18|0xfc6e27,15|15|0xf9f9f9,390|-9|0xdedede,391|-9|0x000000,389|-6|0x161616,389|-5|0xf9f9f9",90,14,48,714,672} --多点找色
t['基本信息界面']={ 0x686868, "-6|5|0xebebeb,-5|30|0xe7e7e7,108|0|0x787878,124|29|0x979797", 90, 293, 49, 469, 117 } --多点找色9系统
	t['基本信息界面-随机昵称']={0xff5f5e, "-62|-29|0xff5f5e,56|30|0xff5f5e,86|0|0xff5f5e,5|-2|0xffffff",90,523,140,734,227} --多点找色
	t['基本信息界面-随机男女']={0x7ba2fe, "405|3|0xff7d5e,-49|-47|0x809efe,539|43|0xff615e",90,35,383,708,629} --多点找色
--t['完善信息界面']={0xfc6e27, "156|-11|0xf9f9f9,158|1|0xfc6e27,379|7|0xf9f9f9,382|4|0x000000,382|2|0xf9f9f9",90,5,51,476,115} --多点找色
t['完善信息界面']={ 0x9c9c9c, "-12|11|0xa2a2a2,-11|31|0x6e6e6e,102|0|0x787878,111|30|0x606060", 90, 297, 57, 452, 112 } --多点找色9系统
	t['完善信息界面-完成注册']={0xffffff, "-315|-43|0xfe7d46,270|42|0xff4971",90,59,1085,711,1252} --多点找色
	t['完善信息界面-上传头像']={0xff5f5e, "0|14|0xff5f5e,-3|9|0xf3f3f3,-3|4|0xf3f3f3,-9|6|0xff5f5e",90,387,262,457,329} --多点找色

--t['完善信息界面-相机胶卷']={0xffffff, "342|-12|0xf8f8f8,677|-2|0xffffff,676|-2|0x4a4a4a",90,4,43,741,118} --多点找色
t['完善信息界面-相机胶卷']={ 0xffffff, "-34|1|0xffffff,-40|-23|0x414141,62|19|0x414141,103|-15|0x414141", 90, 298, 57, 466, 115 } --多点找色9系统

--相册弹窗
t['弹窗——本地相册']={0x007aff, "96|-5|0x007aff,149|23|0x007aff",90,238,890,492,1175} --多点找色
t['弹窗——好-不允许']={0x007aff, "-4|15|0x007aff,-320|-12|0x007aff",90,115,411,639,924} --多点找色
t['弹窗——完成']={0x181818, "0|6|0x53b311,32|-7|0x53b311",90,624,1251,740,1326} --多点找色
--错误信息
t['已经注册-世纪侍缘']={0xff7e6a, "-444|-308|0xff4e56,-107|-170|0xfef6fb,-293|-141|0xff8989",90,4,43,659,503} --多点找色
t['已经注册-免费打招呼']={0xff6e1d, "-251|-40|0xff6e1d,242|-36|0xff6e1d,249|41|0xff6e1d,-76|2|0xffffff,250|-869|0xffffff",90,62,96,669,1132} --多点找色
t['已经注册-上传头像']={0xffffff, "-488|558|0xfc6e27,-9|642|0xfc6e27,6|727|0xfc6e27,-503|715|0xffffff,-505|715|0xfc6e27",90,78,209,686,1054} --多点找色

function rdclicks(x,y,n)
	if n == 0 then
		return false
	end
	for i=1,n do
		click(x,y,0.5)
	end
end


function reg()
	local timeline = os.time()
	local outTimes = 60 * 5
	
	var.password  = "AaDd112211"
	local fix_info = false
	
	while os.time()-timeline < outTimes do
		if active(var.appbid,5) then
			if d('登录界面——注册',true) then
			elseif d('注册界面')then
				if d('注册界面——账号异常')then
					return false
				elseif d('注册界面——手机号')then
					var.phone = dxcode.getPhone()
					if var.phone then
						d('注册界面——手机号',true)
						input[3](var.phone)
					end
				elseif d('注册界面——立即注册',true)then
				end
			elseif d('输入验证码界面')then
				var.sms = dxcode.getMessage()
				if var.sms then
					input[3](var.sms);
					other_txt = other_txt .. "【" .. var.sms .. "】"
					up_wenfree(other_txt)
				else
					log("接码失败",true)
					return false
				end
			elseif d('完善信息界面')then
				if d('完善信息界面-上传头像',true)then
				else
					local fix____ ={{657,432,0xffffff},{650,541,0xffffff},{653,646,0xd9d9d9},{561,759,0xffffff},{524,870,0xffffff},{429,972,0xcccccc},}  --多点取色
					for i,v in ipairs(fix____) do
						if i == 1 then
							click(v[1],v[2],2)
							rdclicks(215,1010,rd(2,5))
							click(687,778)--确定
						elseif i == 2 then
							click(v[1],v[2],3)
							click(rd(88,209),rd(839,1285),2)
							click(687,778)--确定
						elseif i == 3 then
							click(v[1],v[2],2)
							click(rd(70,667),rd(876,1276))
							click(687,778)--确定
						elseif i == 4 or i ==5 then
							rdclicks(v[1],v[2],rd(2,5))
						elseif i == 6 then
							click(v[1],v[2],1)
						end
					end
				end
				if d('完善信息界面-完成注册',true)then
					fix_info = true
				end
			elseif d('基本信息界面')then
				d('基本信息界面-随机昵称',true,1)
				click(633,292)
				input[1](var.password)
				d('基本信息界面-随机男女',true,rd(1,2),3)
			elseif fix_info and (d('已经注册-免费打招呼',true,1,rd(2,5)) or d('已经注册-上传头像',true)) then
				log("完成注册",true)
				other_txt = other_txt .. "->完成"
				return true
			elseif d('已经注册-世纪侍缘') or d('已经注册-免费打招呼') or d('已经注册-上传头像',true) then
				up_wenfree("错误号码")
				dxcode.addBlack()
				return false
			elseif d('完善信息界面-相机胶卷')then
				moveTo(300,300,300,rd(500,800),rd(20,50))
				delay(rd(2,4))
				click(rd(50,650),rd(160,1242),1.5)
			else
				if 	d("弹窗——本地相册",true)then
				elseif d("弹窗——好-不允许",true)then
				elseif d("弹窗——完成",true)then
					other_txt = other_txt .. "->头像"
				end
			end
		end
		delay(2)
	end

end


function up()
	local url = 'http://ssffzz.com/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = '百合婚恋'
	postdate.idfa = var.phone
	postdate.password = var.password
	postdate.other = '注册成功'
	post(url,postdate)
	-- body
end

function up_wenfree(other)
	local url = 'http://wenfree.cn/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = '百合婚恋'
	postdate.idfa = var.phone
	postdate.phone = var.phone
	postdate.password = var.password
	postdate.appid = '500975133'
	postdate.other = other
	post(url,postdate)
	-- body
end


require("AWZ")
clearAllPhotos()
delay(5)
for var= 1, 30 do
	local header_unm = rd(100,2400)
	local imgUrl = 'https://img.wenfree.cn/baihe/img-'.. header_unm ..'.jpg';
	downFile(imgUrl,"/User/Media/TouchSprite/res/"..header_unm..".jpg");
	saveImageToAlbum(header_unm .. ".jpg")
end

--while (true) do
--	vpn.off()
--	delay(3)
--	if vpn.on() then
		
--		other_txt = ''
		
--		if awzNew()then
--			if reg()then
--				closeX(var.appbid)
--				up_wenfree(other_txt)
--			end
--		end

--	end
	
--	delay(2)
--end











