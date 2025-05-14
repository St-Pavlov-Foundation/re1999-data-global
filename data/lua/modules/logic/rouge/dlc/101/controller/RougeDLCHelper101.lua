module("modules.logic.rouge.dlc.101.controller.RougeDLCHelper101", package.seeall)

local var_0_0 = class("RougeDLCHelper101")

function var_0_0.getLimiterBuffSpeedupCost(arg_1_0)
	local var_1_0 = var_0_0._getOrCreateBuffSpeedupCostMap()

	return var_1_0 and var_1_0[arg_1_0] or 0
end

function var_0_0._getOrCreateBuffSpeedupCostMap()
	if not var_0_0._costMap then
		local var_2_0 = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.SpeedupCost]
		local var_2_1 = var_2_0 and var_2_0.value
		local var_2_2 = GameUtil.splitString2(var_2_1, true)

		var_0_0._costMap = {}

		for iter_2_0, iter_2_1 in ipairs(var_2_2 or {}) do
			local var_2_3 = iter_2_1[1]
			local var_2_4 = iter_2_1[2]

			var_0_0._costMap[var_2_3] = var_2_4
		end
	end

	return var_0_0._costMap
end

function var_0_0.isLimiterRisker(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 ~= nil

	if arg_3_0 and arg_3_1 then
		local var_3_1, var_3_2 = var_0_0._getRiskRange(arg_3_0)

		var_3_0 = var_3_2 < var_0_0._getRiskRange(arg_3_1)
	end

	return var_3_0
end

function var_0_0._getRiskRange(arg_4_0)
	if not arg_4_0 then
		return
	end

	local var_4_0 = string.splitToNumber(arg_4_0.range, "#")
	local var_4_1 = var_4_0[1] or 0
	local var_4_2 = var_4_0[2] or 0

	return var_4_1, var_4_2
end

function var_0_0.isNearLimiter(arg_5_0, arg_5_1)
	local var_5_0 = false

	if arg_5_0 and arg_5_1 then
		local var_5_1, var_5_2 = var_0_0._getRiskRange(arg_5_0)
		local var_5_3, var_5_4 = var_0_0._getRiskRange(arg_5_1)

		var_5_0 = math.abs(var_5_3 - var_5_2) <= 1 or math.abs(var_5_1 - var_5_4) <= 1
	end

	return var_5_0
end

return var_0_0
