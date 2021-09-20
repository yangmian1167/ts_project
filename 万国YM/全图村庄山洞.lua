require('tsp')
--require('AWZ')
--require('ui')
require('ZZBase64')
require("yzm")
require('api')
require('token')


init(1)
_app = {}
_app.bid = 'com.lilithgames.rok.ios.offical'
_app.yzmid = 0;
t={}
t['房子']={ 0xefd589, "-3|0|0xecdd81", 90, 292, 53, 1137, 657 } --多点找色
t['房子2']={ 0xf0d589, "-3|0|0xefd887,-4|-1|0xe7d882", 90, 179, 152, 1216, 579 } --多点找色
t['山洞']={ 0xe8db82, "4|0|0xe9dc81,2|-3|0xe9e07f", 90, 179, 152, 1216, 579 } --多点找色
t['山洞2']={ 0xd5d080, "-5|0|0xd0c884,-3|-4|0xd3cb82", 90, 1179, 152, 1216, 579  } --多点找色
t['调查']={ 0x1274ba, "-96|-24|0x00d1ff,69|17|0x00b7f3,76|-25|0x00d1ff", 90, 248, 148, 1225, 693 } --多点找色
t['派遣']={ 0xb67016, "-92|-20|0xffbc00,71|19|0xffa500,69|-14|0xffb800", 90, 927, 73, 1194, 486 } --多点找色
t['正在探索山洞']={ 0xffffff, "-3|-8|0xb20000,4|-7|0xb20000", 90, 1283, 208, 1314, 446 } --多点找色
--t['返回中']={ 0xfffffe, "-6|3|0xb45d00,1|-4|0xb55d00", 90, 1275, 188, 1316, 442 } --多点找色
t['返回中']={ 0xffffff, "0|10|0xf9f3ec,-4|6|0xb45d00,8|3|0xb36000", 90, 1275, 188, 1316, 442 } --多点找色


t['弹窗—验证图片2']={ 0x0e87c8, "45|20|0x2388c7,45|3|0x2f9dd4,-28|-1|0x00d4fe,71|24|0x00b6f1", 90, 707, 354, 846, 416 } --多点找色
t['弹窗—验证图片']={0x1274ba, "0|0|0x1274ba,28|-5|0x00c7ff,-58|-3|0x00c5ff,9|-283|0x000000",90,668,92,1328,452}
	t['弹窗—验证图片-确定'] = { 0x539ffe,"83|0|0x539ffe,-339|-2|0xffffff,-323|-10|0x7e7e7e,-406|-3|0x7e7e7e",90,392,644,944,730}
	t['弹窗—验证图片-确定-有图']={0x252525, "0|0|0x252525,0|1|0x252525",70,700,40,928,78}
	t['弹窗—验证图片-确定-有字']={0x727272, "0|0|0x727272",90,703,25,925,91}
function 缩图()

touchDown(1, 340,340);             --手指 1 在坐标 (200, 400) 按下
touchDown(2, 1119,378);             --手指 2 在坐标 (300, 500) 按下
--mSleep(50);
for i = 1, 200, 1 do                --使用 for 循环使两只手指同时分离
    touchMove(1, 200 + i, 333); 
    touchMove(2, 1119 - i, 378 );
    mSleep(1);
end
touchUp(1, 340 + 200, 340 );   --抬起手指 1
touchUp(2, 1119 - 200, 378);   --抬起手指 2

end


--[[]]
function 全图开洞村庄()

--	山洞派遣key = true
--	if d('正在探索山洞') then
--		山洞派遣key = false
--	end
	if d('返回中')  then
		if d('房子2',true) or d('房子',true)or d('山洞',true) or d('山洞2',true) then
			delay(1)
			click(655,366)
			delay(1)
			d('调查',true)
			d('派遣',true) 
			for i = 1 ,10 do
				缩图()
			end
		end	
	elseif d("弹窗—验证图片2",true,1,4) or d("弹窗—验证图片",true,1,4)  then
		local time_ = os.time()
		while ( os.time() - time_ < 120 ) do
			if d("弹窗—验证图片-确定") and ( d('弹窗—验证图片-确定-有图') or d('弹窗—验证图片-确定-有字') )then
				delay(1)
				if _yzmsb()then
					d("弹窗—验证图片-确定",true,1,5)
					delay(6);
					if d("弹窗—验证图片-确定") then
						post('http://api.ttshitu.com/reporterror.json',{['id']=_app.yzmid});
						return false
					else
						return true
					end
				end
			end
		end
	
	end	
delay(1)
end	

--]]

--[[]]

while (true) do
	local ret,errMessage = pcall(全图开洞村庄)
	if ret then
	end
end

--]]












