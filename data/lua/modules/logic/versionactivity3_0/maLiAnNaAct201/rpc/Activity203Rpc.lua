module("modules.logic.versionactivity3_0.maLiAnNaAct201.rpc.Activity203Rpc", package.seeall)

local var_0_0 = class("Activity203Rpc", BaseRpc)

var_0_0.instance = var_0_0.New()

function var_0_0.sendGetAct203InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity203Module_pb.GetAct203InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct203InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity201MaLiAnNaModel.instance:initInfos(arg_2_2.episodes)
end

function var_0_0.sendGetAct203FinishEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity203Module_pb.Act203FinishEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	var_3_0.progress = ""

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct203FinishEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity201MaLiAnNaModel.instance:updateInfoFinish(arg_4_2.episodeId)
end

function var_0_0.onReceiveAct203EpisodePush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	Activity201MaLiAnNaModel.instance:updateInfos(arg_5_2.episodes)
end

function var_0_0.sendAct203SaveEpisodeProgressRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = Activity203Module_pb.Act203SaveEpisodeProgressRequest()

	var_6_0.activityId = arg_6_1
	var_6_0.episodeId = arg_6_2
	var_6_0.progress = "1"

	arg_6_0:sendMsg(var_6_0, arg_6_3, arg_6_4)
end

function var_0_0.onReceiveAct203SaveEpisodeProgressReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	Activity201MaLiAnNaModel.instance:updateInfoFinishGame(arg_7_2)
end

return var_0_0
