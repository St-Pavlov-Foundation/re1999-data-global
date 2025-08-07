module("modules.logic.activity.model.V2a9FreeMonthCardModel", package.seeall)

local var_0_0 = class("V2a9FreeMonthCardModel", BaseModel)

var_0_0.LoginMaxDay = 30

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getRewardTotalDay(arg_3_0)
	local var_3_0 = 0
	local var_3_1 = ActivityEnum.Activity.V2a9_FreeMonthCard
	local var_3_2 = ActivityType101Model.instance:getType101LoginCount(var_3_1)

	for iter_3_0 = var_3_2 <= var_0_0.LoginMaxDay and var_3_2 or var_0_0.LoginMaxDay, 1, -1 do
		if not ActivityType101Model.instance:isType101RewardCouldGet(var_3_1, iter_3_0) then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

function var_0_0.getCurDay(arg_4_0)
	local var_4_0 = ActivityEnum.Activity.V2a9_FreeMonthCard
	local var_4_1 = ActivityType101Model.instance:getType101LoginCount(var_4_0)
	local var_4_2 = ActivityType101Model.instance:isType101RewardCouldGet(var_4_0, var_4_1)

	if var_4_1 <= var_0_0.LoginMaxDay then
		return var_4_1
	end

	if var_4_2 then
		for iter_4_0 = var_4_1 <= var_0_0.LoginMaxDay and var_4_1 or var_0_0.LoginMaxDay, 1, -1 do
			if ActivityType101Model.instance:isType101RewardCouldGet(var_4_0, iter_4_0) then
				return iter_4_0
			end
		end
	end

	return 0
end

function var_0_0.isCurDayCouldGet(arg_5_0)
	local var_5_0 = ActivityEnum.Activity.V2a9_FreeMonthCard
	local var_5_1 = ActivityType101Model.instance:getType101LoginCount(var_5_0)

	if var_5_1 <= 0 then
		return false
	end

	local var_5_2 = var_0_0.instance:getCurDay()

	if var_5_2 <= 0 then
		return false
	end

	if ActivityType101Model.instance:isType101RewardCouldGet(var_5_0, var_5_1) and var_5_2 <= var_0_0.LoginMaxDay then
		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
