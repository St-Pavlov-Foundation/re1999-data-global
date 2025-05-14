module("modules.logic.activity.rpc.ActivityRpc", package.seeall)

local var_0_0 = class("ActivityRpc", BaseRpc)

function var_0_0.sendGetActivityInfosRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ActivityModule_pb.GetActivityInfosRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetActivityInfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		ActivityModel.instance:setActivityInfo(arg_2_2)
		ActivityController.instance:checkGetActivityInfo()
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState)
	end
end

function var_0_0.onReceiveUpdateActivityPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		ServerTime.update(arg_3_2.time)
		ActivityModel.instance:updateActivityInfo(arg_3_2.activityInfo)
		ActivityController.instance:updateAct101Infos(arg_3_2.activityInfo.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.UpdateActivity, arg_3_2.activityInfo.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, arg_3_2.activityInfo.id)
	end
end

function var_0_0.onReceiveEndActivityPush(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		ActivityModel.instance:endActivity(arg_4_2.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, arg_4_2.id)
	end
end

function var_0_0.sendActivityNewStageReadRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_1 then
		return
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_1 = ActivityModel.instance:getActivityInfo()[iter_5_1]

		if var_5_1 and var_5_1:isNewStageOpen() then
			table.insert(var_5_0, iter_5_1)
		end
	end

	if #var_5_0 < 1 then
		if arg_5_2 then
			arg_5_2(arg_5_3)
		end

		return
	end

	local var_5_2 = ActivityModule_pb.ActivityNewStageReadRequest()

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		if iter_5_3 ~= ActivityEnum.PlaceholderActivityId then
			table.insert(var_5_2.id, iter_5_3)
		end
	end

	return arg_5_0:sendMsg(var_5_2, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveActivityNewStageReadReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
	end
end

function var_0_0.sendUnlockPermanentRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = ActivityModule_pb.UnlockPermanentRequest()

	var_7_0.id = arg_7_1

	arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveUnlockPermanentReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		ActivityModel.instance:setPermanentUnlock(arg_8_2.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.UnlockPermanent, arg_8_2.id)
	end
end

function var_0_0.sendGetActivityInfosWithParamRequest(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or {}

	local var_9_0 = ActivityModule_pb.GetActivityInfosWithParamRequest()

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		table.insert(var_9_0.activityIds, iter_9_1)
	end

	return arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveGetActivityInfosWithParamReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_2.activityInfos) do
			ActivityModel.instance:updateInfoNoRepleace(iter_10_1)
		end

		ActivityController.instance:dispatchEvent(ActivityEvent.GetActivityInfoWithParamSuccess)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
