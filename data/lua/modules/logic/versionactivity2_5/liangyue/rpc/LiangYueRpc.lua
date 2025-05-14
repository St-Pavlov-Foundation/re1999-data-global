module("modules.logic.versionactivity2_5.liangyue.rpc.LiangYueRpc", package.seeall)

local var_0_0 = class("LiangYueRpc", BaseRpc)

function var_0_0.sendGetAct184InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity184Module_pb.GetAct184InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct184InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.activityId
	local var_2_1 = arg_2_2.episodes

	LiangYueModel.instance:onGetActInfo(arg_2_2)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnReceiveEpisodeInfo)
end

function var_0_0.sendAct184FinishEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Activity184Module_pb.Act184FinishEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	var_3_0.puzzle = arg_3_3 or ""

	arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveAct184FinishEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.episodeId

	LiangYueModel.instance:setEpisodeInfo(arg_4_2)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnFinishEpisode, var_4_0, var_4_1)
end

function var_0_0.onReceiveAct184EpisodePush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	local var_5_0 = arg_5_2.activityId
	local var_5_1 = arg_5_2.episodes

	LiangYueModel.instance:onActInfoPush(arg_5_2)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeInfoPush)
end

var_0_0.instance = var_0_0.New()

return var_0_0
