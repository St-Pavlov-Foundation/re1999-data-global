module("modules.logic.critter.controller.CritterController", package.seeall)

slot0 = class("CritterController", BaseController)

function slot0.onInit(slot0)
	slot0._oldWorkPathId = nil
	slot0._isToastStopWork = false
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0._oldWorkPathId = nil
	slot0._isToastStopWork = false
end

function slot0.critterGetInfoReply(slot0, slot1)
	CritterModel.instance:initCritter(slot1.critterInfos)
end

function slot0.critterInfoPush(slot0, slot1)
	slot2 = slot1.critterInfos or {}

	for slot6, slot7 in ipairs(slot2) do
		CritterModel.instance:addCritter(slot7)
	end

	slot0:dispatchEvent(CritterEvent.CritterInfoPushReply)

	slot0.tempCritterMoList = {}

	for slot6, slot7 in ipairs(slot2) do
		slot8 = CritterMO.New()

		slot8:init(slot7)

		slot0.tempCritterMoList[slot6] = slot8
	end
end

function slot0.startTrainCritterReply(slot0, slot1)
	if CritterModel.instance:getCritterMOByUid(slot1.uid) then
		slot2.trainInfo.heroId = slot1.heroId

		if RoomTrainSlotListModel.instance:findWaitingSlotMOByUid(slot1.uid) or RoomTrainSlotListModel.instance:findFreeSlotMO() then
			slot3:setCritterMO(slot2)
		end
	end

	slot0:dispatchEvent(CritterEvent.TrainStartTrainCritterReply, slot1.uid, slot1.heroId)
end

function slot0.fastForwardTrainReply(slot0, slot1)
	slot0:dispatchEvent(CritterEvent.FastForwardTrainReply)
end

function slot0.cancelTrainReply(slot0, slot1)
	if RoomTrainSlotListModel.instance:getSlotMOByCritterUi(slot1.uid) then
		slot2:setCritterMO(nil)
	end

	slot0:dispatchEvent(CritterEvent.TrainCancelTrainReply, slot1.uid)
end

function slot0.selectEventOptionReply(slot0, slot1)
	slot0:dispatchEvent(CritterEvent.TrainSelectEventOptionReply, slot1.uid, slot1.eventId or 0)
end

function slot0.finishTrainCritterReply(slot0, slot1)
	if CritterModel.instance:getCritterMOByUid(slot1.uid) then
		slot2.trainInfo.heroId = 0
	end

	if RoomTrainSlotListModel.instance:getSlotMOByCritterUi(slot1.uid) then
		slot3:setCritterMO(nil)
	end

	slot0:dispatchEvent(CritterEvent.TrainFinishTrainCritterReply, slot1.uid, slot1.heroId)
end

function slot0.startTrainCritterPreviewReply(slot0, slot1)
	slot2 = slot1.info

	if CritterModel.instance:getTrainPreviewMO(slot2.uid, slot2.trainInfo and slot2.trainInfo.heroId) then
		slot5:init(slot2)
	else
		slot5 = CritterMO.New()

		slot5:init(slot2)
		CritterModel.instance:addTrainPreviewMO(slot5)
	end

	slot0:dispatchEvent(CritterEvent.StartTrainCritterPreviewReply, slot3, slot4)
end

function slot0.finishTrainSpecialEventByUid(slot0, slot1)
	if CritterModel.instance:getCritterMOByUid(slot1) and slot2:isCultivating() then
		for slot7 = 1, #slot2.trainInfo.events do
			if slot3[slot7]:getEventType() == CritterEnum.EventType.Special and not slot8:isEventFinish() then
				slot9 = 0

				if #slot8.options > 0 then
					slot9 = slot8.options[1].optionId
				end

				CritterRpc.instance:sendSelectEventOptionRequest(slot2.uid, slot8.eventId, slot9)
			end
		end
	end
end

function slot0.banishCritterReply(slot0, slot1)
	CritterModel.instance:removeCritters(slot1.uids)
	ManufactureController.instance:removeRestingCritterList(slot1.uids)
	slot0:dispatchEvent(CritterEvent.CritterDecomposeReply, slot1.uids)
end

