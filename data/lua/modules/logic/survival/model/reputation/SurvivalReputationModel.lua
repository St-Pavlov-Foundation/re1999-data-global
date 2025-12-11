module("modules.logic.survival.model.reputation.SurvivalReputationModel", package.seeall)

local var_0_0 = class("SurvivalReputationModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
end

function var_0_0.getSelectViewReputationAdd(arg_4_0, arg_4_1)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		var_4_0 = var_4_0 + iter_4_1:getExchangeReputationAmountTotal()
	end

	return var_4_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
