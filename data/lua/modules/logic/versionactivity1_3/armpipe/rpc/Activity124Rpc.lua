module("modules.logic.versionactivity1_3.armpipe.rpc.Activity124Rpc", package.seeall)

local var_0_0 = class("Activity124Rpc", BaseRpc)

function var_0_0.sendGetAct124InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity124Module_pb.GetAct124InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct124InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity124Model.instance:onReceiveGetAct120InfoReply(arg_2_2)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshMapData)
	end
end

function var_0_0.sendFinishAct124EpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity124Module_pb.FinishAct124EpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	var_3_0.timestamp = arg_3_3 or ""
	var_3_0.sign = arg_3_4 or ""

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveFinishAct124EpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity124Model.instance:onReceiveFinishAct124EpisodeReply(arg_4_2)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshEpisode, arg_4_2.episodeId)
	end
end

function var_0_0.sendReceiveAct124RewardRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Activity124Module_pb.ReceiveAct124RewardRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveReceiveAct124RewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Activity124Model.instance:onReceiveReceiveAct124RewardReply(arg_6_2)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshReceiveReward, arg_6_2.episodeId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
