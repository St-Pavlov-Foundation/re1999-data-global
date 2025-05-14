module("modules.logic.act189.rpc.Activity189Event", package.seeall)

local var_0_0 = _M
local var_0_1 = 1

local function var_0_2(arg_1_0)
	assert(var_0_0[arg_1_0] == nil, "[Activity189Event] error redefined Activity189Event." .. arg_1_0)

	var_0_0[arg_1_0] = var_0_1
	var_0_1 = var_0_1 + 1
end

var_0_2("onReceiveGetAct189InfoReply")
var_0_2("onReceiveGetAct189OnceBonusReply")

return var_0_0
