module("modules.logic.versionactivity.rpc.Activity112Rpc", package.seeall)

local var_0_0 = class("Activity112Rpc", BaseRpc)

function var_0_0.sendGet112InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity112Module_pb.Get112InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet112InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		VersionActivity112Model.instance:updateInfo(arg_2_2)
	end
end

function var_0_0.sendExchange112Request(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity112Module_pb.Exchange112Request()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveExchange112Reply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		VersionActivity112Model.instance:updateRewardState(arg_4_2.activityId, arg_4_2.id)
	end
end

function var_0_0.onReceiveAct112TaskPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		VersionActivity112TaskListModel.instance:updateTaskInfo(arg_5_2.activityId, arg_5_2.act112Tasks)
	end
end

function var_0_0.sendReceiveAct112TaskRewardRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = Activity112Module_pb.ReceiveAct112TaskRewardRequest()

	var_6_0.activityId = arg_6_1
	var_6_0.taskId = arg_6_2

	return arg_6_0:sendMsg(var_6_0, arg_6_3, arg_6_4)
end

function var_0_0.onReceiveReceiveAct112TaskRewardReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		VersionActivity112TaskListModel.instance:setGetBonus(arg_7_2.activityId, arg_7_2.taskId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
