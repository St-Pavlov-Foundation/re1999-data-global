module("modules.logic.gm.controller.define.PerformanceRecordEvent", package.seeall)

local var_0_0 = _M
local var_0_1 = 1

;(function(arg_1_0)
	assert(var_0_0[arg_1_0] == nil, "[PerformanceRecordEvent] error redefined PerformanceRecordEvent." .. arg_1_0)

	var_0_0[arg_1_0] = var_0_1
	var_0_1 = var_0_1 + 1
end)("onRecordDone")

return var_0_0
