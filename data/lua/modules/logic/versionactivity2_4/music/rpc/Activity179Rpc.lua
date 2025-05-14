module("modules.logic.versionactivity2_4.music.rpc.Activity179Rpc", package.seeall)

local var_0_0 = class("Activity179Rpc", BaseRpc)

function var_0_0.sendGet179InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity179Module_pb.Get179InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet179InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.activityId
	local var_2_1 = arg_2_2.act179EpisodeNO

	Activity179Model.instance:initEpisodeList(var_2_1)
end

function var_0_0.sendSet179ScoreRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Activity179Module_pb.Set179ScoreRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	var_3_0.score = arg_3_3

	arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveSet179ScoreReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.act179EpisodeNO

	Activity179Model.instance:updateEpisode(var_4_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
