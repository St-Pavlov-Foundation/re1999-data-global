module("modules.logic.critter.rpc.CritterRpc", package.seeall)

slot0 = class("CritterRpc", BaseRpc)

function slot0.sendCritterGetInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(CritterModule_pb.CritterGetInfoRequest(), slot1, slot2)
end

function slot0.onReceiveCritterGetInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:critterGetInfoReply(slot2)
	end
end

function slot0.onReceiveCritterInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CritterController.instance:critterInfoPush(slot2)

	for slot7, slot8 in ipairs(slot2.critterInfos) do
		-- Nothing
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterInfoPushUpdate, {
		[slot8.uid] = true
	})
end

function slot0.sendStartTrainCritterRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = CritterModule_pb.StartTrainCritterRequest()
	slot7.uid = slot1
	slot7.heroId = slot2
	slot7.guideId = slot3 or 0
	slot7.step = slot4 or 0

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveStartTrainCritterReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:startTrainCritterReply(slot2)
		ManufactureController.instance:removeRestingCritter(slot2.uid)
	end
end

function slot0.sendCancelTrainRequest(slot0, slot1, slot2, slot3)
	slot4 = CritterModule_pb.CancelTrainRequest()
	slot4.uid = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveCancelTrainReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:cancelTrainReply(slot2)
	end
end

function slot0.sendSelectEventOptionRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = CritterModule_pb.SelectEventOptionRequest()
	slot6.uid = slot1
	slot6.eventId = slot2
	slot6.optionId = slot3

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveSelectEventOptionReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:selectEventOptionReply(slot2)
	end
end

function slot0.sendSelectMultiEventOptionRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = CritterModule_pb.SelectMultiEventOptionRequest()
	slot6.uid = slot1
	slot6.eventId = slot2

	for slot10, slot11 in ipairs(slot3) do
		slot12 = CritterModule_pb.EventOptionInfo()
		slot12.optionId = slot11.optionId
		slot12.count = slot11.count

		table.insert(slot6.infos, slot12)
	end

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveSelectMultiEventOptionReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendFastForwardTrainRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = CritterModule_pb.FastForwardTrainRequest()
	slot6.uid = slot1
	slot6.itemId = slot2
	slot6.count = slot3 or 1

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveFastForwardTrainReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:fastForwardTrainReply(slot2)
	end
end

function slot0.sendFinishTrainCritterRequest(slot0, slot1, slot2, slot3)
	slot4 = CritterModule_pb.FinishTrainCritterRequest()
	slot4.uid = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveFinishTrainCritterReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:finishTrainCritterReply(slot2)
	end
end

function slot0.sendBanishCritterRequest(slot0, slot1, slot2, slot3)
	slot4 = CritterModule_pb.BanishCritterRequest()

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4.uids, slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveBanishCritterReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:banishCritterReply(slot2)
	end
end

function slot0.sendLockCritterRequest(slot0, slot1, slot2, slot3, slot4)
	CritterModule_pb.LockCritterRequest().uid = slot1
	slot5.lock = slot2 == true

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveLockCritterReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:lockCritterRequest(slot2)
	end
end

function slot0.sendIncubateCritterRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = CritterModule_pb.IncubateCritterRequest()
	slot5.parent1 = slot1
	slot5.parent2 = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveIncubateCritterReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterIncubateController.instance:incubateCritterReply(slot2)
	end
end

function slot0.sendIncubateCritterPreviewRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = CritterModule_pb.IncubateCritterPreviewRequest()
	slot5.parent1 = slot1
	slot5.parent2 = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveIncubateCritterPreviewReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterIncubateController.instance:onIncubateCritterPreviewReply(slot2)
	end
end

function slot0.sendSummonCritterInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(CritterModule_pb.SummonCritterInfoRequest(), slot1, slot2)
end

function slot0.onReceiveSummonCritterInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterSummonController.instance:summonCritterInfoReply(slot2)
	end
end

