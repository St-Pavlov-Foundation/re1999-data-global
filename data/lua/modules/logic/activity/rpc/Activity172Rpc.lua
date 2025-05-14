module("modules.logic.activity.rpc.Activity172Rpc", package.seeall)

local var_0_0 = class("Activity172Rpc", BaseRpc)

function var_0_0.sendGetAct172InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity172Module_pb.GetAct172InfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct172InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	ActivityType172Model.instance:setType172Info(arg_2_2.activityId, arg_2_2.info)
end

function var_0_0.onReceiveAct172UseItemTaskIdsUpdatePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	ActivityType172Model.instance:updateType172Info(arg_3_2.activityId, arg_3_2.useItemTaskIds)
	ActivityController.instance:dispatchEvent(ActivityEvent.Act172TaskUpdate)
end

var_0_0.instance = var_0_0.New()

return var_0_0
