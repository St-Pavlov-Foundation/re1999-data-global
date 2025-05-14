module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessFightResultMO", package.seeall)

local var_0_0 = class("WarChessFightResultMO")

function var_0_0.updateInfo(arg_1_0, arg_1_1)
	arg_1_0.resultCode = arg_1_1.resultCode

	if not string.nilorempty(arg_1_1.extraData) then
		arg_1_0.result = cjson.decode(arg_1_1.extraData)
	end
end

function var_0_0.getResultInfo(arg_2_0)
	return arg_2_0.result and arg_2_0.result or {}
end

function var_0_0.getRewardCount(arg_3_0)
	local var_3_0 = 0

	if arg_3_0.result then
		for iter_3_0, iter_3_1 in pairs(arg_3_0.result) do
			if iter_3_0 ~= "star" then
				var_3_0 = var_3_0 + tabletool.len(iter_3_1)
			end
		end
	end

	return var_3_0
end

function var_0_0.getStar(arg_4_0)
	local var_4_0 = 0

	if arg_4_0.result then
		var_4_0 = tonumber(arg_4_0.result.star)
	end

	return var_4_0
end

function var_0_0.haveReward(arg_5_0)
	return arg_5_0:getRewardCount() > 0
end

return var_0_0
