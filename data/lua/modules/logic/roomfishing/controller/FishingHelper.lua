module("modules.logic.roomfishing.controller.FishingHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getFishingProgress(arg_1_0, arg_1_1)
	local var_1_0 = 0

	if arg_1_0 and arg_1_1 and arg_1_0 > 0 and arg_1_1 > 0 and arg_1_0 < arg_1_1 then
		local var_1_1 = ServerTime.now()
		local var_1_2 = Mathf.Clamp((var_1_1 - arg_1_0) / (arg_1_1 - arg_1_0), 0, 1)

		var_1_0 = tonumber(string.format("%.2f", var_1_2)) * 100
	end

	return var_1_0
end

function var_0_0.isFishingFinished(arg_2_0, arg_2_1)
	local var_2_0 = false

	if arg_2_0 and arg_2_1 and arg_2_0 > 0 and arg_2_1 > 0 then
		var_2_0 = arg_2_1 < ServerTime.now()
	end

	return var_2_0
end

return var_0_0
