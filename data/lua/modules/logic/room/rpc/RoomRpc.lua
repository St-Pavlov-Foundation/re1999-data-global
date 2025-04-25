module("modules.logic.room.rpc.RoomRpc", package.seeall)

slot0 = class("RoomRpc", BaseRpc)
slot0.GainProductionLineRequest = -29380

function slot0.sendGetRoomInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(RoomModule_pb.GetRoomInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetRoomInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:setEditInfo(slot2)
	end
end

function slot0.sendUseBlockRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = RoomModule_pb.UseBlockRequest()
	slot8.blockId = slot1
	slot8.blockPackageId = slot2
	slot8.rotate = slot3
	slot8.x = slot4
	slot8.y = slot5

	return slot0:sendMsg(slot8, slot6, slot7)
end

function slot0.onReceiveUseBlockReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomMapController.instance:useBlockReply(slot2)
		RoomStatController.instance:blockOp({
			slot2.blockId
		}, true)
	end
end

function slot0.sendUnUseBlockRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.UnUseBlockRequest()

	for slot8 = 1, #slot1 do
		table.insert(slot4.blockIds, slot1[slot8])
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveUnUseBlockReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomMapController.instance:unUseBlockReply(slot2)
		RoomStatController.instance:blockOp(slot2.blockIds, false)
	end
end

function slot0.sendGetBlockPackageInfoRequset(slot0, slot1, slot2)
	return slot0:sendMsg(RoomModule_pb.GetBlockPackageInfoRequset(), slot1, slot2)
end

function slot0.onReceiveGetBlockPackageInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomController.instance:getBlockPackageInfoReply(slot2)
	end
end

function slot0.onReceiveBlockPackageGainPush(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomController.instance:blockPackageGainPush(slot2)
		RoomMapController.instance:dispatchEvent(RoomEvent.NewBlockPackagePush)
	end
end

function slot0.onReceiveGainSpecialBlockPush(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomController.instance:gainSpecialBlockPush(slot2)
	end
end

function slot0.sendGetBuildingInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(RoomModule_pb.GetBuildingInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetBuildingInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomController.instance:getBuildingInfoReply(slot2)
	end
end

function slot0.sendResetRoomRequest(slot0, slot1, slot2)
	return slot0:sendMsg(RoomModule_pb.ResetRoomRequest(), slot1, slot2)
end

function slot0.onReceiveResetRoomReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveBuildingGainPush(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:updateBuildingInfos(slot2.buildingInfos)
		RoomInventoryBuildingModel.instance:addBuilding(slot2.buildingInfos)
		RoomMapController.instance:buildingLevelUpByInfos(slot2.buildingInfos)
		RoomMapController.instance:dispatchEvent(RoomEvent.NewBuildingPush)
	end
end

function slot0.sendUseBuildingRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = RoomModule_pb.UseBuildingRequest()
	slot7.uid = slot1
	slot7.rotate = slot2
	slot7.x = slot3
	slot7.y = slot4

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveUseBuildingReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:updateBuildingInfos({
			slot2.buildingInfo
		})
		RoomMapController.instance:useBuildingReply(slot2)
		RoomMapController.instance:dispatchEvent(RoomEvent.UseBuildingReply)
	end
end

function slot0.sendUnUseBuildingRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.UnUseBuildingRequest()
	slot4.uid = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveUnUseBuildingReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:updateBuildingInfos(slot2.buildingInfos)
		RoomMapController.instance:unUseBuildingReply(slot2)
	end
end

function slot0.sendGetRoomObInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.GetRoomObInfoRequest()
	slot4.needBlockData = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetRoomObInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:updateRoomLevel(slot2.roomLevel)
		RoomModel.instance:updateBuildingInfos(slot2.buildingInfos)
		RoomModel.instance:setFormulaInfos(slot2.formulaInfos)
		RoomModel.instance:setGetThemeRewardIds(slot2.hasGetRoomThemes)

		if slot2.needBlockData == true then
			slot3 = RoomLayoutHelper.createInfoByObInfo(slot2)
			slot3.id = RoomEnum.LayoutUsedPlanId

			RoomLayoutModel.instance:updateRoomPlanInfoReply(slot3)
			RoomModel.instance:setCharacterList(slot2.roomHeroDatas)
		end

		RoomProductionModel.instance:updateProductionLines(slot2.productionLines)
		RoomSkinModel.instance:updateRoomSkinInfo(slot2.skins, true)
	end
end

function slot0.sendRoomConfirmRequest(slot0, slot1, slot2)
	return slot0:sendMsg(RoomModule_pb.RoomConfirmRequest(), slot1, slot2)
end

function slot0.onReceiveRoomConfirmReply(slot0, slot1, slot2)
end

function slot0.sendRoomRevertRequest(slot0, slot1, slot2)
	return slot0:sendMsg(RoomModule_pb.RoomRevertRequest(), slot1, slot2)
end

function slot0.onReceiveRoomRevertReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveFormulaGainPush(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:addFormulaInfos(slot2.formulaInfos)
		RoomFormulaModel.instance:addFormulaList(slot2.formulaInfos)
		RoomBuildingController.instance:dispatchEvent(RoomEvent.NewFormulaPush)
	end
end

function slot0.sendBuildingChangeLevelRequest(slot0, slot1, slot2, slot3, slot4)
	RoomModule_pb.BuildingChangeLevelRequest().buildingUid = slot1

	for slot9, slot10 in ipairs(slot2) do
		table.insert(slot5.levels, slot10)
	end

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveBuildingChangeLevelReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomMapBuildingModel.instance:updateBuildingLevels(slot2.buildingUid, slot2.levels)
		RoomResourceModel.instance:clearResourceAreaList()
		RoomBuildingController.instance:dispatchEvent(RoomEvent.UpdateBuildingLevels, slot2.buildingUid)
	end
end

function slot0.sendRoomAccelerateRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RoomModule_pb.RoomAccelerateRequest()
	slot6.buildingUid = slot1
	slot6.useItemCount = slot2
	slot6.slot = slot3 or 0

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveRoomAccelerateReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomBuildingController.instance:dispatchEvent(RoomEvent.AccelerateSuccess)
	end
end

function slot0.sendGetOtherRoomObInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.GetOtherRoomObInfoRequest()
	slot4.targetUid = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetOtherRoomObInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendRoomLevelUpRequest(slot0, slot1, slot2)
	RoomMapModel.instance:setRoomLeveling(true)

	return slot0:sendMsg(RoomModule_pb.RoomLevelUpRequest(), slot1, slot2)
end

function slot0.onReceiveRoomLevelUpReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:updateRoomLevel(slot2.roomLevel)
		RoomMapModel.instance:updateRoomLevel(slot2.roomLevel)
		RoomProductionModel.instance:checkUnlockLine(slot2.roomLevel)
		RoomProductionModel.instance:updateProductionLines(slot2.productionLines)
		RoomProductionModel.instance:updateLineMaxLevel()
		RoomMapController.instance:dispatchEvent(RoomEvent.UpdateRoomLevel)
	end

	RoomMapModel.instance:setRoomLeveling(false)
end

function slot0.sendStartProductionLineRequest(slot0, slot1, slot2, slot3)
	RoomModule_pb.StartProductionLineRequest().id = slot1

	for slot8, slot9 in ipairs(slot2) do
		slot10 = RoomModule_pb.FormulaProduce()
		slot10.formulaId = slot9.formulaId
		slot10.count = slot9.count

		table.insert(slot4.formulaProduce, slot10)
	end

	if slot3 then
		for slot8, slot9 in ipairs(slot3) do
			slot10 = MaterialModule_pb.MaterialData()
			slot10.materilType = slot9.type
			slot10.materilId = slot9.id
			slot10.quantity = slot9.quantity

			table.insert(slot4.costCheck, slot10)
		end
	end

	return slot0:sendMsg(slot4)
end

function slot0.onReceiveStartProductionLineReply(slot0, slot1, slot2)
	RoomController.instance:dispatchEvent(RoomEvent.StartProductionLineReply, slot1, slot2)
end

function slot0.sendProductionLineInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.ProductionLineInfoRequest()

	if slot1 ~= nil then
		for slot8, slot9 in ipairs(slot1) do
			table.insert(slot4.ids, slot9)
		end
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveProductionLineInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomProductionModel.instance:updateProductionLines(slot2.productionLines)
	end
end

function slot0.sendGainProductionLineRequest(slot0, slot1, slot2)
	slot3 = RoomModule_pb.GainProductionLineRequest()

	if slot1 ~= nil then
		for slot7, slot8 in ipairs(slot1) do
			table.insert(slot3.ids, slot8)
		end
	end

	GameMsgLockState.IgnoreCmds[uv0.GainProductionLineRequest] = slot2 or false

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveGainProductionLineReply(slot0, slot1, slot2)
	slot3 = nil

	if slot1 == 0 then
		slot4 = slot2.productionLines

		RoomProductionModel.instance:updateProductionLines(slot4)

		for slot8, slot9 in ipairs(slot4) do
			if slot9.id ~= 0 then
				table.insert({}, slot9.id)
			end
		end
	end

	RoomController.instance:dispatchEvent(RoomEvent.GainProductionLineReply, slot1, slot3)
end

function slot0.sendProductionLineLvUpRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RoomModule_pb.ProductionLineLvUpRequest()
	slot5.id = slot1
	slot5.newLevel = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveProductionLineLvUpReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomProductionModel.instance:updateProductionLines({
			slot2.productionLine
		})
		RoomController.instance:dispatchEvent(RoomEvent.ProduceLineLevelUp)
	end
end

function slot0.sendProductionLineAccelerateRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RoomModule_pb.ProductionLineAccelerateRequest()
	slot5.id = slot1
	slot5.useItemCount = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveProductionLineAccelerateReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomProductionModel.instance:updateProductionLines({
			slot2.productionLine
		})
	end
end

function slot0.sendUpdateRoomHeroDataRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.UpdateRoomHeroDataRequest()

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4.roomHeroIds, slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveUpdateRoomHeroDataReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:setCharacterList(slot2.roomHeroDatas)
	end
end

function slot0.sendGainRoomHeroFaithRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.GainRoomHeroFaithRequest()

	if slot1 then
		for slot8, slot9 in ipairs(slot1) do
			table.insert(slot4.heroIds, slot9)
		end
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGainRoomHeroFaithReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomCharacterController.instance:updateCharacterFaith(slot2.roomHeroDatas)
		RoomCharacterController.instance:playCharacterFaithEffect(slot2.roomHeroDatas)
	end
end

function slot0.sendHideBuildingReddotRequset(slot0, slot1)
	slot2 = RoomModule_pb.HideBuildingReddotRequset()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveHideBuildingReddotReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendHideBlockPackageReddotRequest(slot0, slot1)
	slot2 = RoomModule_pb.HideBlockPackageReddotRequest()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveHideBlockPackageReddotReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendStartCharacterInteractionRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.StartCharacterInteractionRequest()
	slot4.id = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveStartCharacterInteractionReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:interactStart(slot2.id)
	end
end

function slot0.sendGetCharacterInteractionBonusRequest(slot0, slot1, slot2)
	RoomModule_pb.GetCharacterInteractionBonusRequest().id = slot1

	if slot2 then
		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot3.selectIds, slot8)
		end
	end

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveGetCharacterInteractionBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:interactComplete(slot2.id)
	end
end

function slot0.sendGetCharacterInteractionInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(RoomModule_pb.GetCharacterInteractionInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetCharacterInteractionInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:updateInteraction(slot2)
	end
end

function slot0.sendGetRoomThemeCollectionBonusRequest(slot0, slot1)
	slot2 = RoomModule_pb.GetRoomThemeCollectionBonusRequest()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGetRoomThemeCollectionBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomController.instance:getRoomThemeCollectionBonusReply(slot2)
	end
end

function slot0.sendGetRoomPlanInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(RoomModule_pb.GetRoomPlanInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetRoomPlanInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:getRoomPlanInfoReply(slot2)
	end
end

function slot0.sendGetRoomPlanDetailsRequest(slot0, slot1)
	slot2 = RoomModule_pb.GetRoomPlanDetailsRequest()
	slot2.id = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetRoomPlanDetailsReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:getRoomPlanDestailsReply(slot2)
	end
end

function slot0.sendSetRoomPlanRequest(slot0, slot1, slot2, slot3)
	RoomModule_pb.SetRoomPlanRequest().id = slot1
	slot4.coverId = slot2 or 1
	slot4.name = slot3 or ""

	slot0:sendMsg(slot4)
end

function slot0.onReceiveSetRoomPlanReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:setRoomPlanReply(slot2)
	end
end

function slot0.sendSetRoomPlanNameRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RoomModule_pb.SetRoomPlanNameRequest()
	slot5.id = slot1
	slot5.name = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSetRoomPlanNameReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:setRoomPlanNameReply(slot2)
	end
end

function slot0.sendSetRoomPlanCoverRequest(slot0, slot1, slot2)
	slot3 = RoomModule_pb.SetRoomPlanCoverRequest()
	slot3.id = slot1
	slot3.coverId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveSetRoomPlanCoverReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:setRoomPlanCoverReply(slot2)
	end
end

function slot0.sendUseRoomPlanRequest(slot0, slot1)
	slot2 = RoomModule_pb.UseRoomPlanRequest()
	slot2.id = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveUseRoomPlanReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:useRoomPlanReply(slot2)
	end
end

function slot0.sendSwitchRoomPlanRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RoomModule_pb.SwitchRoomPlanRequest()
	slot5.idA = slot1
	slot5.idB = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSwitchRoomPlanReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:switchRoomPlanReply(slot2)
	end
end

function slot0.sendDeleteRoomPlanRequest(slot0, slot1)
	slot2 = RoomModule_pb.DeleteRoomPlanRequest()
	slot2.id = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveDeleteRoomPlanReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:deleteRoomPlanReply(slot2)
	end
end

function slot0.sendCopyOtherRoomPlanRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = RoomModule_pb.CopyOtherRoomPlanRequest()
	slot7.targetUid = slot1
	slot7.id = slot2
	slot7.coverId = slot3
	slot7.name = slot4

	slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveCopyOtherRoomPlanReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:copyOtherRoomPlanReply(slot2)
	end
end

function slot0.sendGetRoomShareRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.GetRoomShareRequest()
	slot4.shareCode = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetRoomShareReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendUseRoomShareRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = RoomModule_pb.UseRoomShareRequest()
	slot7.shareCode = slot1
	slot7.id = slot2
	slot7.coverId = slot3
	slot7.name = slot4

	slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveUseRoomShareReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:useRoomShareReply(slot2)
	end
end

function slot0.sendShareRoomPlanRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.ShareRoomPlanRequest()
	slot4.id = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveShareRoomPlanReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:shareRoomPlanReply(slot2)
	end
end

function slot0.sendDeleteRoomShareRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.DeleteRoomShareRequest()
	slot4.id = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveDeleteRoomShareReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomLayoutController.instance:deleteRoomShareReply(slot2)
	end
end

function slot0.sendReportRoomRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	RoomModule_pb.ReportRoomRequest().reportedUserId = slot1
	slot7.reportType = slot2 or ""
	slot7.content = slot3 or ""
	slot7.shareCode = slot4 or ""

	slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveReportRoomReply(slot0, slot1, slot2)
end

function slot0.onReceiveBuildingLevelUpPush(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:updateBuildingInfos(slot2.buildingInfos)
		RoomInventoryBuildingModel.instance:addBuilding(slot2.buildingInfos)
		RoomMapController.instance:buildingLevelUpByInfos(slot2.buildingInfos, true)
	end
end

function slot0.sendSetWaterTypeRequest(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot4 = RoomModule_pb.SetWaterTypeRequest()

	for slot8, slot9 in pairs(slot1) do
		slot10 = RoomModule_pb.WaterInfo()
		slot10.blockId = slot8
		slot10.waterType = slot9

		table.insert(slot4.waterInfos, slot10)
	end

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetWaterTypeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = {}

	for slot8, slot9 in pairs(RoomMapBlockModel.instance:getBlockMODict()) do
		for slot13, slot14 in pairs(slot9) do
			slot3[slot14.id] = slot14
		end
	end

	for slot8, slot9 in ipairs(slot2.infos) do
		if slot3[slot9.blockId] then
			slot10:setWaterType(slot9.waterType)
			slot10:setTempWaterType()
		end
	end

	GameFacade.showToast(ToastEnum.WaterReformSuccess)
	RoomWaterReformController.instance:refreshSelectWaterBlockEntity()
	RoomWaterReformController.instance:dispatchEvent(RoomEvent.WaterReformChangeWaterType)
end

function slot0.sendSetRoomSkinRequest(slot0, slot1, slot2, slot3, slot4)
	if not slot1 or not slot2 then
		return
	end

	slot5 = RoomModule_pb.SetRoomSkinRequest()
	slot5.id = slot1
	slot5.skinId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSetRoomSkinReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomSkinModel.instance:setRoomSkinEquipped(slot2.skin.id, slot2.skin.skinId)
	RoomSkinController.instance:dispatchEvent(RoomSkinEvent.ChangeEquipRoomSkin)
end

function slot0.sendReadRoomSkinRequest(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot4 = RoomModule_pb.ReadRoomSkinRequest()
	slot4.skinId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveReadRoomSkinReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomSkinController.instance:dispatchEvent(RoomSkinEvent.RoomSkinMarkUpdate)
end

function slot0.sendBuyManufactureBuildingRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.BuyManufactureBuildingRequest()
	slot4.buildingId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveBuyManufactureBuildingInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomBuildingController.instance:buyManufactureBuildingInfoReply(slot2)
	end
end

function slot0.sendGenerateRoadRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RoomModule_pb.GenerateRoadRequest()

	for slot9, slot10 in ipairs(slot1) do
		slot11 = RoomModule_pb.RoadInfo()
		slot11.id = slot10.id > 0 and slot10.id or 0
		slot11.fromType = slot10.fromType
		slot11.toType = slot10.toType
		slot11.critterUid = slot10.critterUid or 0
		slot11.buildingUid = slot10.buildingUid or 0
		slot11.blockCleanType = slot10.blockCleanType or 0

		for slot16, slot17 in ipairs(slot10:getHexPointList()) do
			slot18 = RoomModule_pb.RoadPoint()
			slot18.x = slot17.x
			slot18.y = slot17.y

			table.insert(slot11.roadPoints, slot18)
		end

		table.insert(slot5.roadInfos, slot11)
	end

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			table.insert(slot5.ids, slot10)
		end
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveGenerateRoadReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomModel.instance:setRoadInfoListByMode(slot2.validRoadInfos, RoomEnum.GameMode.Edit)
	end
end

function slot0.sendDeleteRoadRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.DeleteRoadRequest()

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4.ids, slot9)
	end

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveDeleteRoadReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = {}

		tabletool.addValues(slot3, slot2.ids)
		RoomModel.instance:removeRoadInfoByIdsMode(slot3, RoomEnum.GameMode.Edit)
		RoomTransportController.instance:deleteRoadReply(slot2)
	end
end

function slot0.sendAllotCritterRequestt(slot0, slot1, slot2, slot3, slot4)
	slot5 = RoomModule_pb.AllotCritterRequest()
	slot5.id = slot1
	slot5.critterUid = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAllotCritterReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomTransportController.instance:allotCritterReply(slot2)

		slot3 = {
			slot2.critterUid
		}

		ManufactureController.instance:removeRestingCritterList(slot3)
		CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, {
			[slot2.id] = slot3
		}, true)
	end
end

function slot0.sendAllotVehicleRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RoomModule_pb.AllotVehicleRequest()
	slot6.id = slot1
	slot6.buildingUid = slot2
	slot6.skinId = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAllotVehicleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RoomTransportController.instance:allotVehicleReply(slot2)
	end
end

function slot0.sendGetManufactureInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(RoomModule_pb.GetManufactureInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetManufactureInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureController.instance:updateManufactureInfo(slot2)
end

function slot0.onReceiveManuBuildingInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureController.instance:updateFrozenItem(slot2.frozenItems2Count)
	ManufactureController.instance:updateManuBuildingInfoList(slot2.manuBuildingInfos)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayAddManufactureItemEff, ManufactureController.instance:getPlayAddEffDict(slot2.manuBuildingInfos))
end

function slot0.sendManuBuildingUpgradeRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.ManuBuildingUpgradeRequest()
	slot4.uid = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveManuBuildingUpgradeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureController.instance:updateManuBuildingInfo(slot2.manuBuildingInfo)
end

function slot0.sendSelectSlotProductionPlanRequest(slot0, slot1, slot2)
	RoomModule_pb.SelectSlotProductionPlanRequest().uid = slot1

	for slot7, slot8 in ipairs(slot2) do
		slot9 = RoomModule_pb.OperationInfo()
		slot9.slotId = slot8.slotId
		slot9.operation = slot8.operation
		slot9.productionId = slot8.productionId
		slot9.priority = slot8.priority

		table.insert(slot3.operationInfos, slot9)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveSelectSlotProductionPlanReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureController.instance:updateManuBuildingInfoList(slot2.manuBuildingInfos, true)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayAddManufactureItemEff, ManufactureController.instance:getPlayAddEffDict(slot2.manuBuildingInfos))
end

function slot0.sendManufactureAccelerateRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.ManufactureAccelerateRequest()
	slot4.uid = slot1
	slot4.slotId = slot3
	slot4.useItemData.materilType = slot2.type
	slot4.useItemData.materilId = slot2.id
	slot4.useItemData.quantity = slot2.quantity

	slot0:sendMsg(slot4)
end

function slot0.onReceiveManufactureAccelerateReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureController.instance:updateManuBuildingInfoList(slot2.manuBuildingInfos, true)
end

function slot0.sendReapFinishSlotRequest(slot0, slot1)
	slot2 = RoomModule_pb.ReapFinishSlotRequest()
	slot2.buildingUid = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveReapFinishSlotReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	for slot7, slot8 in ipairs(slot2.normalReapItem) do
		slot9 = MaterialDataMO.New()

		slot9:init(slot8)
		table.insert({}, slot9)
	end

	for slot7, slot8 in ipairs(slot2.criReapItem) do
		slot9 = MaterialDataMO.New()

		slot9:init(slot8)

		slot9.isShowExtra = true

		table.insert(slot3, slot9)
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot2.occupiedCriItem) do
		slot10 = MaterialDataMO.New()

		slot10:init(slot9)
		table.insert(slot4, slot10)
	end

	if next(slot3) or next(slot4) then
		ViewMgr.instance:openView(ViewName.RoomManufactureGetView, {
			normalList = slot3,
			usedList = slot4
		})
	else
		GameFacade.showToast(ToastEnum.RoomNoManufactureItemGet)
	end

	ManufactureController.instance:updateManuBuildingInfoList(slot2.manuBuildingInfos, true)
end

function slot0.sendDispatchCritterRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.DispatchCritterRequest()
	slot4.buildingUid = slot1
	slot4.critterUid = slot2
	slot4.critterSlotId = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveDispatchCritterReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureController.instance:updateWorkCritterInfo(slot2.buildingUid)

	if slot2.putSlotId then
		CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, {
			[slot2.buildingUid] = {
				[slot2.putSlotId] = slot2.critterUid
			}
		})
	end

	if slot2.infos then
		for slot6, slot7 in ipairs(slot2.infos) do
			RoomTransportController.instance:allotCritterReply(slot7)
		end
	end
end

function slot0.sendBuyRestSlotRequest(slot0, slot1, slot2)
	slot3 = RoomModule_pb.BuyRestSlotRequest()
	slot3.buildingUid = slot1
	slot3.buySlotId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveBuyRestSlotReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CritterController.instance:buySeatSlotCb(slot2.buildingUid, slot2.buySlotId)
end

function slot0.sendChangeRestCritterRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = RoomModule_pb.ChangeRestCritterRequest()
	slot8.buildingUid = slot1
	slot8.operation = slot2
	slot8.slotId1 = slot3
	slot8.critterUid = slot4
	slot8.slotId2 = slot5

	slot0:sendMsg(slot8, slot6, slot7)
end

function slot0.onReceiveChangeRestCritterReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.onReceiveRestBuildingInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CritterController.instance:setCritterBuildingInfoList(slot2.restBuildingInfos)
end

function slot0.sendFeedCritterRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RoomModule_pb.FeedCritterRequest()
	slot5.critterUid = slot1
	slot5.useFoodData.materilType = slot2.type
	slot5.useFoodData.materilId = slot2.id
	slot5.useFoodData.quantity = slot2.quantity

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveFeedCritterReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendBatchDispatchCrittersRequest(slot0, slot1)
	slot2 = RoomModule_pb.BatchDispatchCrittersRequest()
	slot2.type = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveBatchDispatchCrittersReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureController.instance:openRouseCritterView(slot2)
end

function slot0.sendRouseCrittersRequest(slot0, slot1, slot2)
	RoomModule_pb.RouseCrittersRequest().type = slot1

	for slot7, slot8 in ipairs(slot2) do
		slot9 = RoomModule_pb.BatchDispatchInfo()
		slot9.buildingUid = slot8.buildingUid
		slot9.roadId = slot8.roadId

		for slot13, slot14 in ipairs(slot8.critterUids) do
			table.insert(slot9.critterUids, slot14)
		end

		table.insert(slot3.infos, slot9)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRouseCrittersReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = {}

	if slot2.type == CritterEnum.OneKeyType.Transport then
		RoomTransportController.instance:batchCritterReply(slot2.roadInfos)
	end

	slot5 = {}

	if slot2.validInfos then
		for slot9, slot10 in ipairs(slot2.validInfos) do
			slot11 = slot4 and slot10.roadId or slot10.buildingUid
			slot3[slot11] = slot3[slot11] or {}

			for slot15, slot16 in ipairs(slot10.infos) do
				slot17 = slot16.critterUid
				slot3[slot11][slot16.slotId] = slot17
				slot5[#slot5 + 1] = slot17
			end
		end
	end

	ManufactureController.instance:removeRestingCritterList(slot5)
	CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, slot3, slot4)
end

function slot0.sendBatchAddProctionsRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RoomModule_pb.BatchAddProctionsRequest()
	slot6.type = slot1
	slot6.freeInfo.buildingType = slot2 or 0
	slot6.freeInfo.buildingDefineId = slot3 or 0
	slot7 = MaterialModule_pb.M2QEntry()
	slot7.materialId = slot4 or 0
	slot7.quantity = slot5 or 0

	table.insert(slot6.freeInfo.item2Count, slot7)
	slot0:sendMsg(slot6)
end

function slot0.onReceiveBatchAddProctionsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendGetFrozenItemInfoRequest(slot0)
	slot0:sendMsg(RoomModule_pb.GetFrozenItemInfoRequest())
end

function slot0.onReceiveGetFrozenItemInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureController.instance:updateFrozenItem(slot2.frozenItems2Count)
end

function slot0.sendGetOrderInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(RoomModule_pb.GetOrderInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetOrderInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeModel.instance:onGetOrderInfo(slot2)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeOrderInfo)
end

function slot0.sendFinishOrderRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.FinishOrderRequest()
	slot4.orderType = slot1
	slot4.orderId = slot2

	if slot3 then
		slot4.sellCount = slot3
	end

	slot0:sendMsg(slot4)
end

function slot0.onReceiveFinishOrderReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeController.instance:onFinishOrderReply(slot2)
end

function slot0.sendRefreshPurchaseOrderRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	RoomModule_pb.RefreshPurchaseOrderRequest().orderId = slot1
	slot6.guideId = slot2 or 0
	slot6.step = slot3 or 0

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveRefreshPurchaseOrderReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeController.instance:onRefreshDailyOrderReply(slot2)
end

function slot0.sendChangePurchaseOrderTraceStateRequest(slot0, slot1, slot2)
	slot3 = RoomModule_pb.ChangePurchaseOrderTraceStateRequest()
	slot3.orderId = slot1
	slot3.isTrace = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveChangePurchaseOrderTraceStateReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeController.instance:onTracedDailyOrderReply(slot2)
end

function slot0.sendLockOrderRequest(slot0, slot1, slot2)
	RoomModule_pb.LockOrderRequest().orderId = slot1
	slot3.operation = slot2 and 1 or 2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveLockOrderReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeController.instance:onLockedDailyOrderReply(slot2)
end

function slot0.sendGetTradeTaskInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(RoomModule_pb.GetTradeTaskInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetTradeTaskInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onGetTradeTaskInfo(slot2)
end

function slot0.sendReadNewTradeTaskRequest(slot0, slot1)
	slot2 = RoomModule_pb.ReadNewTradeTaskRequest()

	for slot6, slot7 in pairs(slot1) do
		slot2.ids:append(slot7)
	end

	slot0:sendMsg(slot2)
end

function slot0.onReceiveReadNewTradeTaskReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onReadNewTradeTask(slot2.ids)
end

function slot0.sendGetTradeSupportBonusRequest(slot0, slot1)
	slot2 = RoomModule_pb.GetTradeSupportBonusRequest()
	slot2.id = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetTradeSupportBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onGetLevelBonus(slot2.id)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeSupportBonusReply)
end

function slot0.sendTradeLevelUpRequest(slot0)
	slot0:sendMsg(RoomModule_pb.TradeLevelUpRequest())
end

function slot0.onReceiveTradeLevelUpReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ManufactureModel.instance:setTradeLevel(slot2.level)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnTradeLevelUpReply, slot2.level)
end

function slot0.onReceiveTradeTaskPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onRefeshTaskMo(slot2.infos)
	slot0:sendGetTradeTaskInfoRequest()
end

function slot0.sendGetTradeTaskExtraBonusRequest(slot0)
	slot0:sendMsg(RoomModule_pb.GetTradeTaskExtraBonusRequest())
end

function slot0.onReceiveGetTradeTaskExtraBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:setCanGetExtraBonus()
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeTaskExtraBonusReply)
end

function slot0.sendGetRoomLogRequest(slot0)
	slot0:sendMsg(RoomModule_pb.GetRoomLogRequest())
end

function slot0.onReceiveGetRoomLogReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomLogModel.instance:setInfos(slot2.infos)
end

function slot0.sendReadRoomLogNewRequest(slot0, slot1)
	slot0:sendMsg(RoomModule_pb.ReadRoomLogNewRequest())
end

function slot0.onReceiveReadRoomLogNewReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendGainGuideBuildingRequest(slot0, slot1, slot2)
	slot3 = RoomModule_pb.GainGuideBuildingRequest()
	slot3.guideId = slot1
	slot3.step = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGainGuideBuildingReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.GetGuideBuilding, slot2)
end

function slot0.sendAccelerateGuidePlanRequest(slot0, slot1, slot2)
	slot3 = RoomModule_pb.AccelerateGuidePlanRequest()
	slot3.guideId = slot1
	slot3.step = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAccelerateGuidePlanReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.AccelerateGuidePlan, slot2)
end

function slot0.sendUnloadRestBuildingCrittersRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.UnloadRestBuildingCrittersRequest()
	slot4.buildingUid = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveUnloadRestBuildingCrittersReply(slot0, slot1, slot2)
end

function slot0.sendReplaceRestBuildingCrittersRequest(slot0, slot1, slot2, slot3)
	slot4 = RoomModule_pb.ReplaceRestBuildingCrittersRequest()
	slot4.buildingUid = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveReplaceRestBuildingCrittersReply(slot0, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
