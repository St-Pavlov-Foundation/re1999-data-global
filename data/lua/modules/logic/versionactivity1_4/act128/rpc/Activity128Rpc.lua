module("modules.logic.versionactivity1_4.act128.rpc.Activity128Rpc", package.seeall)

local var_0_0 = class("Activity128Rpc", BaseRpc)

function var_0_0.sendGet128InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity128Module_pb.Get128InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet128InfosReply(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_onReceiveGet128InfosReply(arg_2_1, arg_2_2)
end

function var_0_0.sendAct128GetTotalRewardsRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity128Module_pb.Act128GetTotalRewardsRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.bossId = arg_3_2

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct128GetTotalRewardsReply(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:_onReceiveAct128GetTotalRewardsReply(arg_4_1, arg_4_2)
end

function var_0_0.sendAct128DoublePointRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Activity128Module_pb.Act128DoublePointRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.bossId = arg_5_2

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveAct128DoublePointReply(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:_onReceiveAct128DoublePointReply(arg_6_1, arg_6_2)
end

function var_0_0.onReceiveAct128InfoUpdatePush(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:_onReceiveAct128InfoUpdatePush(arg_7_1, arg_7_2)
end

function var_0_0.sendAct128EvaluateRequest(arg_8_0, arg_8_1, arg_8_2)
	return
end

function var_0_0.sendAct128GetTotalSingleRewardRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = Activity128Module_pb.Act128GetTotalSingleRewardRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.bossId = arg_9_2
	var_9_0.rewardId = arg_9_3

	return arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveAct128GetTotalSingleRewardReply(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_onReceiveAct128GetTotalSingleRewardReply(arg_10_1, arg_10_2)
end

function var_0_0.sendAct128SpFirstHalfSelectItemRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = Activity128Module_pb.Act128SpFirstHalfSelectItemRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.bossId = arg_11_2

	for iter_11_0, iter_11_1 in pairs(arg_11_3) do
		var_11_0.itemTypeIds:append(iter_11_1)
	end

	return arg_11_0:sendMsg(var_11_0, arg_11_4, arg_11_5)
end

function var_0_0.onReceiveAct128SpFirstHalfSelectItemReply(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:_onReceiveAct128SpFirstHalfSelectItemReply(arg_12_1, arg_12_2)
end

return var_0_0
