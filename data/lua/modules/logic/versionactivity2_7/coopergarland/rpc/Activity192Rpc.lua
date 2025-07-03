module("modules.logic.versionactivity2_7.coopergarland.rpc.Activity192Rpc", package.seeall)

local var_0_0 = class("Activity192Rpc", BaseRpc)

function var_0_0.sendGetAct192InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity192Module_pb.GetAct192InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct192InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	CooperGarlandController.instance:onGetAct192Info(arg_2_2)
end

function var_0_0.sendAct192FinishEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Activity192Module_pb.Act192FinishEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	arg_3_3 = arg_3_3 or CooperGarlandConfig.instance:isGameEpisode(arg_3_1, arg_3_2) and CooperGarlandEnum.Const.DefaultGameProgress or ""
	var_3_0.progress = arg_3_3

	arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveAct192FinishEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end
end

function var_0_0.onReceiveAct192EpisodePush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	CooperGarlandController.instance:onGetAct192Info(arg_5_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
