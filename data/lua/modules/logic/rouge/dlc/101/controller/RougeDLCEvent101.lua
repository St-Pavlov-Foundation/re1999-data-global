module("modules.logic.rouge.dlc.101.controller.RougeDLCEvent101", package.seeall)

local var_0_0 = _M
local var_0_1 = 1

local function var_0_2(arg_1_0)
	assert(var_0_0[arg_1_0] == nil, "[RougeDLCEvent101] error redefined RougeDLCEvent101." .. arg_1_0)

	var_0_0[arg_1_0] = var_0_1
	var_0_1 = var_0_1 + 1
end

var_0_2("UpdateLimitGroup")
var_0_2("OnSelectBuff")
var_0_2("RefreshLimiterDebuffTips")
var_0_2("UpdateBuffState")
var_0_2("UpdateEmblem")
var_0_2("CloseBuffDescTips")

return var_0_0
