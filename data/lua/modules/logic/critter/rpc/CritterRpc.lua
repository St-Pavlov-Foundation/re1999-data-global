module("modules.logic.critter.rpc.CritterRpc", package.seeall)

local var_0_0 = class("CritterRpc", BaseRpc)

function var_0_0.sendCritterGetInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = CritterModule_pb.CritterGetInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveCritterGetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		CritterController.instance:critterGetInfoReply(arg_2_2)
	end
end

function var_0_0.onReceiveCritterInfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	CritterController.instance:critterInfoPush(arg_3_2)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2.critterInfos) do
		var_3_0[iter_3_1.uid] = true
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterInfoPushUpdate, var_3_0)
end

function var_0_0.sendStartTrainCritterRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = CritterModule_pb.StartTrainCritterRequest()

	var_4_0.uid = arg_4_1
	var_4_0.heroId = arg_4_2
	var_4_0.guideId = arg_4_3 or 0
	var_4_0.step = arg_4_4 or 0

	return arg_4_0:sendMsg(var_4_0, arg_4_5, arg_4_6)
end

function var_0_0.onReceiveStartTrainCritterReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		CritterController.instance:startTrainCritterReply(arg_5_2)
		ManufactureController.instance:removeRestingCritter(arg_5_2.uid)
	end
end

function var_0_0.sendCancelTrainRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = CritterModule_pb.CancelTrainRequest()

	var_6_0.uid = arg_6_1

	return arg_6_0:sendMsg(var_6_0, arg_6_2, arg_6_3)
end

function var_0_0.onReceiveCancelTrainReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		CritterController.instance:cancelTrainReply(arg_7_2)
	end
end

function var_0_0.sendSelectEventOptionRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = CritterModule_pb.SelectEventOptionRequest()

	var_8_0.uid = arg_8_1
	var_8_0.eventId = arg_8_2
	var_8_0.optionId = arg_8_3

	return arg_8_0:sendMsg(var_8_0, arg_8_4, arg_8_5)
end

function var_0_0.onReceiveSelectEventOptionReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		CritterController.instance:selectEventOptionReply(arg_9_2)
	end
end

function var_0_0.sendSelectMultiEventOptionRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = CritterModule_pb.SelectMultiEventOptionRequest()

	var_10_0.uid = arg_10_1
	var_10_0.eventId = arg_10_2

	for iter_10_0, iter_10_1 in ipairs(arg_10_3) do
		local var_10_1 = CritterModule_pb.EventOptionInfo()

		var_10_1.optionId = iter_10_1.optionId
		var_10_1.count = iter_10_1.count

		table.insert(var_10_0.infos, var_10_1)
	end

	return arg_10_0:sendMsg(var_10_0, arg_10_4, arg_10_5)
end

function var_0_0.onReceiveSelectMultiEventOptionReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendFastForwardTrainRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = CritterModule_pb.FastForwardTrainRequest()

	var_12_0.uid = arg_12_1
	var_12_0.itemId = arg_12_2
	var_12_0.count = arg_12_3 or 1

	return arg_12_0:sendMsg(var_12_0, arg_12_4, arg_12_5)
end

function var_0_0.onReceiveFastForwardTrainReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		CritterController.instance:fastForwardTrainReply(arg_13_2)
	end
end

function var_0_0.sendFinishTrainCritterRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = CritterModule_pb.FinishTrainCritterRequest()

	var_14_0.uid = arg_14_1

	return arg_14_0:sendMsg(var_14_0, arg_14_2, arg_14_3)
end

function var_0_0.onReceiveFinishTrainCritterReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		CritterController.instance:finishTrainCritterReply(arg_15_2)
	end
end

function var_0_0.sendBanishCritterRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = CritterModule_pb.BanishCritterRequest()

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		table.insert(var_16_0.uids, iter_16_1)
	end

	return arg_16_0:sendMsg(var_16_0, arg_16_2, arg_16_3)
end

function var_0_0.onReceiveBanishCritterReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		CritterController.instance:banishCritterReply(arg_17_2)
	end
end

function var_0_0.sendLockCritterRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = CritterModule_pb.LockCritterRequest()

	var_18_0.uid = arg_18_1
	var_18_0.lock = arg_18_2 == true

	return arg_18_0:sendMsg(var_18_0, arg_18_3, arg_18_4)
end

function var_0_0.onReceiveLockCritterReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		CritterController.instance:lockCritterRequest(arg_19_2)
	end
end

