module("modules.logic.versionactivity1_5.peaceulu.rpc.PeaceUluRpc", package.seeall)

local var_0_0 = class("PeaceUluRpc", BaseRpc)

function var_0_0.sendGet145InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity145Module_pb.Get145InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet145InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(arg_2_2.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function var_0_0.onReceiveAct145InfoUpdatePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(arg_3_2.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function var_0_0.sendAct145RemoveTaskRequest(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Activity145Module_pb.Act145RemoveTaskRequest()

	var_4_0.activityId = arg_4_1
	var_4_0.taskId = arg_4_2

	arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveAct145RemoveTaskReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	PeaceUluModel.instance:onGetRemoveTask(arg_5_2)
end

function var_0_0.sendAct145GameRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = Activity145Module_pb.Act145GameRequest()

	var_6_0.activityId = arg_6_1
	var_6_0.content = arg_6_2

	arg_6_0:sendMsg(var_6_0)
end

function var_0_0.onReceiveAct145GameReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	PeaceUluModel.instance:onGetGameResult(arg_7_2)
end

function var_0_0.sendAct145GetRewardsRequest(arg_8_0, arg_8_1)
	local var_8_0 = Activity145Module_pb.Act145GetRewardsRequest()

	var_8_0.activityId = arg_8_1

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveAct145GetRewardsReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	PeaceUluModel.instance:onUpdateReward(arg_9_2)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function var_0_0.sendAct145ClearGameRecordRequest(arg_10_0, arg_10_1)
	local var_10_0 = Activity145Module_pb.Act145ClearGameRecordRequest()

	var_10_0.activityId = arg_10_1

	arg_10_0:sendMsg(var_10_0)
end

function var_0_0.onReceiveAct145ClearGameRecordReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(arg_11_2.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

var_0_0.instance = var_0_0.New()

return var_0_0
