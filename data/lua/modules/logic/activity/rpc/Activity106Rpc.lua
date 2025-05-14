module("modules.logic.activity.rpc.Activity106Rpc", package.seeall)

local var_0_0 = class("Activity106Rpc", BaseRpc)

function var_0_0.sendGet106InfosRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity106Module_pb.Get106InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGet106InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		ActivityWarmUpController.instance:onReceiveInfos(arg_2_2.activityId, arg_2_2.orderInfos)
	end
end

function var_0_0.sendGet106OrderBonusRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Activity106Module_pb.Get106OrderBonusRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.orderId = arg_3_2
	var_3_0.useSecond = arg_3_3

	arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveGet106OrderBonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		ActivityWarmUpController.instance:onUpdateSingleOrder(arg_4_2.activityId, arg_4_2.orderInfo)
	end
end

function var_0_0.onReceiveUpdate106OrderPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		ActivityWarmUpController.instance:onOrderPush(arg_5_2.activityId, arg_5_2.orderInfo)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
