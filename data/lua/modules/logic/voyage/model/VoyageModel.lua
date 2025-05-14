module("modules.logic.voyage.model.VoyageModel", package.seeall)

local var_0_0 = class("VoyageModel", Activity1001Model)

function var_0_0.reInit(arg_1_0)
	var_0_0.super.reInit(arg_1_0)

	local var_1_0 = VoyageConfig.instance
	local var_1_1 = var_1_0:getActivityId()

	arg_1_0:_internal_set_config(var_1_0)
	arg_1_0:_internal_set_activity(var_1_1)
end

function var_0_0.hasAnyRewardAvailable(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.__id2StateDict) do
		if iter_2_1 == VoyageEnum.State.Available then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
