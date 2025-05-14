module("modules.logic.sdk.rpc.Activity1000Rpc", package.seeall)

local var_0_0 = class("Activity1000Rpc", BaseRpc)

function var_0_0.sendAct1000GetInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = Activity1000Module_pb.Act1000GetInfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3, arg_1_4)
end

function var_0_0.onReceiveAct1000GetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(arg_2_2.accountBindBonus)
end

function var_0_0.sendAct1000AccountBindBonusRequest(arg_3_0, arg_3_1)
	local var_3_0 = Activity1000Module_pb.Act1000AccountBindBonusRequest()

	var_3_0.activityId = arg_3_1

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct1000AccountBindBonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(SDKEnum.RewardType.Got)
end

var_0_0.instance = var_0_0.New()

return var_0_0
