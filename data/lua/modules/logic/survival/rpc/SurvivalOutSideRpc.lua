module("modules.logic.survival.rpc.SurvivalOutSideRpc", package.seeall)

local var_0_0 = class("SurvivalOutSideRpc", BaseRpc)

function var_0_0.sendSurvivalOutSideGetInfo(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SurvivalOutSideModule_pb.SurvivalOutSideGetInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveSurvivalOutSideGetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		SurvivalModel.instance:onGetInfo(arg_2_2.info)
	end
end

function var_0_0.sendSurvivalOutSideGainReward(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = SurvivalOutSideModule_pb.SurvivalOutSideGainRewardRequest()

	var_3_0.rewardId = arg_3_1

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveSurvivalOutSideGainRewardReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		SurvivalModel.instance:getOutSideInfo():onGainReward(arg_4_2.rewardId)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnGainReward)
	end
end

function var_0_0.sendSurvivalSurvivalOutSideClientData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = SurvivalOutSideModule_pb.SurvivalSurvivalOutSideClientDataRequest()

	var_5_0.data = arg_5_1

	return arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveSurvivalSurvivalOutSideClientDataReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveSurvivalHandbookPush(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.onReceiveSurvivalMarkNewHandbookReply(arg_8_0, arg_8_1, arg_8_2)
	SurvivalHandbookModel.instance:onReceiveSurvivalMarkNewHandbookReply(arg_8_1, arg_8_2)
end

function var_0_0.sendSurvivalMarkNewHandbook(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = SurvivalOutSideModule_pb.SurvivalMarkNewHandbookRequest()

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		table.insert(var_9_0.ids, iter_9_1)
	end

	return arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
