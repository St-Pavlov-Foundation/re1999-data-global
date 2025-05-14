module("modules.logic.versionactivity1_4.act129.model.Activity129Mo", package.seeall)

local var_0_0 = class("Activity129Mo")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1
	arg_1_0.id = arg_1_1

	arg_1_0:initCfg()
end

function var_0_0.initCfg(arg_2_0)
	arg_2_0.poolDict = {}

	local var_2_0 = Activity129Config.instance:getPoolDict(arg_2_0.activityId)

	if var_2_0 then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			arg_2_0.poolDict[iter_2_1.poolId] = Activity129PoolMo.New(iter_2_1)
		end
	end
end

function var_0_0.init(arg_3_0, arg_3_1)
	for iter_3_0 = 1, #arg_3_1.lotteryDetail do
		local var_3_0 = arg_3_1.lotteryDetail[iter_3_0]
		local var_3_1 = arg_3_0:getPoolMo(var_3_0.poolId)

		if var_3_1 then
			var_3_1:init(var_3_0)
		else
			logError(string.format("cant find poolCfg，poolId:%s", var_3_0.poolId))
		end
	end
end

function var_0_0.onLotterySuccess(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getPoolMo(arg_4_1.poolId)

	if var_4_0 then
		var_4_0:onLotterySuccess(arg_4_1)
	else
		logError(string.format("cant find poolCfg，poolId:%s", arg_4_1.poolId))
	end
end

function var_0_0.getPoolMo(arg_5_0, arg_5_1)
	return arg_5_0.poolDict[arg_5_1]
end

function var_0_0.checkPoolIsEmpty(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getPoolMo(arg_6_1)

	return var_6_0 and var_6_0:checkPoolIsEmpty()
end

return var_0_0
