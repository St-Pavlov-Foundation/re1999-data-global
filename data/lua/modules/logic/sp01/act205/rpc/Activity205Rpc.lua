module("modules.logic.sp01.act205.rpc.Activity205Rpc", package.seeall)

local var_0_0 = class("Activity205Rpc", BaseRpc)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.sendAct205GetInfoRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity205Module_pb.Act205GetInfoRequest()

	var_3_0.activityId = arg_3_1

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveAct205GetInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Act205Model.instance:setAct205Info(arg_4_2)
	end

	Act205Controller.instance:dispatchEvent(Act205Event.OnInfoUpdate)
end

function var_0_0.sendAct205GetGameInfoRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Activity205Module_pb.Act205GetGameInfoRequest()

	var_5_0.activityId = arg_5_1

	return arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveAct205GetGameInfoReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Act205Model.instance:setAct205GameInfo(arg_6_2)
	end
end

function var_0_0.sendAct205FinishGameRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = Activity205Module_pb.Act205FinishGameRequest()

	var_7_0.activityId = arg_7_1.activityId
	var_7_0.gameType = arg_7_1.gameType
	var_7_0.gameInfo = arg_7_1.gameInfo
	var_7_0.rewardId = arg_7_1.rewardId

	return arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveAct205FinishGameReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		Act205Model.instance:updateGameInfo(arg_8_2)
		Act205Controller.instance:dispatchEvent(Act205Event.OnFinishGame, arg_8_2)
	end
end

function var_0_0.onReceiveAct205InfoPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		Act205Model.instance:updateGameInfo(arg_9_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
