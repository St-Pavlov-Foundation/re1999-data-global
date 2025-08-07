module("modules.logic.sp01.act204.view.Activity204ChaseEntranceItem", package.seeall)

local var_0_0 = class("Activity204ChaseEntranceItem", Activity204EntranceItemBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
end

function var_0_0.initActInfo(arg_4_0, arg_4_1)
	var_0_0.super.initActInfo(arg_4_0, arg_4_1)

	arg_4_0._fakeEndTimeStamp = AssassinChaseHelper.getActivityEndTimeStamp(arg_4_0._endTime)
end

function var_0_0._getTimeStr(arg_5_0)
	if not arg_5_0._actMo then
		return
	end

	local var_5_0 = arg_5_0:_getActivityStatus()

	return arg_5_0:_decorateTimeStr(var_5_0, arg_5_0._startTime, arg_5_0._fakeEndTimeStamp)
end

function var_0_0._getActivityStatus(arg_6_0)
	local var_6_0, var_6_1 = var_0_0.super._getActivityStatus(arg_6_0)

	if var_6_0 == ActivityEnum.ActivityStatus.Normal then
		local var_6_2 = AssassinChaseModel.instance:isActOpen(arg_6_0._actId, false, false)
		local var_6_3 = AssassinChaseModel.instance:isActHaveReward(arg_6_0._actId)
		local var_6_4 = var_6_2 or var_6_3

		var_6_0 = var_6_4 and ActivityEnum.ActivityStatus.Normal or ActivityEnum.ActivityStatus.Expired
		var_6_1 = var_6_4 and var_6_1 or ToastEnum.ActivityEnd
	end

	return var_6_0, var_6_1
end

return var_0_0
