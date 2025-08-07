module("modules.logic.summon.rpc.SummonRpc", package.seeall)

local var_0_0 = class("SummonRpc", BaseRpc)

function var_0_0.sendSummonRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	local var_1_0 = SummonModule_pb.SummonRequest()

	var_1_0.poolId = arg_1_1
	var_1_0.guideId = arg_1_3 or 0
	var_1_0.stepId = arg_1_4 or 0
	var_1_0.count = arg_1_2

	arg_1_0:sendMsg(var_1_0, arg_1_5, arg_1_6)

	SummonController.instance.isWaitingSummonResult = true

	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolHistorySummonRequest, arg_1_1)
end

function var_0_0.onReceiveSummonReply(arg_2_0, arg_2_1, arg_2_2)
	SummonController.instance.isWaitingSummonResult = false

	if arg_2_1 ~= 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonFailed)
		arg_2_0:sendGetSummonInfoRequest()

		return
	end

	local var_2_0 = arg_2_2.summonResult

	SDKChannelEventModel.instance:addTotalSummonCount(#var_2_0)
	SDKChannelEventModel.instance:onSummonResult(var_2_0)
	SummonController.instance:summonSuccess(var_2_0)
	SummonController.instance:dispatchEvent(SummonEvent.onReceiveSummonReply, arg_2_2)
end

function var_0_0.sendGetSummonInfoRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = SummonModule_pb.GetSummonInfoRequest()

	return arg_3_0:sendMsg(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onReceiveGetSummonInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	SummonController.instance:updateSummonInfo(arg_4_2)
	SDKChannelEventModel.instance:updateTotalSummonCount(arg_4_2.totalSummonCount)
end

function var_0_0.sendSummonQueryTokenRequest(arg_5_0)
	local var_5_0 = SummonModule_pb.SummonQueryTokenRequest()

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveSummonQueryTokenReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	SummonPoolHistoryController.instance:updateSummonQueryToken(arg_6_2)
end

function var_0_0.sendOpenLuckyBagRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = SummonModule_pb.OpenLuckyBagRequest()

	var_7_0.luckyBagId = arg_7_1
	var_7_0.heroId = arg_7_2

	return arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveOpenLuckyBagReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onLuckyBagOpened)
		arg_8_0:sendGetSummonInfoRequest()
	end
end

function var_0_0.sendChooseDoubleUpHeroRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = SummonModule_pb.ChooseMultiUpHeroRequest()

	var_9_0.poolId = arg_9_1

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		var_9_0.heroIds:append(iter_9_1)
	end

	return arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveChooseMultiUpHeroReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onCustomPicked)
		arg_10_0:sendGetSummonInfoRequest()
	end
end

function var_0_0.sendChooseEnhancedPoolHeroRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = SummonModule_pb.ChooseEnhancedPoolHeroRequest()

	var_11_0.poolId = arg_11_1
	var_11_0.heroId = arg_11_2

	return arg_11_0:sendMsg(var_11_0, arg_11_3, arg_11_4)
end

function var_0_0.onReceiveChooseEnhancedPoolHeroReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onCustomPicked)
		arg_12_0:sendGetSummonInfoRequest()
	end
end

function var_0_0.sendGetSummonProgressRewardsRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = SummonModule_pb.GetSummonProgressRewardsRequest()

	var_13_0.poolId = arg_13_1

	return arg_13_0:sendMsg(var_13_0, arg_13_2, arg_13_3)
end

function var_0_0.onReceiveGetSummonProgressRewardsReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		SummonController.instance:summonProgressRewards(arg_14_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
