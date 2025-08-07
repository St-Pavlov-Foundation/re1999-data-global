module("modules.logic.sp01.assassinChase.rpc.AssassinChaseRpc", package.seeall)

local var_0_0 = class("AssassinChaseRpc", BaseRpc)

function var_0_0.sendAct206GetInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity206Module_pb.Act206GetInfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveAct206GetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.activityId
	local var_2_1 = arg_2_2.hasChosenDirection
	local var_2_2 = arg_2_2.chosenInfo
	local var_2_3 = arg_2_2.optionDirections

	AssassinChaseModel.instance:setActInfo(arg_2_2)
end

function var_0_0.sendAct206ChooseDirectionRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity206Module_pb.Act206ChooseDirectionRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.directionId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct206ChooseDirectionReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.chosenInfo

	AssassinChaseModel.instance:onSelectDirection(var_4_0, var_4_1)
end

function var_0_0.sendAct206GetBonusRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Activity206Module_pb.Act206GetBonusRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveAct206GetBonusReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.activityId
	local var_6_1 = arg_6_2.rewardId

	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnGetReward, var_6_0)
end

function var_0_0.onReceiveAct206InfoPush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	local var_7_0 = arg_7_2.activityId
	local var_7_1 = arg_7_2.gameType
	local var_7_2 = arg_7_2.haveGameCount

	AssassinChaseModel.instance:setActInfo(arg_7_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
