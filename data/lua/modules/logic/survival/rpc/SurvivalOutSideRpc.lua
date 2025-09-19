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

function var_0_0.sendSurvivalOutSideAlterTalentGroup(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = SurvivalOutSideModule_pb.SurvivalOutSideAlterTalentGroupRequest()

	var_5_0.groupId = arg_5_1

	if arg_5_2 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
			table.insert(var_5_0.talentId, iter_5_1)
		end
	end

	return arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveSurvivalOutSideAlterTalentGroupReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		SurvivalModel.instance:getOutSideInfo().talentBox:updateGroupInfo(arg_6_2.group)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTalentGroupBoxUpdate)
	end
end

function var_0_0.sendSurvivalSurvivalOutSideClientData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = SurvivalOutSideModule_pb.SurvivalSurvivalOutSideClientDataRequest()

	var_7_0.data = arg_7_1

	return arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveSurvivalSurvivalOutSideClientDataReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveSurvivalOutSideUnlockTalentIdsPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		local var_9_0 = SurvivalModel.instance:getOutSideInfo()

		var_9_0.talentBox:unLockTalent(arg_9_2.talentIds)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTalentGroupBoxUpdate)
		tabletool.addValues(var_9_0.clientData.data.newTalents, arg_9_2.talentIds)
		var_9_0.clientData:saveDataToServer()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
