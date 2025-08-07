module("modules.logic.sp01.odyssey.rpc.OdysseyRpc", package.seeall)

local var_0_0 = class("OdysseyRpc", BaseRpc)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.sendOdysseyGetInfoRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = OdysseyModule_pb.OdysseyGetInfoRequest()

	return arg_3_0:sendMsg(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onReceiveOdysseyGetInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		OdysseyModel.instance:onReceiveOdysseyGetInfoReply(arg_4_2.info)
	end
end

function var_0_0.onReceiveOdysseyUpdateInfoPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		OdysseyModel.instance:onReceiveOdysseyGetInfoReply(arg_5_2.info, true)
	end
end

function var_0_0.sendOdysseyMapSetCurrElementRequest(arg_6_0, arg_6_1)
	local var_6_0 = OdysseyModule_pb.OdysseyMapSetCurrElementRequest()

	var_6_0.eleId = arg_6_1

	return arg_6_0:sendMsg(var_6_0)
end

function var_0_0.onReceiveOdysseyMapSetCurrElementReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		OdysseyDungeonModel.instance:setCurInElementId(arg_7_2.eleId)
	end
end

function var_0_0.sendOdysseyMapInteractRequest(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = OdysseyModule_pb.OdysseyMapInteractRequest()

	var_8_0.eleId = arg_8_1

	if arg_8_2.optionId and arg_8_2.optionId > 0 then
		var_8_0.optionParam.optionId = arg_8_2.optionId
	end

	return arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveOdysseyMapInteractReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		local var_9_0 = arg_9_2.element.id

		OdysseyDungeonModel.instance:updateElementInfo(arg_9_2.element)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnElementFinish, var_9_0)
	end
end

function var_0_0.onReceiveOdysseyMapUpdateElementPush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		OdysseyDungeonModel.instance:addNewElement(arg_10_2.updates)
		OdysseyDungeonModel.instance:setAllElementInfo(arg_10_2.updates)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnUpdateElementPush, true)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function var_0_0.onReceiveOdysseyUpdateLevelPush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		OdysseyModel.instance:updateHeroLevel(arg_11_2)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshHeroInfo)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnRewardGet)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function var_0_0.onReceiveOdysseyMapUpdatePush(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		OdysseyDungeonModel.instance:setMapInfo(arg_12_2.maps)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnMapUpdate)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function var_0_0.sendOdysseyFightMercenarySetDropRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = OdysseyModule_pb.OdysseyFightMercenarySetDropRequest()

	var_13_0.type = arg_13_1
	var_13_0.suitId = arg_13_2

	return arg_13_0:sendMsg(var_13_0)
end

function var_0_0.onReceiveOdysseyFightMercenarySetDropReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		OdysseyModel.instance:updateMercenaryTypeSuit(arg_14_2.type, arg_14_2.suitId)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.RefreshMercenarySuit)
	end
end

function var_0_0.sendOdysseyFightMercenaryRefreshRequest(arg_15_0)
	local var_15_0 = OdysseyModule_pb.OdysseyFightMercenaryRefreshRequest()

	return arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveOdysseyFightMercenaryRefreshReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		OdysseyModel.instance:updateMercenaryNextRefreshTime(arg_16_2.nextRefTime)
	end
end

function var_0_0.onReceiveOdysseyFightMercenaryUpdatePush(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		OdysseyModel.instance:setMercenaryInfo(arg_17_2.info)
	end
end

function var_0_0.sendOdysseyBagUpdateItemNewFlagRequest(arg_18_0, arg_18_1)
	local var_18_0 = OdysseyModule_pb.OdysseyBagUpdateItemNewFlagRequest()

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		table.insert(var_18_0.uidList, iter_18_1)
	end

	return arg_18_0:sendMsg(var_18_0)
end

function var_0_0.onReceiveOdysseyBagUpdateItemNewFlagReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		OdysseyItemModel.instance:cleanHasClickItemState()
		OdysseyItemModel.instance:refreshItemInfo(arg_19_2.items)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function var_0_0.onReceiveOdysseyBagGetItemPush(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == 0 then
		OdysseyItemModel.instance:updateItemInfo(arg_20_2.items, true)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnRewardGet)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function var_0_0.sendOdysseyTalentNodeLevelUpRequest(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = OdysseyModule_pb.OdysseyTalentNodeLevelUpRequest()

	var_21_0.nodeId = arg_21_1

	return arg_21_0:sendMsg(var_21_0, arg_21_2, arg_21_3)
end

function var_0_0.onReceiveOdysseyTalentNodeLevelUpReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == 0 then
		OdysseyTalentModel.instance:updateTalentNode(arg_22_2.node)
		OdysseyTalentModel.instance:buildTalentTypeNodeMap()
		OdysseyTalentModel.instance:setNodeChild()
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshTalent)
	end
end

function var_0_0.sendOdysseyTalentNodeLevelDownRequest(arg_23_0, arg_23_1)
	local var_23_0 = OdysseyModule_pb.OdysseyTalentNodeLevelDownRequest()

	var_23_0.nodeId = arg_23_1

	return arg_23_0:sendMsg(var_23_0)
end

function var_0_0.onReceiveOdysseyTalentNodeLevelDownReply(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 == 0 then
		OdysseyTalentModel.instance:updateTalentNode(arg_24_2.node)
		OdysseyTalentModel.instance:buildTalentTypeNodeMap()
		OdysseyTalentModel.instance:setNodeChild()
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshTalent)
	end
end

function var_0_0.sendOdysseyTalentAllResetRequest(arg_25_0)
	local var_25_0 = OdysseyModule_pb.OdysseyTalentAllResetRequest()

	return arg_25_0:sendMsg(var_25_0)
end

function var_0_0.onReceiveOdysseyTalentAllResetReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == 0 then
		OdysseyTalentModel.instance:resetTalentData()
		OdysseyTalentModel.instance:updateTalentInfo(arg_26_2.info)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.ResetTalent)
	end
