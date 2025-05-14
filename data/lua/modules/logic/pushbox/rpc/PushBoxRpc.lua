module("modules.logic.pushbox.rpc.PushBoxRpc", package.seeall)

local var_0_0 = class("PushBoxRpc", BaseRpc)

function var_0_0.sendGet111InfosRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Activity111Module_pb.Get111InfosRequest()

	var_1_0.activityId = 11113

	arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGet111InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		PushBoxModel.instance:onReceiveGet111InfosReply(arg_2_2)
	end
end

function var_0_0.sendFinishEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity111Module_pb.FinishEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	var_3_0.step = arg_3_3
	var_3_0.alarm = arg_3_4

	local var_3_1 = ServerTime.now()

	for iter_3_0 = 1, 6 do
		var_3_1 = var_3_1 .. math.random(0, 9)
	end

	var_3_0.timestamp = var_3_1
	var_3_0.sign = GameLuaMD5.sumhexa(string.format("%s#%s#%s#%s#%s#%s", arg_3_1, arg_3_2, arg_3_3, arg_3_4, var_3_1, LoginModel.instance.sessionId))

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveFinishEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	PushBoxModel.instance:onReceiveFinishEpisodeReply(arg_4_1, arg_4_2)
end

function var_0_0.onReceiveAct111InfoPush(arg_5_0, arg_5_1, arg_5_2)
	PushBoxModel.instance:onReceiveAct111InfoPush(arg_5_2)
end

function var_0_0.onReceivePushBoxTaskPush(arg_6_0, arg_6_1, arg_6_2)
	PushBoxModel.instance:onReceivePushBoxTaskPush(arg_6_2)
end

function var_0_0.sendReceiveTaskRewardRequest(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = Activity111Module_pb.ReceiveTaskRewardRequest()

	var_7_0.activityId = arg_7_1 or PushBoxModel.instance:getCurActivityID()
	var_7_0.taskId = arg_7_2

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveReceiveTaskRewardReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		PushBoxModel.instance:onReceiveReceiveTaskRewardReply(arg_8_2)
	end
end

setGlobal("Activity111Rpc", var_0_0)

var_0_0.instance = var_0_0.New()

return var_0_0
