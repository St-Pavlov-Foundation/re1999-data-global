module("modules.logic.versionactivity2_8.molideer.rpc.MoLiDeErRpc", package.seeall)

local var_0_0 = class("MoLiDeErRpc", BaseRpc)

function var_0_0.sendAct194GetInfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity194Module_pb.Act194GetInfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveAct194GetInfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.activityId
	local var_2_1 = arg_2_2.episodeRecords

	MoLiDeErModel.instance:onGetActInfo(arg_2_2)
end

function var_0_0.sendAct194EnterEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity194Module_pb.Act194EnterEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct194EnterEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.episodeInfo

	MoLiDeErGameModel.instance:setEpisodeInfo(var_4_0, var_4_1)
end

function var_0_0.sendAct194FinishStoryEpisodeRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity194Module_pb.Act194FinishStoryEpisodeRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct194FinishStoryEpisodeReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.activityId
	local var_6_1 = arg_6_2.episodeId

	MoLiDeErController.instance:episodeFinish(var_6_0, var_6_1)
end

function var_0_0.sendAct194GetEpisodeInfoRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity194Module_pb.Act194GetEpisodeInfoRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.episodeId = arg_7_2

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveAct194GetEpisodeInfoReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.activityId
	local var_8_1 = arg_8_2.episodeInfo

	MoLiDeErGameModel.instance:setEpisodeInfo(var_8_0, var_8_1)
end

function var_0_0.sendAct194SendTeamExploreRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
	local var_9_0 = Activity194Module_pb.Act194SendTeamExploreRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.episodeId = arg_9_2
	var_9_0.eventId = arg_9_3
	var_9_0.teamId = arg_9_4
	var_9_0.optionId = arg_9_5

	arg_9_0:sendMsg(var_9_0, arg_9_6, arg_9_7)
end

function var_0_0.onReceiveAct194SendTeamExploreReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.activityId
	local var_10_1 = arg_10_2.episodeId
	local var_10_2 = arg_10_2.eventId

	MoLiDeErGameController.instance:onDispatchTeam(arg_10_2)
end

function var_0_0.sendAct194UseItemRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = Activity194Module_pb.Act194UseItemRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.episodeId = arg_11_2
	var_11_0.itemId = arg_11_3

	arg_11_0:sendMsg(var_11_0, arg_11_4, arg_11_5)
end

function var_0_0.onReceiveAct194UseItemReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.activityId
	local var_12_1 = arg_12_2.episodeId
	local var_12_2 = arg_12_2.itemId

	MoLiDeErGameController.instance:onUseItem(arg_12_2)
end

function var_0_0.sendAct194NextRoundRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = Activity194Module_pb.Act194NextRoundRequest()

	var_13_0.activityId = arg_13_1
	var_13_0.episodeId = arg_13_2

	arg_13_0:sendMsg(var_13_0, arg_13_3, arg_13_4)
end

function var_0_0.onReceiveAct194NextRoundReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	local var_14_0 = arg_14_2.activityId
	local var_14_1 = arg_14_2.episodeId
end

function var_0_0.sendAct194WithdrawTeamRequest(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = Activity194Module_pb.Act194WithdrawTeamRequest()

	var_15_0.activityId = arg_15_1
	var_15_0.episodeId = arg_15_2
	var_15_0.teamId = arg_15_3

	arg_15_0:sendMsg(var_15_0, arg_15_4, arg_15_5)
end

function var_0_0.onReceiveAct194WithdrawTeamReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	local var_16_0 = arg_16_2.activityId
	local var_16_1 = arg_16_2.episodeId
	local var_16_2 = arg_16_2.teamId

	MoLiDeErGameController.instance:onWithdrawReply(var_16_2)
end

function var_0_0.sendAct194ResetEpisodeRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = Activity194Module_pb.Act194ResetEpisodeRequest()

	var_17_0.activityId = arg_17_1
	var_17_0.episodeId = arg_17_2

	arg_17_0:sendMsg(var_17_0, arg_17_3, arg_17_4)
end

function var_0_0.onReceiveAct194ResetEpisodeReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	local var_18_0 = arg_18_2.activityId
	local var_18_1 = arg_18_2.episodeId
end

function var_0_0.sendAct194SkipEpisodeRequest(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = Activity194Module_pb.Act194SkipEpisodeRequest()

	var_19_0.activityId = arg_19_1
	var_19_0.episodeId = arg_19_2

	arg_19_0:sendMsg(var_19_0, arg_19_3, arg_19_4)
end

function var_0_0.onReceiveAct194SkipEpisodeReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		return
	end

	local var_20_0 = arg_20_2.activityId
	local var_20_1 = arg_20_2.episodeId

	MoLiDeErGameController.instance:onReceiveSkipGame(var_20_0, var_20_1)
end

function var_0_0.onReceiveAct194EpisodeRecordsPush(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		return
	end

	local var_21_0 = arg_21_2.activityId
	local var_21_1 = arg_21_2.episodeRecords

	MoLiDeErController.instance:onReceiveEpisodeInfo(var_21_0, var_21_1)
end

function var_0_0.onReceiveAct194EpisodeInfoPush(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 ~= 0 then
		return
	end

	local var_22_0 = arg_22_2.activityId
	local var_22_1 = arg_22_2.episodeId
	local var_22_2 = arg_22_2.isEpisodeFinish
	local var_22_3 = arg_22_2.passStar
	local var_22_4 = arg_22_2.episodeInfo

	MoLiDeErGameController.instance:onEpisodeInfoPush(arg_22_2)
end

function var_0_0.onReceiveAct194NewEventInfosPush(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= 0 then
		return
	end

	local var_23_0 = arg_23_2.activityId
	local var_23_1 = arg_23_2.episodeId
	local var_23_2 = arg_23_2.newEventInfos
end

function var_0_0.onReceiveAct194EpisodeFinishPush(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 ~= 0 then
		return
	end

	local var_24_0 = arg_24_2.activityId
	local var_24_1 = arg_24_2.episodeId
	local var_24_2 = arg_24_2.passStar
end

var_0_0.instance = var_0_0.New()

return var_0_0