function slot0.sendSummonCritterRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = CritterModule_pb.SummonCritterRequest()
	slot5.poolId = slot1
	slot5.count = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSummonCritterReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterSummonController.instance:summonCritterReply(slot2)
	end
end

function slot0.sendResetSummonCritterPoolRequest(slot0, slot1, slot2, slot3)
	slot4 = CritterModule_pb.ResetSummonCritterPoolRequest()
	slot4.poolId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveResetSummonCritterPoolReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterSummonController.instance:resetSummonCritterPoolReply(slot2)
	end
end

function slot0.sendGainGuideCritterRequest(slot0, slot1, slot2)
	slot3 = CritterModule_pb.GainGuideCritterRequest()
	slot3.guideId = slot1
	slot3.step = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGainGuideCritterReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterGuideReply, slot2)
end

function slot0.sendGetCritterBookInfoRequest(slot0)
	slot0:sendMsg(CritterModule_pb.GetCritterBookInfoRequest())
end

function slot0.onReceiveGetCritterBookInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomHandBookModel.instance:onGetInfo(slot2)
end

function slot0.sendSetCritterBookBackgroundRequest(slot0, slot1, slot2)
	slot3 = CritterModule_pb.SetCritterBookBackgroundRequest()
	slot3.id = slot1
	slot3.Background = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveSetCritterBookBackgroundReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomHandBookModel.instance:setBackGroundId({
		id = slot2.id,
		backgroundId = slot2.Background
	})
	RoomStatController.instance:critterBookBgSwitch(slot2.id, slot2.Background)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.refreshBack)
end

function slot0.sendSetCritterBookUseSpecialSkinRequest(slot0, slot1, slot2)
	slot3 = CritterModule_pb.SetCritterBookUseSpecialSkinRequest()
	slot3.id = slot1
	slot3.UseSpecialSkin = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveSetCritterBookUseSpecialSkinReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomHandBookListModel.instance:setMutate(slot2)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.showMutate, slot2)
end

function slot0.sendMarkCritterBookNewReadRequest(slot0, slot1)
	slot2 = CritterModule_pb.MarkCritterBookNewReadRequest()
	slot2.id = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveMarkCritterBookNewReadReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomHandBookListModel.instance:clearItemNewState(slot2.id)
end

function slot0.sendGetRealCritterAttributeRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = CritterModule_pb.GetRealCritterAttributeRequest()
	slot6.buildingId = slot1
	slot6.isPreview = slot3

	for slot10, slot11 in ipairs(slot2) do
		table.insert(slot6.critterUids, slot11)
	end

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveGetRealCritterAttributeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot7 = slot2.isPreview

	ManufactureCritterListModel.instance:setAttrPreview(slot2.attributeInfos, slot2.buildingId, slot7)

	for slot7, slot8 in ipairs(slot2.attributeInfos) do
		-- Nothing
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterUpdateAttrPreview, {
		[slot8.critterUid] = true
	})
end

function slot0.onReceiveRealCritterAttributePush(slot0, slot1, slot2)
	if slot1 == 0 then
		slot7 = slot2.isPreview

		ManufactureCritterListModel.instance:setAttrPreview(slot2.attributeInfos, slot2.buildingId, slot7)

		for slot7, slot8 in ipairs(slot2.attributeInfos) do
			-- Nothing
		end

		CritterController.instance:dispatchEvent(CritterEvent.CritterUpdateAttrPreview, {
			[slot8.critterUid] = true
		})
	end
end

function slot0.sendStartTrainCritterPreviewRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = CritterModule_pb.StartTrainCritterPreviewRequest()
	slot5.uid = slot1
	slot5.heroId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveStartTrainCritterPreviewReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:startTrainCritterPreviewReply(slot2)
	end
end

function slot0.sendCritterRenameRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = CritterModule_pb.CritterRenameRequest()
	slot5.uid = slot1
	slot5.name = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveCritterRenameReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CritterController.instance:critterRenameReply(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
