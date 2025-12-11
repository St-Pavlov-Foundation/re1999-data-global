module("modules.logic.versionactivity3_1.yeshumei.rpc.YeShuMeiRpc", package.seeall)

local var_0_0 = class("YeShuMeiRpc", BaseRpc)

var_0_0.instance = var_0_0.New()

function var_0_0.sendGetAct211InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity211Module_pb.GetAct211InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct211InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	YeShuMeiModel.instance:initInfos(arg_2_2.episodes)
end

function var_0_0.sendGetAct211FinishEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity211Module_pb.Act211FinishEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	var_3_0.progress = ""

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct211FinishEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	YeShuMeiModel.instance:updateInfoFinish(arg_4_2.episodeId)
end

function var_0_0.onReceiveAct211EpisodePush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	YeShuMeiModel.instance:updateInfos(arg_5_2.episodes)
end

function var_0_0.sendAct211SaveEpisodeProgressRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = Activity211Module_pb.Act211SaveEpisodeProgressRequest()

	var_6_0.activityId = arg_6_1
	var_6_0.episodeId = arg_6_2
	var_6_0.progress = "1"

	arg_6_0:sendMsg(var_6_0, arg_6_3, arg_6_4)
end

function var_0_0.onReceiveAct211SaveEpisodeProgressReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	YeShuMeiModel.instance:updateInfoFinishGame(arg_7_2)
end

return var_0_0
