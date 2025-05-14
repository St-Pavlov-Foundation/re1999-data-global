module("modules.logic.toughbattle.rpc.Activity158Rpc", package.seeall)

local var_0_0 = class("Activity158Rpc", BaseRpc)

function var_0_0.sendGet158InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity158Module_pb.Get158InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet158InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		ToughBattleModel.instance:onGetActInfo(arg_2_2.info)
	end
end

function var_0_0.sendAct158StartChallengeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity158Module_pb.Act158StartChallengeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.difficulty = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct158StartChallengeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		ToughBattleModel.instance:onGetActInfo(arg_4_2.info)
	end
end

function var_0_0.sendAct158AbandonChallengeRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Activity158Module_pb.Act158AbandonChallengeRequest()

	var_5_0.activityId = arg_5_1

	return arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveAct158AbandonChallengeReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		ToughBattleModel.instance:onGetActInfo(arg_6_2.info)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
