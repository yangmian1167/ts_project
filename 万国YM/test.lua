require('tsp')
require('AWZ')
require('ZZBase64')
require("yzm")
require('api')
require('token')


sz = require('sz')
__game = {}
__game.imei = sz.system.serialnumber();
__game.phone_name = getDeviceName()

function update_token(token,idfa,qq)
    local RokToken = llsGameToken();
    local info ={}
    info['token']=token
    info['idfa']=idfa
    info['qq']=''
    info['s']='Rok.Token'
    _api_rok(info)
end


local a = {


{"P45MyWMEz2nxIIVhXIfp2Zrt8HZ2RJWk", '[  {    "app_token" : "P45MyWMEz2nxIIVhXIfp2Zrt8HZ2RJWk",    "user_password" : "",    "app_uid" : "7517927",    "player_id" : "AF803C5388AB2649C4EA0731BC902A2D",    "nickname" : "游客",    "user_type" : 2  }]',''},





}

    
 for k,v in ipairs( a )do
     log(v)
     update_token(v[1],v[2],v[3])
 end
init(1)
    
    
t={}
t['打野位置记忆位置']={0xacffff, "0|0|0xacffff,-8|0|0x1678b6,8|0|0x1872ab",90,152,393,409,443}
t['打野位置记忆位置-max']={0xa5f5f5, "0|0|0xa5f5f5,7|-1|0x1573af,-8|0|0x1573af",90,339,395,449,441}

d('打野位置记忆位置-max')
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
