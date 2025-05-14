module("modules.logic.dragonboat.model.DragonBoatFestivalModel", package.seeall)

local var_0_0 = class("DragonBoatFestivalModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curDay = nil
end

function var_0_0.hasRewardNotGet(arg_3_0)
	local var_3_0 = ActivityEnum.Activity.DragonBoatFestival
	local var_3_1 = ActivityConfig.instance:getNorSignActivityCos(var_3_0)

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		if arg_3_0:isGiftUnlock(iter_3_1.id) and not arg_3_0:isGiftGet(iter_3_1.id) then
			return true
		end
	end

	return false
end

function var_0_0.setCurDay(arg_4_0, arg_4_1)
	arg_4_0._curDay = arg_4_1
end

function var_0_0.getCurDay(arg_5_0)
	local var_5_0 = arg_5_0._curDay or arg_5_0:getFinalGiftGetDay()

	return var_5_0 > arg_5_0:getMaxDay() and arg_5_0:getMaxDay() or var_5_0
end

function var_0_0.getFinalGiftGetDay(arg_6_0)
	local var_6_0 = ActivityEnum.Activity.DragonBoatFestival
	local var_6_1 = ActivityConfig.instance:getNorSignActivityCos(var_6_0)
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		if arg_6_0:isGiftUnlock(iter_6_1.id) and arg_6_0:isGiftGet(iter_6_1.id) then
			table.insert(var_6_2, iter_6_1.id)
		end
	end

	if GameUtil.getTabLen(var_6_2) > 0 then
		return var_6_2[#var_6_2]
	else
		return arg_6_0:getLoginCount()
	end
end

function var_0_0.isGiftGet(arg_7_0, arg_7_1)
	local var_7_0 = ActivityEnum.Activity.DragonBoatFestival

	if arg_7_1 > arg_7_0:getMaxDay() then
		return false
	end

	return ActivityType101Model.instance:isType101RewardGet(var_7_0, arg_7_1)
end

function var_0_0.isGiftUnlock(arg_8_0, arg_8_1)
	return arg_8_1 <= arg_8_0:getLoginCount()
end

function var_0_0.getMaxDay(arg_9_0)
	local var_9_0 = DragonBoatFestivalConfig.instance:getDragonBoatCos()
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		var_9_1 = var_9_1 > iter_9_1.day and var_9_1 or iter_9_1.day
	end

	return var_9_1
end

function var_0_0.getLoginCount(arg_10_0)
	local var_10_0 = ActivityEnum.Activity.DragonBoatFestival

	return (ActivityType101Model.instance:getType101LoginCount(var_10_0))
end

function var_0_0.getMaxUnlockDay(arg_11_0)
	return arg_11_0:getLoginCount() <= arg_11_0:getMaxDay() and arg_11_0:getLoginCount() or arg_11_0:getMaxDay()
end

var_0_0.instance = var_0_0.New()

return var_0_0
