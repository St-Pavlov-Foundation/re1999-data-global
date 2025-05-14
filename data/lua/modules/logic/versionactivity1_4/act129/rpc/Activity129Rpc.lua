module("modules.logic.versionactivity1_4.act129.rpc.Activity129Rpc", package.seeall)

local var_0_0 = class("Activity129Rpc", BaseRpc)

function var_0_0.sendGet129InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity129Module_pb.Get129InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet129InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity129Model.instance:setInfo(arg_2_2)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnGetInfoSuccess)
end

function var_0_0.sendAct129LotteryRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity129Module_pb.Act129LotteryRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.poolId = arg_3_2
	var_3_0.num = arg_3_3

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct129LotteryReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity129Model.instance:onLotterySuccess(arg_4_2)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnLotterySuccess, arg_4_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