function var_0_0.sendIncubateCritterRequest(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = CritterModule_pb.IncubateCritterRequest()

	var_20_0.parent1 = arg_20_1
	var_20_0.parent2 = arg_20_2

	return arg_20_0:sendMsg(var_20_0, arg_20_3, arg_20_4)
end

function var_0_0.onReceiveIncubateCritterReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 then
		CritterIncubateController.instance:incubateCritterReply(arg_21_2)
	end
end

function var_0_0.sendIncubateCritterPreviewRequest(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = CritterModule_pb.IncubateCritterPreviewRequest()

	var_22_0.parent1 = arg_22_1
	var_22_0.parent2 = arg_22_2

	return arg_22_0:sendMsg(var_22_0, arg_22_3, arg_22_4)
end

function var_0_0.onReceiveIncubateCritterPreviewReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == 0 then
		CritterIncubateController.instance:onIncubateCritterPreviewReply(arg_23_2)
	end
end

function var_0_0.sendSummonCritterInfoRequest(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = CritterModule_pb.SummonCritterInfoRequest()

	return arg_24_0:sendMsg(var_24_0, arg_24_1, arg_24_2)
end

function var_0_0.onReceiveSummonCritterInfoReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == 0 then
		CritterSummonController.instance:summonCritterInfoReply(arg_25_2)
	end
end

function var_0_0.sendSummonCritterRequest(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = CritterModule_pb.SummonCritterRequest()

	var_26_0.poolId = arg_26_1
	var_26_0.count = arg_26_2

	return arg_26_0:sendMsg(var_26_0, arg_26_3, arg_26_4)
end

function var_0_0.onReceiveSummonCritterReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == 0 then
		CritterSummonController.instance:summonCritterReply(arg_27_2)
	end
end

function var_0_0.sendResetSummonCritterPoolRequest(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = CritterModule_pb.ResetSummonCritterPoolRequest()

	var_28_0.poolId = arg_28_1

	return arg_28_0:sendMsg(var_28_0, arg_28_2, arg_28_3)
end

function var_0_0.onReceiveResetSummonCritterPoolReply(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 == 0 then
		CritterSummonController.instance:resetSummonCritterPoolReply(arg_29_2)
	end
end

function var_0_0.sendGainGuideCritterRequest(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = CritterModule_pb.GainGuideCritterRequest()

	var_30_0.guideId = arg_30_1
	var_30_0.step = arg_30_2

	arg_30_0:sendMsg(var_30_0)
end

function var_0_0.onReceiveGainGuideCritterReply(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 ~= 0 then
		return
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterGuideReply, arg_31_2)
end

function var_0_0.sendGetCritterBookInfoRequest(arg_32_0)
	local var_32_0 = CritterModule_pb.GetCritterBookInfoRequest()

	arg_32_0:sendMsg(var_32_0)
end

function var_0_0.onReceiveGetCritterBookInfoReply(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 ~= 0 then
		return
	end

	RoomHandBookModel.instance:onGetInfo(arg_33_2)
end

function var_0_0.sendSetCritterBookBackgroundRequest(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = CritterModule_pb.SetCritterBookBackgroundRequest()

	var_34_0.id = arg_34_1
	var_34_0.Background = arg_34_2

	arg_34_0:sendMsg(var_34_0)
end

function var_0_0.onReceiveSetCritterBookBackgroundReply(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 ~= 0 then
		return
	end

	RoomHandBookModel.instance:setBackGroundId({
		id = arg_35_2.id,
		backgroundId = arg_35_2.Background
	})
	RoomStatController.instance:critterBookBgSwitch(arg_35_2.id, arg_35_2.Background)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.refreshBack)
end

function var_0_0.sendSetCritterBookUseSpecialSkinRequest(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = CritterModule_pb.SetCritterBookUseSpecialSkinRequest()

	var_36_0.id = arg_36_1
	var_36_0.UseSpecialSkin = arg_36_2

	arg_36_0:sendMsg(var_36_0)
end

function var_0_0.onReceiveSetCritterBookUseSpecialSkinReply(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 ~= 0 then
		return
	end

	RoomHandBookListModel.instance:setMutate(arg_37_2)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.showMutate, arg_37_2)
end

function var_0_0.sendMarkCritterBookNewReadRequest(arg_38_0, arg_38_1)
	local var_38_0 = CritterModule_pb.MarkCritterBookNewReadRequest()

	var_38_0.id = arg_38_1

	arg_38_0:sendMsg(var_38_0)
end

function var_0_0.onReceiveMarkCritterBookNewReadReply(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 ~= 0 then
		return
	end

	RoomHandBookListModel.instance:clearItemNewState(arg_39_2.id)
end

function var_0_0.sendGetRealCritterAttributeRequest(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	local var_40_0 = CritterModule_pb.GetRealCritterAttributeRequest()

	var_40_0.buildingId = arg_40_1
	var_40_0.isPreview = arg_40_3

	for iter_40_0, iter_40_1 in ipairs(arg_40_2) do
		table.insert(var_40_0.critterUids, iter_40_1)
	end

	arg_40_0:sendMsg(var_40_0, arg_40_4, arg_40_5)
end

function var_0_0.onReceiveGetRealCritterAttributeReply(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 ~= 0 then
		return
	end

	ManufactureCritterListModel.instance:setAttrPreview(arg_41_2.attributeInfos, arg_41_2.buildingId, arg_41_2.isPreview)

	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_2.attributeInfos) do
		var_41_0[iter_41_1.critterUid] = true
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterUpdateAttrPreview, var_41_0)
end

function var_0_0.onReceiveRealCritterAttributePush(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 == 0 then
		ManufactureCritterListModel.instance:setAttrPreview(arg_42_2.attributeInfos, arg_42_2.buildingId, arg_42_2.isPreview)

		local var_42_0 = {}

		for iter_42_0, iter_42_1 in ipairs(arg_42_2.attributeInfos) do
			var_42_0[iter_42_1.critterUid] = true
		end

		CritterController.instance:dispatchEvent(CritterEvent.CritterUpdateAttrPreview, var_42_0)
	end
end

function var_0_0.sendStartTrainCritterPreviewRequest(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = CritterModule_pb.StartTrainCritterPreviewRequest()

	var_43_0.uid = arg_43_1
	var_43_0.heroId = arg_43_2

	arg_43_0:sendMsg(var_43_0, arg_43_3, arg_43_4)
end

function var_0_0.onReceiveStartTrainCritterPreviewReply(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 == 0 then
		CritterController.instance:startTrainCritterPreviewReply(arg_44_2)
	end
end

function var_0_0.sendCritterRenameRequest(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	local var_45_0 = CritterModule_pb.CritterRenameRequest()

	var_45_0.uid = arg_45_1
	var_45_0.name = arg_45_2

	arg_45_0:sendMsg(var_45_0, arg_45_3, arg_45_4)
end

function var_0_0.onReceiveCritterRenameReply(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1 == 0 then
		CritterController.instance:critterRenameReply(arg_46_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
