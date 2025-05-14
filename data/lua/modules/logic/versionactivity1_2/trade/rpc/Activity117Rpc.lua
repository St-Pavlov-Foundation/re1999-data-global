module("modules.logic.versionactivity1_2.trade.rpc.Activity117Rpc", package.seeall)

local var_0_0 = class("Activity117Rpc", BaseRpc)

function var_0_0.sendAct117InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity117Module_pb.Act117InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveAct117InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity117Model.instance:onReceiveInfos(arg_2_2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveInfos, arg_2_2.activityId)
	end
end

function var_0_0.sendAct117NegotiateRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Activity117Module_pb.Act117NegotiateRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.orderId = arg_3_2
	var_3_0.userDealScore = arg_3_3

	arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveAct117NegotiateReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity117Model.instance:onNegotiateResult(arg_4_2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveNegotiate, arg_4_2.activityId)
	end
end

function var_0_0.sendAct117DealRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity117Module_pb.Act117DealRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.orderId = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct117DealReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Activity117Model.instance:onDealSuccess(arg_6_2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveDeal, arg_6_2.activityId)
	end
end

function var_0_0.sendAct117GetBonusRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity117Module_pb.Act117GetBonusRequest()

	var_7_0.activityId = arg_7_1

	if arg_7_2 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
			table.insert(var_7_0.bonusIds, iter_7_1)
		end
	end

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveAct117GetBonusReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		Activity117Model.instance:updateRewardDatas(arg_8_2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveGetBonus, arg_8_2.activityId, arg_8_2.bonusIds)
	end
end

function var_0_0.onReceiveAct117OrderPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		Activity117Model.instance:onOrderPush(arg_9_2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveOrderPush, arg_9_2.activityId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
