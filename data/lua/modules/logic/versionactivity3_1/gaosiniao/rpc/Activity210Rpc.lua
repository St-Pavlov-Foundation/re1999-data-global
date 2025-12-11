module("modules.logic.versionactivity3_1.gaosiniao.rpc.Activity210Rpc", package.seeall)

local var_0_0 = class("Activity210Rpc", BaseRpc)

function var_0_0.sendGetAct210InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity210Module_pb.GetAct210InfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct210InfoReply(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_onReceiveGetAct210InfoReply(arg_2_1, arg_2_2)
end

function var_0_0.sendAct210SaveEpisodeProgressRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Activity210Module_pb.Act210SaveEpisodeProgressRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	var_3_0.progress = arg_3_3 or ""

	return arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveAct210SaveEpisodeProgressReply(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:_onReceiveAct210SaveEpisodeProgressReply(arg_4_1, arg_4_2)
end

function var_0_0.sendAct210FinishEpisodeRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = Activity210Module_pb.Act210FinishEpisodeRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2
	var_5_0.progress = arg_5_3 or ""

	return arg_5_0:sendMsg(var_5_0, arg_5_4, arg_5_5)
end

function var_0_0.onReceiveAct210FinishEpisodeReply(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:_onReceiveAct210FinishEpisodeReply(arg_6_1, arg_6_2)
end

function var_0_0.sendAct210ChooseEpisodeBranchRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = Activity210Module_pb.Act210ChooseEpisodeBranchRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.episodeId = arg_7_2
	var_7_0.branchId = arg_7_3

	return arg_7_0:sendMsg(var_7_0, arg_7_4, arg_7_5)
end

function var_0_0.onReceiveAct210ChooseEpisodeBranchReply(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:_onReceiveAct210ChooseEpisodeBranchReply(arg_8_1, arg_8_2)
end

function var_0_0.onReceiveAct210EpisodePush(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:_onReceiveAct210EpisodePush(arg_9_1, arg_9_2)
end

return var_0_0
