module("modules.logic.versionactivity1_5.act146.rpc.Activity146Rpc", package.seeall)

local var_0_0 = class("Activity146Rpc", BaseRpc)

function var_0_0.sendGetAct146InfosRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity146Module_pb.GetAct146InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetAct146InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity146Model.instance:setActivityInfo(arg_2_2.act146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

function var_0_0.sendFinishAct146EpisodeRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity146Module_pb.FinishAct146EpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveFinishAct146EpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity146Model.instance:setActivityInfo(arg_4_2.updateAct146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

function var_0_0.sendAct146EpisodeBonusRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Activity146Module_pb.Act146EpisodeBonusRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveAct146EpisodeBonusReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Activity146Model.instance:setActivityInfo(arg_6_2.updateAct146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
