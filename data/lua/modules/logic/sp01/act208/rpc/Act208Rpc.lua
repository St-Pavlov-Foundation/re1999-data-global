module("modules.logic.sp01.act208.rpc.Act208Rpc", package.seeall)

local var_0_0 = class("Act208Rpc", BaseRpc)

function var_0_0.sendGetAct208InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = Activity208Module_pb.GetAct208InfoRequest()

	var_1_0.activityId = arg_1_1
	var_1_0.id = arg_1_2

	arg_1_0:sendMsg(var_1_0, arg_1_3, arg_1_4)
end

function var_0_0.onReceiveGetAct208InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.activityId
	local var_2_1 = arg_2_2.bonus

	Act208Model.instance:onGetInfo(var_2_0, var_2_1)
end

function var_0_0.sendAct208ReceiveBonusRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity208Module_pb.Act208ReceiveBonusRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct208ReceiveBonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.id

	Act208Model.instance:onGetBonus(var_4_0, var_4_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
