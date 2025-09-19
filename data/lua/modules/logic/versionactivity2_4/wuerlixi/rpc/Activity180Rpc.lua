module("modules.logic.versionactivity2_4.wuerlixi.rpc.Activity180Rpc", package.seeall)

local var_0_0 = class("Activity180Rpc", BaseRpc)

function var_0_0.sendGet180InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity180Module_pb.Get180InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet180InfosReply(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.sendAct180EnterEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity180Module_pb.Act180EnterEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct180EnterEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_0.sendAct180StoryRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity180Module_pb.Act180StoryRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct180StoryReply(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_0.sendAct180GameFinishRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity180Module_pb.Act180GameFinishRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.episodeId = arg_7_2

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveAct180GameFinishReply(arg_8_0, arg_8_1, arg_8_2)
	return
end

function var_0_0.sendAct180SaveGameRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = Activity180Module_pb.Act180SaveGameRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.episodeId = arg_9_2
	var_9_0.gameData = arg_9_3

	arg_9_0:sendMsg(var_9_0, arg_9_4, arg_9_5)
end

function var_0_0.onReceiveAct180SaveGameReply(arg_10_0, arg_10_1, arg_10_2)
	return
end

function var_0_0.onReceiveAct180EpisodePush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		if arg_11_2.activityId == VersionActivity2_4Enum.ActivityId.WuErLiXi then
			WuErLiXiModel.instance:updateInfos(arg_11_2.act180Episodes)
		elseif arg_11_2.activityId == VersionActivity2_8Enum.ActivityId.NuoDiKa then
			NuoDiKaModel.instance:updateInfos(arg_11_2.act180Episodes)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
