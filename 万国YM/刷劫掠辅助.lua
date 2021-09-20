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




function 缩图()

touchDown(1, 340,340);             --手指 1 在坐标 (200, 400) 按下
touchDown(2, 1119,378);             --手指 2 在坐标 (300, 500) 按下
--mSleep(50);
for i = 1, 210, 1 do                --使用 for 循环使两只手指同时分离
    touchMove(1, 200 + i, 333); 
    touchMove(2, 1119 - i, 378 );
    mSleep(5);
end
touchUp(1, 340 + 200, 340 );   --抬起手指 1
touchUp(2, 1119 - 200, 378);   --抬起手指 2
mSleep(100)
end

t={}
t['驻扎中']={ 0xffffff, "-5|-5|0x008ec2,7|2|0xffffff,4|7|0x008ec2", 90, 1288, 234, 1307, 426 } --多点找色
t['有任务栏']={ 0xdfffff, "33|20|0x86e4ff,3|-13|0x449cc6,36|33|0x004c7b", 90, 1229, 650, 1324, 735 } --多点找色
t['攻击按钮']={ 0x980e0e, "-21|0|0x980e0e,-98|-15|0xe7493b,61|23|0xd6322c", 90, 19, 41, 1286, 738 } --多点找色
t['广域劫掠图标']={ 0x000000, "0|5|0x000000,-7|4|0x15a119,7|4|0x16a219", 90, 12, 89, 1226, 659 } --多点找色
t['广域劫掠图标2']={ 0x000000, "0|5|0x000000,-7|4|0x15a119,7|4|0x16a219", 90, 679, 0, 1123, 749 } --多点找色
t['放大劫掠图标']={ 0x000000, "0|9|0x000000,-11|8|0x14a019,10|9|0x159d18", 90, 432, 171, 1024, 572 } --多点找色
t['行动力补充界面']={ 0x228e07, "1|-8|0xdcffb9,4|-14|0xcae1e4,16|-17|0xc87c1b,18|-20|0xff9e1f", 90, 401, 125, 460, 176 } --多点找色
t['行动力补充界面_使用']={ 0x1274ba, "-40|-2|0x1274ba,-104|-22|0x00d4ff,64|22|0x00b6f3", 90, 912, 215, 1140, 446 } --多点找色
t['行动力补充界面_倍数使用']={ 0x00a9e8, "-10|-16|0x00c2ff,-20|-27|0x00d1ff", 90, 755, 210, 902, 451 } --多点找色
function 辅助劫掠()
	if active(_app.bid,8) then
		if d('驻扎中')and d('有任务栏') then
			if d('攻击按钮',true) then
				delay(1)
				click(1226,706)
				delay(1)
				click(1085,693)	
				delay(2)
				if d('行动力补充界面') then
					if d('行动力补充界面_使用',true) then
						d('行动力补充界面_倍数使用',true) 
						click(1135,79)
						click(1085,693)
					end	
				end	
			elseif d('放大劫掠图标',true) then
			else
				for i = 1 ,2 do
					缩图()
				end
			end	
		elseif d('驻扎中') then
			if d('广域劫掠图标',true) and d('广域劫掠图标2',true) then
				
			end	
		end
		delay(1)
	end
end








--[[]]

while (true) do
	local ret,errMessage = pcall(辅助劫掠)
	if ret then
	end
end

--]]





