module("modules.logic.summon.model.SummonCustomPickModel", package.seeall)

local var_0_0 = class("SummonCustomPickModel", BaseModel)

function var_0_0.isCustomPickOver(arg_1_0, arg_1_1)
	local var_1_0 = SummonMainModel.instance:getPoolServerMO(arg_1_1)

	if var_1_0 and var_1_0.customPickMO then
		return var_1_0.customPickMO:isPicked(arg_1_1)
	end

	return false
end

function var_0_0.isHaveFirstSSR(arg_2_0, arg_2_1)
	local var_2_0 = SummonMainModel.instance:getPoolServerMO(arg_2_1)

	if var_2_0 and var_2_0.customPickMO then
		return var_2_0.customPickMO:isHaveFirstSSR()
	end

	return false
end

function var_0_0.getMaxSelectCount(arg_3_0, arg_3_1)
	local var_3_0 = SummonConfig.instance:getSummonPool(arg_3_1)
	local var_3_1 = -1

	if var_3_0 then
		if var_3_0.type == SummonEnum.Type.StrongCustomOnePick then
			var_3_1 = 1
		else
			local var_3_2 = string.split(var_3_0.param, "|")

			if var_3_2 and #var_3_2 > 0 then
				var_3_1 = tonumber(var_3_2[1]) or 0
			end
		end
	end

	return var_3_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
