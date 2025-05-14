module("modules.logic.versionactivity1_6.v1a6_warmup.rpc.Activity156Rpc", package.seeall)

local var_0_0 = class("Activity156Rpc", BaseRpc)

function var_0_0.sendGetAct125InfosRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity125Module_pb.GetAct125InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetAct125InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity156Model.instance:setActivityInfo(arg_2_2.act125Episodes)
		Activity156Controller.instance:dispatchEvent(Activity156Event.DataUpdate)
	end
end

function var_0_0.sendFinishAct125EpisodeRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity125Module_pb.FinishAct125EpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2
	var_3_0.targetFrequency = 0

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveFinishAct125EpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity156Model.instance:setActivityInfo(arg_4_2.updateAct125Episodes)
		Activity156Controller.instance:dispatchEvent(Activity156Event.DataUpdate)
		Activity156Controller.instance:dispatchEvent(Activity156Event.EpisodeFinished, arg_4_2.episodeId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
