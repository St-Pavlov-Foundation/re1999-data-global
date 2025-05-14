module("modules.common.others.SendWeWorkFileHelper", package.seeall)

local var_0_0 = class("SendWeWorkFileHelper")
local var_0_1 = "https://qyapi.weixin.qq.com/cgi-bin/webhook/upload_media?key=002753ef-1871-480a-bad0-7981b40003b5&type=file"
local var_0_2 = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=002753ef-1871-480a-bad0-7981b40003b5"

function var_0_0.SendFile(arg_1_0)
	ZProj.SendWeWorkFileHelper.Instance:SendFile(var_0_1, var_0_2, arg_1_0)
end

return var_0_0
