module("modules.logic.rouge.dlc.101.view.RougeResultReViewLimiterBuff", package.seeall)

local var_0_0 = class("RougeResultReViewLimiterBuff", RougeLimiterBuffEntry)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._totalRiskValue = arg_1_1
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.getTotalRiskValue(arg_4_0)
	return arg_4_0._totalRiskValue
end

return var_0_0
