module("modules.logic.versionactivity1_2.trade.model.Activity117RewardMO", package.seeall)

local var_0_0 = pureTable("Activity117RewardMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.actId = arg_1_1.activityId
	arg_1_0.id = arg_1_1.id
	arg_1_0.needScore = arg_1_1.needScore
	arg_1_0.co = arg_1_1
	arg_1_0.rewardItems = arg_1_0:getRewardItems()

	arg_1_0:resetData()
end

function var_0_0.resetData(arg_2_0)
	arg_2_0.alreadyGot = false
end

function var_0_0.updateServerData(arg_3_0, arg_3_1)
	arg_3_0.alreadyGot = arg_3_1
end

function var_0_0.getRewardItems(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = string.split(arg_4_0.co.bonus, "|")

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		var_4_0[iter_4_0] = string.splitToNumber(iter_4_1, "#")
	end

	return var_4_0
end

function var_0_0.getStatus(arg_5_0)
	if arg_5_0.alreadyGot then
		return Activity117Enum.Status.AlreadyGot
	end

	if Activity117Model.instance:getCurrentScore(arg_5_0.actId) >= arg_5_0.needScore then
		return Activity117Enum.Status.CanGet
	end

	return Activity117Enum.Status.NotEnough
end

function var_0_0.sortFunc(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getStatus()
	local var_6_1 = arg_6_1:getStatus()

	if var_6_0 ~= var_6_1 then
		return var_6_0 < var_6_1
	end

	return arg_6_0.id < arg_6_1.id
end

return var_0_0
