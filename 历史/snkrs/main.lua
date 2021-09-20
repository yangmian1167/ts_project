require("TSLib")
require("tsp")
require("nameStr")
--require("AWZ")


var = {}
var.appbid = "com.nike.onenikecommerce";
var.phone = ''
var.password = ''
t={}



t['加入']={ 0x111111, "-29|7|0x111111,-31|7|0x7f7f7f,-97|-29|0xffffff,-307|-2|0xfdfdfd,-183|45|0xffffff", 90, 18, 1065, 594, 1206 } --多点找色
t['注册界面and继续']={ 0xffffff, "-7|2|0xffffff,-287|-21|0x000000,297|32|0x000000,312|-40|0xffffff", 90, 24, 493, 727, 1176 } --多点找色
t['注册界面and继续_发送验证码']={ 0x111111, "-38|-1|0x111111,-116|-27|0xe5e5e5,44|19|0xe5e5e5,46|-28|0xe5e5e5", 90, 477, 336, 713, 472 } --多点找色

t['键盘_完成']={ 0x007aff, "14|-7|0x007aff,-36|-6|0x007aff,-13|-9|0x007aff", 90, 551, 712, 727, 882 } --多点找色

t['tips_操作失败']={ 0x111111, "-18|0|0x595959,-224|-258|0x969696,101|-172|0x757575,-120|-122|0x757575", 90, 150, 522, 617, 837 } --多点找色



function reg()
	local timeline = os.time()
	local outTimes = 60 * 1
	local 手机号 = true
	local 短信 = false
	local 提交 = false
	var.password  = "AaDd112211"
	local fix_info = false
	
	while os.time()-timeline < outTimes do
		if active(var.appbid,5) then
			if d('注册界面and继续') or d('键盘_完成') then
				if 手机号 then
--					var.phone = dxcode.getPhone()
--					if #var.phone == 11 then
						delay(2)
						click(229,462)
--						input[3](var.phone)
						input[3]('18129871166')
						手机号 = false
						短信 = true
--					end
				elseif 短信 then	
					if d('注册界面and继续_发送验证码',true) then
					else	
--						var.sms = dxcode.getMessage()
--						if #var.sms == 5 then
--							input[3](var.sms)
							click(137,516)
--							input[3](sms)
							input[3]('111111')
--							up('点击注册')
							短信 = false
							提交 = true
							
--						else
--							return false
--						end	
					end
				elseif 提交 then
					if d('注册界面and继续',true) then
					else
	--					up('填写资料')
						toast('注册结束',1)
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


--reg()
t['填资料界面and加入']={ 0xffffff, "-8|0|0x0d0d0d,-18|-10|0x5e5e5e,-269|-36|0x000000,329|26|0x000000", 90, 15, 878, 731, 1271 } --多点找色
t['日期界面']={ 0x007aff, "13|-5|0x007aff,-115|-4|0x077dff,-87|-6|0x007aff,-81|-1|0xaed0f5", 90, 538, 833, 725, 885 } --多点找色
t['电子邮件保存界面']={ 0xe0e0e0, "-31|-6|0xbfbfbf,-298|-26|0x000000,265|19|0x000000,-316|-54|0xffffff", 90, 16, 454, 727, 664 } --多点找色
t['主界面']={ 0xcccccc, "-7|-16|0xe9e9e9,-377|1|0xe5e5e5,-558|2|0xafafaf,-588|-3|0xffffff,-584|-10|0xcfcfcf,-562|5|0x111111", 90, 50, 1244, 700, 1310 } --多点找色
function 填资料()
	local timeline = os.time()
	local outTimes = 60 * 4
	local 填资料姓名密码 = true
	local 日期性别 = true
	local 邮箱 = true

	while os.time()-timeline < outTimes do
		if active(var.appbid,5) then
			if d('填资料界面and加入') or d('键盘_完成') then
				if 填资料姓名密码 then
					click(151,349)
					input[1](xin[math.random(1,#xin)])
					delay(2)
					click(462,357)
					input[1](ming[math.random(1,#ming)])
					click(97,471)
					input[1]('Aa112211')
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
						--性别
						click(258,643)
						日期性别 = false
					else
						click(168,582)
					end
				elseif d('填资料界面and加入',true) then
				end
			
			elseif d('电子邮件保存界面') or d('键盘_完成') then
				if 邮箱 then
					delay(2)
					click(109,414)
					input[1](myRand(5,9))
					邮箱 = false
				end
				d('电子邮件保存界面',true)
			elseif d('主界面') then
				toast('注册完成',1)
				return true
			end	
		end
		delay(1)
	end
end



填资料()













