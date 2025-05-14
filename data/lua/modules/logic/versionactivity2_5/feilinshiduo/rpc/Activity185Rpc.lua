module("modules.logic.versionactivity2_5.feilinshiduo.rpc.Activity185Rpc", package.seeall)

local var_0_0 = class("Activity185Rpc", BaseRpc)

function var_0_0.sendGetAct185InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity185Module_pb.GetAct185InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct185InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	FeiLinShiDuoModel.instance:initEpisodeFinishInfo(arg_2_2)
end

function var_0_0.sendAct185FinishEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity185Module_pb.Act185FinishEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct185FinishEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.episodeId

	FeiLinShiDuoModel.instance:setCurFinishEpisodeId(var_4_1)
	FeiLinShiDuoModel.instance:updateEpisodeFinishState(var_4_1, true)
end

function var_0_0.onReceiveAct185EpisodePush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	FeiLinShiDuoModel.instance:initEpisodeFinishInfo(arg_5_2)
	FeiLinShiDuoModel.instance:setNewUnlockEpisode(arg_5_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
