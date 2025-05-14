module("modules.logic.versionactivity2_4.warmup.controller.V2a4_WarmUpEvent", package.seeall)

local var_0_0 = _M
local var_0_1 = 1

local function var_0_2(arg_1_0)
	assert(var_0_0[arg_1_0] == nil, "[V2a4_WarmUpEvent] error redefined V2a4_WarmUpEvent." .. arg_1_0)

	var_0_0[arg_1_0] = var_0_1
	var_0_1 = var_0_1 + 1
end

var_0_2("onWaveStart")
var_0_2("onRoundStart")
var_0_2("onMoveStep")
var_0_2("onFlush")
var_0_2("onWaveEnd")

return var_0_0
