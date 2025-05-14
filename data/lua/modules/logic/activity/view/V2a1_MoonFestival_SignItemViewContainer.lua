module("modules.logic.activity.view.V2a1_MoonFestival_SignItemViewContainer", package.seeall)

local var_0_0 = class("V2a1_MoonFestival_SignItemViewContainer", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = V2a1_MoonFestival_SignItem
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -16
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

	if not ActivityModel.instance:getActMO(var_4_0) then
		return
	end

	local var_4_1 = ActivityType101Config.instance:getMoonFestivalSignMaxDay(var_4_0)

	if var_4_1 <= 0 then
		return
	end

	local var_4_2 = ActivityType101Model.instance:getType101LoginCount(var_4_0)
	local var_4_3 = GameUtil.clamp(var_4_2, 1, var_4_1)

	return ActivityType101Config.instance:getMoonFestivalByDay(var_4_0, var_4_3)
end

function var_0_0.isNone(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:actId()

	return ActivityType101Model.instance:isType101SpRewardUncompleted(var_5_0, arg_5_1)
end

function var_0_0.isFinishedTask(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:actId()

	return ActivityType101Model.instance:isType101SpRewardGot(var_6_0, arg_6_1)
end

function var_0_0.isRewardable(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:actId()

	return ActivityType101Model.instance:isType101SpRewardCouldGet(var_7_0, arg_7_1)
end

function var_0_0.sendGet101SpBonusRequest(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getCurrentTaskCO()

	if not var_8_0 then
		return
	end

	local var_8_1 = arg_8_0:actId()
	local var_8_2 = var_8_0.id

	if not ActivityType101Model.instance:isType101SpRewardCouldGet(var_8_1, var_8_2) then
		return
	end

	Activity101Rpc.instance:sendGet101SpBonusRequest(var_8_1, var_8_2, arg_8_1, arg_8_2)

	return true
end

return var_0_0
