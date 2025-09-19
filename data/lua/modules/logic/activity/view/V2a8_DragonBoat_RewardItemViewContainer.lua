module("modules.logic.activity.view.V2a8_DragonBoat_RewardItemViewContainer", package.seeall)

local var_0_0 = class("V2a8_DragonBoat_RewardItemViewContainer", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = V2a8_DragonBoat_RewardItem
	arg_1_1.cellWidth = 355
	arg_1_1.cellHeight = 638
	arg_1_1.cellSpaceH = 30
	arg_1_1.rectMaskSoftness = {
		30,
		0
	}
end

function var_0_0.onBuildViews(arg_2_0)
	return {
		(arg_2_0:getMainView())
	}
end

function var_0_0.getCurrentTaskCO(arg_3_0)
	local var_3_0 = arg_3_0:actId()

	return ActivityType101Config.instance:getMoonFestivalTaskCO(var_3_0)
end

function var_0_0.getCurrentDayCO(arg_4_0)
	local var_4_0 = arg_4_0:actId()
	local var_4_1 = ActivityType101Model.instance:getType101LoginCount(var_4_0)

	return arg_4_0:getDayCO(var_4_1)
end

function var_0_0.getDayCO(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:actId()

	if not ActivityModel.instance:getActMO(var_5_0) then
		return
	end

	local var_5_1 = ActivityType101Config.instance:getMoonFestivalSignMaxDay(var_5_0)

	if var_5_1 <= 0 then
		return
	end

	arg_5_1 = GameUtil.clamp(arg_5_1, 1, var_5_1)

	return ActivityType101Config.instance:getMoonFestivalByDay(var_5_0, arg_5_1)
end

function var_0_0.isNone(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:actId()

	return ActivityType101Model.instance:isType101SpRewardUncompleted(var_6_0, arg_6_1)
end

function var_0_0.isFinishedTask(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:actId()

	return ActivityType101Model.instance:isType101SpRewardGot(var_7_0, arg_7_1)
end

function var_0_0.isRewardable(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:actId()

	return ActivityType101Model.instance:isType101SpRewardCouldGet(var_8_0, arg_8_1)
end

function var_0_0.sendGet101SpBonusRequest(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getCurrentTaskCO()

	if not var_9_0 then
		return
	end

	local var_9_1 = arg_9_0:actId()
	local var_9_2 = var_9_0.id

	if not ActivityType101Model.instance:isType101SpRewardCouldGet(var_9_1, var_9_2) then
		return
	end

	Activity101Rpc.instance:sendGet101SpBonusRequest(var_9_1, var_9_2, arg_9_1, arg_9_2)

	return true
end

local var_0_1 = {
	Done = 1999,
	None = 0
}

function var_0_0._getPrefsKey(arg_10_0, arg_10_1)
	return arg_10_0:getPrefsKeyPrefix() .. tostring(arg_10_1)
end

function var_0_0.saveState(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:_getPrefsKey(arg_11_1)

	arg_11_0:saveInt(var_11_0, arg_11_2 or var_0_1.None)
end

function var_0_0.getState(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:_getPrefsKey(arg_12_1)

	return arg_12_0:getInt(var_12_0, arg_12_2 or var_0_1.None)
end

function var_0_0.saveStateDone(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:saveState(arg_13_1, arg_13_2 and var_0_1.Done or var_0_1.None)
end

function var_0_0.isStateDone(arg_14_0, arg_14_1)
	return arg_14_0:getState(arg_14_1) == var_0_1.Done
end

function var_0_0.isPlayAnimAvaliable(arg_15_0, arg_15_1)
	if arg_15_0:isType101RewardCouldGet(arg_15_1) then
		return not arg_15_0:isStateDone(arg_15_1)
	end

	return false
end

return var_0_0