function slot0.lockCritterRequest(slot0, slot1)
	if CritterModel.instance:getCritterMOByUid(slot1.uid) then
		slot2.lock = slot1.lock
	end

	slot0:dispatchEvent(CritterEvent.CritterChangeLockStatus, slot1.uid)
end

function slot0.critterRenameReply(slot0, slot1)
	CritterModel.instance:getCritterMOByUid(slot1.uid).name = slot1.name

	slot0:dispatchEvent(CritterEvent.CritterRenameReply, slot1.uid)
end

function slot0.updateCritterPreviewAttr(slot0, slot1, slot2, slot3, slot4)
	CritterRpc.instance:sendGetRealCritterAttributeRequest(slot1, slot2, true, slot3, slot4)
end

function slot0.setManufactureCritterList(slot0, slot1, slot2, slot3, slot4)
	ManufactureCritterListModel.instance:setCritterNewList(slot2, slot3, slot4)

	slot5 = ManufactureCritterListModel.instance:getPreviewCritterUidList()

	if slot1 and slot5 and #slot5 > 0 then
		slot0:updateCritterPreviewAttr(slot1, slot5, slot0._setCritterList, slot0)
	else
		slot0:_setCritterList()
	end
end

function slot0._setCritterList(slot0)
	slot0:dispatchEvent(CritterEvent.CritterListResetScrollPos)
	ManufactureCritterListModel.instance:setManufactureCritterList()
	slot0:dispatchEvent(CritterEvent.CritterListUpdate)
end