end

function var_0_0.onReceiveOdysseyTalentPointUpdatePush(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == 0 then
		OdysseyTalentModel.instance:setCurTalentPoint(arg_27_2.point, arg_27_2.reason)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshTalent)
	end
end

function var_0_0.sendOdysseyTalentCassandraTreeChoiceRequest(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = OdysseyModule_pb.OdysseyTalentCassandraTreeChoiceRequest()

	var_28_0.subId = arg_28_1
	var_28_0.level = arg_28_2

	return arg_28_0:sendMsg(var_28_0)
end

function var_0_0.onReceiveOdysseyTalentCassandraTreeChoiceReply(arg_29_0, arg_29_1, arg_29_2)
	OdysseyTalentModel.instance:setCassandraTreeInfoStr(arg_29_2.cassandraTree)
	OdysseyTalentModel.instance:setTrialCassandraTreeInfo()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.TrialTalentTreeChange)
end

function var_0_0.sendOdysseyTalentCassandraTreeCancelRequest(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = OdysseyModule_pb.OdysseyTalentCassandraTreeCancelRequest()

	var_30_0.subId = arg_30_1
	var_30_0.level = arg_30_2

	return arg_30_0:sendMsg(var_30_0)
end

function var_0_0.onReceiveOdysseyTalentCassandraTreeCancelReply(arg_31_0, arg_31_1, arg_31_2)
	OdysseyTalentModel.instance:setCassandraTreeInfoStr(arg_31_2.cassandraTree)
	OdysseyTalentModel.instance:setTrialCassandraTreeInfo()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.TrialTalentTreeChange)
end

function var_0_0.sendOdysseyTalentCassandraTreeResetRequest(arg_32_0)
	local var_32_0 = OdysseyModule_pb.OdysseyTalentCassandraTreeResetRequest()

	return arg_32_0:sendMsg(var_32_0)
end

function var_0_0.onReceiveOdysseyTalentCassandraTreeResetReply(arg_33_0, arg_33_1, arg_33_2)
	OdysseyTalentModel.instance:setCassandraTreeInfoStr(arg_33_2.cassandraTree)
	OdysseyTalentModel.instance:setTrialCassandraTreeInfo()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.TrialTalentTreeReset)
end

function var_0_0.sendOdysseyFightReligionDiscloseRequest(arg_34_0, arg_34_1)
	local var_34_0 = OdysseyModule_pb.OdysseyFightReligionDiscloseRequest()

	var_34_0.religionId = arg_34_1

	return arg_34_0:sendMsg(var_34_0)
end

function var_0_0.onReceiveOdysseyFightReligionDiscloseReply(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == 0 then
		OdysseyModel.instance:setReligionInfo(arg_35_2.member)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.RefreshReligionMembers)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.CreateNewElement, true)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowExposeEffect, arg_35_2.member.religionId)
	end
end

function var_0_0.onReceiveOdysseyFightReligionMemberUpdatePush(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == 0 then
		OdysseyModel.instance:setReligionInfo(arg_36_2.member)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.RefreshReligionMembers)
	end
end

function var_0_0.sendOdysseyHotfixRequest(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = OdysseyModule_pb.OdysseyHotfixRequest()

	var_37_0.params = arg_37_1

	return arg_37_0:sendMsg(var_37_0, arg_37_2, arg_37_3)
end

function var_0_0.onReceiveOdysseyHotfixReply(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveOdysseyHotfixPush(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendOdysseyFormSaveRequest(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = OdysseyModule_pb.OdysseyFormSaveRequest()
	local var_40_1 = var_40_0.form

	var_40_1.clothId = arg_40_1.clothId

	for iter_40_0, iter_40_1 in ipairs(arg_40_1.heroes) do
		table.insert(var_40_1.heroes, iter_40_1)
	end

	var_40_1.no = arg_40_1.no

	for iter_40_2, iter_40_3 in ipairs(arg_40_1.suits) do
		table.insert(var_40_1.suits, iter_40_3)
	end

	arg_40_0:sendMsg(var_40_0, arg_40_2, arg_40_3)
end

function var_0_0.onReceiveOdysseyFormSaveReply(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 ~= 0 then
		return
	end

	local var_41_0 = arg_41_2.form

	OdysseyHeroGroupModel.instance:updateFormInfo(var_41_0)
end

function var_0_0.sendOdysseyFormSwitchRequest(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = OdysseyModule_pb.OdysseyFormSwitchRequest()

	var_42_0.formNo = arg_42_1

	arg_42_0:sendMsg(var_42_0, arg_42_2, arg_42_3)
end

function var_0_0.onReceiveOdysseyFormSwitchReply(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1 ~= 0 then
		return
	end

	local var_43_0 = arg_43_2.form

	OdysseyHeroGroupModel.instance:updateFormInfo(var_43_0)
end

function var_0_0.onReceiveOdysseyFightSettlePush(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 == 0 then
		OdysseyModel.instance:setFightResultInfo(arg_44_2)
		AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, false)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