function slot0.getNextCritterPreviewAttr(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if ManufactureCritterListModel.instance:getPreviewCritterUidList(slot2) and #slot3 > 0 then
		slot0:updateCritterPreviewAttr(slot1, slot3)
	end
end

function slot0.clickCritterPlaceItem(slot0, slot1, slot2)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		return
	end

	slot4 = slot2

	if slot3:isCritterInSeatSlot(slot2) then
		slot4 = CritterEnum.InvalidCritterUid
	else
		slot5 = slot3:getNextEmptyCritterSeatSlot()
	end

	if not slot5 then
		GameFacade.showToast(ToastEnum.RoomNoEmptySeatSlot)

		return
	end

	slot0:changeRestCritter(slot1, slot5, slot4)
end

function slot0.waitSendBuildManufacturAttrByBuid(slot0, slot1)
	slot0._waitBuildManufacturBuidList = slot0._waitBuildManufacturBuidList or {}

	if not slot1 or tabletool.indexOf(slot0._waitBuildManufacturBuidList, slot1) then
		return
	end

	table.insert(slot0._waitBuildManufacturBuidList, slot1)

	if #slot0._waitBuildManufacturBuidList == 1 then
		TaskDispatcher.runDelay(slot0._onRunSendBuildManufacturAll, slot0, 1)
	end
end

function slot0._onRunSendBuildManufacturAll(slot0)
	slot0._waitBuildManufacturBuidList = nil

	if slot0._waitBuildManufacturBuidList then
		for slot5 = 1, #slot1 do
			slot0:sendBuildManufacturAttrByBuid(slot1[slot5])
		end
	end
end

function slot0.sendBuildManufacturAttrByBtype(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot8 and slot8.config and slot8.config.buildingType == slot1 then
			if slot2 == true then
				slot0:waitSendBuildManufacturAttrByBuid(slot8.id)
			else
				slot0:sendBuildManufacturAttrByBuid(slot8.id)
			end
		end
	end
end

function slot0.sendBuildManufacturAttrByBuid(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		return
	end

	slot4 = nil

	for slot8, slot9 in ipairs(CritterModel.instance:getAllCritters()) do
		if slot9:isMaturity() and slot9.workInfo and slot9.workInfo.workBuildingUid == slot1 or slot9.restInfo and slot9.restInfo.restBuildingUid == slot1 then
			table.insert(slot4 or {}, slot9:getId())
		end
	end

	if slot4 then
		CritterRpc.instance:sendGetRealCritterAttributeRequest(slot2.buildingId, slot4, false)
	end
end

function slot0.clickCritterInCritterBuilding(slot0, slot1, slot2)
	slot5, slot6 = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) or not slot3:isCritterInSeatSlot(slot2) or slot5 == slot1 and slot6 == slot4 then
		slot0:clearSelectedCritterSeatSlot()
	else
		ManufactureModel.instance:setSelectedCritterSeatSlot(slot1, slot4)
		slot0:dispatchEvent(CritterEvent.CritterBuildingSelectCritter)
	end
end

function slot0.clearSelectedCritterSeatSlot(slot0)
	ManufactureModel.instance:setSelectedCritterSeatSlot()
	slot0:dispatchEvent(CritterEvent.CritterBuildingSelectCritter)
end

function slot0.changeRestCritter(slot0, slot1, slot2, slot3)
	RoomRpc.instance:sendChangeRestCritterRequest(slot1, CritterEnum.SeatSlotOperation.Change, slot2, slot3, 0, slot0._afterChangeRestCritter, slot0)
	ManufactureModel.instance:setNewRestCritter(slot3)

	slot0._isToastStopWork = false
	slot0._oldWorkPathId = nil

	if CritterModel.instance:getCritterMOByUid(slot3) and not slot4:isNoMood() then
		slot7 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot3)

		if ManufactureModel.instance:getCritterWorkingBuilding(slot3) or slot7 then
			slot0._isToastStopWork = true

			if slot7 then
				slot0._oldWorkPathId = slot7.id
			end
		end
	end
end

function slot0._afterChangeRestCritter(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		slot0._isToastStopWork = false

		return
	end

	if slot0._isToastStopWork then
		GameFacade.showToast(ToastEnum.CritterStopWork)
	end

	if slot0._oldWorkPathId then
		slot4 = {
			critterUid = CritterEnum.InvalidCritterUid
		}

		RoomTransportPathModel.instance:updateInofoById(slot0._oldWorkPathId, slot4)
		RoomMapTransportPathModel.instance:updateInofoById(slot0._oldWorkPathId, slot4)
	end

	slot0._oldWorkPathId = nil
	slot0._isToastStopWork = false
end

function slot0.exchangeSeatSlot(slot0, slot1, slot2, slot3)
	if RoomMapBuildingModel.instance:getBuildingMOById(slot1):getSeatSlotMO(slot3) then
		RoomRpc.instance:sendChangeRestCritterRequest(slot1, CritterEnum.SeatSlotOperation.Exchange, slot2, CritterEnum.InvalidCritterUid, slot3)
	elseif RoomCameraController.instance:getRoomScene() then
		slot6.buildingcrittermgr:refreshAllCritterEntityPos()
	end
end

function slot0.setCritterBuildingInfoList(slot0, slot1)
	if not slot1 then
		return
	end

	ManufactureModel.instance:setCritterBuildingInfoList(slot1)
	RoomCritterModel.instance:initStayBuildingCritters()
	slot0:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
end

function slot0.buySeatSlot(slot0, slot1, slot2)
	RoomRpc.instance:sendBuyRestSlotRequest(slot1, slot2)
end

function slot0.buySeatSlotCb(slot0, slot1, slot2)
	if not ManufactureModel.instance:getCritterBuildingMOById(slot1) then
		return
	end

	slot3:unlockSeatSlot(slot2)
	slot0:dispatchEvent(CritterEvent.CritterUnlockSeatSlot)
end

function slot0.openCritterFilterView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RoomCritterFilterView, {
		filterTypeList = slot1,
		viewName = slot2
	})
end

function slot0.openCriiterDetailSimpleView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomCriiterDetailSimpleView, {
		critterMo = slot1
	})
end

function slot0.openRoomCritterDetailView(slot0, slot1, slot2, slot3, slot4)
	if slot1 then
		ViewMgr.instance:openView(ViewName.RoomCritterDetailYoungView, {
			isYoung = slot1,
			critterMo = slot2,
			isPreview = slot3,
			critterMos = slot4
		})
	else
		ViewMgr.instance:openView(ViewName.RoomCritterDetailMaturityView, slot5)
	end
end

function slot0.popUpCritterGetView(slot0)
	if slot0.tempCritterMoList and #slot1 > 0 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomGetCritterView, ViewName.RoomGetCritterView, {
			isSkip = true,
			mode = RoomSummonEnum.SummonType.ItemGet,
			critterMOList = slot1
		})

		slot0.tempCritterMoList = nil
	end
end

slot0.instance = slot0.New()

return slot0
