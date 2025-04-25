module("modules.logic.room.controller.ManufactureController", package.seeall)

slot0 = class("ManufactureController", BaseController)
slot1 = 0.2

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0._realOpenManufactureBuildingView, slot0)
	TaskDispatcher.cancelTask(slot0._realOpenCritterBuildingView, slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.checkManufactureInfoUpdate(slot0)
	slot1 = false

	for slot6, slot7 in ipairs(ManufactureModel.instance:getAllPlacedManufactureBuilding()) do
		if slot7:getSlotProgress(slot7:getSlotIdInProgress()) >= 1 then
			slot1 = true

			break
		end
	end

	if slot1 then
		slot0:getManufactureServerInfo()
	end
end

function slot0.updateTraceNeedItemDict(slot0)
	if RoomController.instance:isRoomScene() and RoomTradeModel.instance:isGetOrderInfo() then
		RoomTradeModel.instance:calTracedItemDict()
	end
end

function slot0.getManufactureServerInfo(slot0)
	if not ManufactureModel.instance:isManufactureUnlock() then
		return
	end

	RoomRpc.instance:sendGetManufactureInfoRequest()
end

function slot0.setManufactureItems(slot0, slot1, slot2)
	RoomRpc.instance:sendSelectSlotProductionPlanRequest(slot1, slot2)
end

function slot0.upgradeManufactureBuilding(slot0, slot1)
	RoomRpc.instance:sendManuBuildingUpgradeRequest(slot1)
end

function slot0.allocateCritter(slot0, slot1, slot2, slot3)
	RoomRpc.instance:sendDispatchCritterRequest(slot1, slot2, slot3)
end

function slot0.useAccelerateItem(slot0, slot1, slot2, slot3, slot4)
	if not slot4 then
		logError("ManufactureController:useAccelerateItem error, slotId is nil")

		return
	end

	slot0:clearSelectedSlotItem()
	RoomRpc.instance:sendManufactureAccelerateRequest(slot1, {
		type = MaterialEnum.MaterialType.Item,
		id = slot2,
		quantity = slot3
	}, slot4)
end

function slot0.gainCompleteManufactureItem(slot0, slot1)
	RoomRpc.instance:sendReapFinishSlotRequest(slot1 or RoomManufactureEnum.InvalidBuildingUid)
end

function slot0.updateManufactureInfo(slot0, slot1)
	ManufactureModel.instance:resetDataBeforeSetInfo()

	if slot1 then
		ManufactureModel.instance:setManufactureInfo(slot1)
		RoomCritterModel.instance:initStayBuildingCritters()
	end

	slot0:dispatchEvent(ManufactureEvent.ManufactureInfoUpdate)
end

function slot0.updateTradeLevel(slot0, slot1)
	ManufactureModel.instance:setTradeLevel(slot1)
	slot0:dispatchEvent(ManufactureEvent.TradeLevelChange)
end

function slot0.updateManuBuildingInfoList(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	ManufactureModel.instance:setManuBuildingInfoList(slot1)

	slot3 = {
		[slot8.buildingUid] = true
	}

	for slot7, slot8 in ipairs(slot1) do
		-- Nothing
	end

	RoomCritterModel.instance:initStayBuildingCritters()

	if slot2 then
		ManufactureModel.instance:clientCalAllFrozenItemDict()
	end

	slot0:dispatchEvent(ManufactureEvent.ManufactureBuildingInfoChange, slot3)
end

function slot0.updateManuBuildingInfo(slot0, slot1)
	if not slot1 then
		return
	end

	ManufactureModel.instance:setManuBuildingInfo(slot1, true)
	RoomCritterModel.instance:initStayBuildingCritters()
	slot0:dispatchEvent(ManufactureEvent.ManufactureBuildingInfoChange, {
		[slot1.buildingUid] = true
	})
end

function slot0.updateWorkCritterInfo(slot0, slot1)
	slot0:dispatchEvent(ManufactureEvent.CritterWorkInfoChange, slot1)
end

function slot0.updateFrozenItem(slot0, slot1)
	ManufactureModel.instance:setFrozenItemDict(slot1)
end

function slot0.jumpToManufactureBuildingLevelUpView(slot0, slot1)
	slot2 = false

	if ManufactureModel.instance:isManufactureUnlock(true) then
		if RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
			if ManufactureConfig.instance:isManufactureBuilding(slot4.buildingId) then
				if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
					slot0:closeCritterBuildingView(true)
				end

				if ViewMgr.instance:isOpen(ViewName.RoomTradeView) then
					ViewMgr.instance:closeView(ViewName.RoomTradeView, false)
				end

				ViewMgr.instance:closeAllPopupViews({
					ViewName.RoomTradeView
				})

				slot8 = false
				slot9, slot10 = ManufactureModel.instance:getCameraRecord()

				if slot9 or slot10 then
					slot8 = true
				end

				slot0:openManufactureBuildingViewByBuilding(slot4, slot8, true)

				slot2 = true
			else
				logError(string.format("ManufactureController:jumpToManufactureBuildingLevelUpView error, not manufacture building, buildingUid:%s", slot1))
			end
		else
			logError(string.format("ManufactureController:jumpToManufactureBuildingLevelUpView error, not find building, buildingUid:%s", slot1))
		end
	end

	return slot2
end

function slot0.openManufactureBuildingViewByBuilding(slot0, slot1, slot2, slot3, slot4)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	if not slot1 then
		return
	end

	slot0:openManufactureBuildingViewByType(RoomConfig.instance:getBuildingType(slot1.buildingId), slot1.uid, slot2, slot3, slot4)
end

function slot0.openManufactureBuildingViewByType(slot0, slot1, slot2, slot3, slot4, slot5)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	if slot1 ~= RoomBuildingEnum.BuildingType.Collect and slot1 ~= RoomBuildingEnum.BuildingType.Process and slot1 ~= RoomBuildingEnum.BuildingType.Manufacture then
		return
	end

	if not RoomMapBuildingModel.instance:getBuildingListByType(slot1) or #slot7 <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceManufactureBuilding)

		return
	end

	slot8 = nil
	slot9 = false

	if slot2 and RoomMapBuildingModel.instance:getBuildingMOById(slot2) and slot8.config and slot8.config.buildingType == slot1 then
		slot9 = true
	end

	if not slot9 then
		slot8 = slot7[1]
		slot2 = slot7[1].buildingUid
	end

	slot0._tmpManuBuildingViewParam = {
		buildingType = slot1,
		defaultBuildingUid = slot2,
		addManuItem = slot5
	}
	slot0._tmpJumpLvUpBuildingUid = slot4 and slot2 or nil
	slot11 = ManufactureConfig.instance:getBuildingCameraIdByIndex(slot8.buildingId)

	if RoomCameraController.instance:getRoomCamera() and slot11 then
		if not slot3 then
			ManufactureModel.instance:setCameraRecord(slot12:getCameraState(), LuaUtil.deepCopy(slot12:getCameraParam()))
		end

		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(slot2, slot11)
		TaskDispatcher.cancelTask(slot0._realOpenManufactureBuildingView, slot0)
		TaskDispatcher.runDelay(slot0._realOpenManufactureBuildingView, slot0, uv0)
	else
		slot0:_realOpenManufactureBuildingView()
	end

	slot0:dispatchEvent(ManufactureEvent.OnEnterManufactureBuildingView)
	slot0:dispatchEvent(ManufactureEvent.ManufactureBuildingViewChange, {
		inManufactureBuildingView = true
	})
end

function slot0.openRoomManufactureBuildingDetailView(slot0, slot1, slot2)
	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) and (slot3:checkSameType(RoomBuildingEnum.BuildingType.Collect) or slot3:checkSameType(RoomBuildingEnum.BuildingType.Process) or slot3:checkSameType(RoomBuildingEnum.BuildingType.Manufacture)) then
		ViewMgr.instance:openView(ViewName.RoomManufactureBuildingDetailView, {
			buildingUid = slot1,
			buildingMO = slot3,
			showIsRight = slot2
		})

		return true
	end

	return false
end

function slot0._realOpenManufactureBuildingView(slot0)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	if not (slot0._tmpManuBuildingViewParam and slot0._tmpManuBuildingViewParam.buildingType) then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomManufactureBuildingView, slot0._tmpManuBuildingViewParam)

	slot0._tmpManuBuildingViewParam = nil

	slot0:jump2ManufactureUpgradeView()
end

function slot0.jump2ManufactureUpgradeView(slot0, slot1)
	if not slot0._tmpJumpLvUpBuildingUid and not slot1 then
		return
	end

	slot0:openManufactureBuildingLevelUpView(slot1 or slot0._tmpJumpLvUpBuildingUid)

	slot0._tmpJumpLvUpBuildingUid = nil
end

function slot0.openManufactureBuildingLevelUpView(slot0, slot1)
	if ManufactureModel.instance:isMaxLevel(slot1) then
		return
	end

	if ManufactureConfig.instance:getBuildingUpgradeGroup(RoomMapBuildingModel.instance:getBuildingMOById(slot1).buildingId) == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomBuildingLevelUpView, ManufactureModel.instance:getManufactureLevelUpParam(slot1))
end

function slot0.openManufactureAccelerateView(slot0, slot1)
	if (RoomMapBuildingModel.instance:getBuildingMOById(slot1) and slot2:getManufactureState()) ~= RoomManufactureEnum.ManufactureState.Running then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomManufactureAccelerateView, {
		buildingUid = slot1
	})
end

function slot0.openRoomRecordView(slot0, slot1)
	if (slot1 or RoomRecordEnum.View.Task) == RoomRecordEnum.View.Task then
		RoomRpc.instance:sendGetTradeTaskInfoRequest(function ()
			uv0:_reallyOpenRoomRecordView(uv1)
		end, slot0)
	else
		slot0:_reallyOpenRoomRecordView(slot1)
	end
end

function slot0._reallyOpenRoomRecordView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomRecordView, slot1)
end

function slot0.openCritterBuildingView(slot0, slot1, slot2, slot3)
	if not CritterModel.instance:isCritterUnlock(true) then
		return
	end

	if not ManufactureModel.instance:getCritterBuildingListInOrder() or #slot5 <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceCritterBuilding)

		return
	end

	slot6 = nil

	if not slot1 then
		slot6 = slot5[1]
		slot1 = slot5[1].buildingUid
	else
		slot6 = RoomMapBuildingModel.instance:getBuildingMOById(slot1)
	end

	if (slot6 and slot6.config.buildingType) ~= RoomBuildingEnum.BuildingType.Rest then
		return
	end

	if RoomCameraController.instance:getRoomCamera() and ManufactureConfig.instance:getBuildingCameraIdByIndex(slot6.buildingId, slot2) then
		ManufactureModel.instance:setCameraRecord(slot10:getCameraState(), LuaUtil.deepCopy(slot10:getCameraParam()))

		slot0._tmpCritterBuildingUid = slot1
		slot0._tmpCritterDefaultTab = slot2
		slot0._tmpCritterUid = slot3
		slot14 = false

		if slot2 == RoomCritterBuildingViewContainer.SubViewTabId.Training and slot3 then
			slot14 = CritterModel.instance:getCritterMOByUid(slot3) and slot15:isCultivating()
		end

		TaskDispatcher.cancelTask(slot0._realOpenCritterBuildingView, slot0)

		if slot14 then
			slot0:_realOpenCritterBuildingView(slot1, slot2, slot3)
		else
			RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(slot1, slot9, slot0._openCritterBuildingViewCameraTweenFinish, slot0)
			TaskDispatcher.runDelay(slot0._realOpenCritterBuildingView, slot0, uv0)
		end
	else
		slot0:_realOpenCritterBuildingView(slot1, slot2, slot3)
	end

	CritterController.instance:dispatchEvent(CritterEvent.onEnterCritterBuildingView)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChange, {
		inCritterBuildingView = true
	})

	return true
end

function slot0._realOpenCritterBuildingView(slot0, slot1, slot2, slot3)
	slot2 = slot2 or slot0._tmpCritterDefaultTab
	slot3 = slot3 or slot0._tmpCritterUid

	if not (slot1 or slot0._tmpCritterBuildingUid) then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomCritterBuildingView, {
		buildingUid = slot1,
		defaultTab = slot2,
		critterUid = slot3
	})
	slot0:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, 0, true)
end

function slot0.closeCritterBuildingView(slot0, slot1)
	if slot1 then
		slot0:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, RoomManufactureEnum.AudioDelayTime, false)
	end

	ViewMgr.instance:closeView(ViewName.RoomCritterBuildingView)
end

function slot0._openCritterBuildingViewCameraTweenFinish(slot0)
	slot0._tmpCritterBuildingUid = nil
	slot0._tmpCritterDefaultTab = nil
	slot0._tmpCritterUid = nil

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingCameraTweenFinish, slot0._tmpCritterDefaultTab)
end

function slot0.openCritterPlaceView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomCritterPlaceView, {
		buildingUid = slot1
	})
end

function slot0.openOverView(slot0, slot1)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	if not ManufactureModel.instance:getAllPlacedManufactureBuilding() or #slot3 <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceManufactureBuilding)

		return
	end

	ViewMgr.instance:openView(ViewName.RoomOverView, {
		openFromRest = slot1
	})

	return true
end

function slot0.openRoomTradeView(slot0, slot1, slot2)
	if ManufactureModel.instance:getTradeLevel() < RoomTradeTaskModel.instance:getOpenOrderLevel() then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	if not ManufactureModel.instance:getTradeBuildingListInOrder() or #slot4 <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoTradeBuilding)

		return
	end

	RoomRpc.instance:sendGetFrozenItemInfoRequest()

	slot1 = slot1 or slot4[1].buildingUid

	if RoomCameraController.instance:getRoomCamera() and slot1 then
		ManufactureModel.instance:setCameraRecord(slot5:getCameraState(), LuaUtil.deepCopy(slot5:getCameraParam()))
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(slot1, RoomTradeEnum.CameraId, function ()
			uv0 = uv0 or 1

			ViewMgr.instance:openView(ViewName.RoomTradeView, {
				defaultTab = uv0
			})
		end)
	else
		slot6()
	end

	return true
end

function slot0.openRoomBackpackView(slot0)
	if not ManufactureModel.instance:isManufactureUnlock(true) then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomBackpackView)

	return true
end

function slot0.jump2PlaceManufactureBuildingView(slot0)
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		if ViewMgr.instance:isOpen(ViewName.RoomTradeView) then
			RoomTradeController.instance:dispatchEvent(RoomTradeEvent.PlayCloseTVAnim)
		end

		if ViewMgr.instance:isOpen(ViewName.RoomBackpackView) or ViewMgr.instance:isOpen(ViewName.RoomOverView) then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
		end

		ViewMgr.instance:closeView(ViewName.RoomManufactureMaterialTipView)
		ManufactureModel.instance:setIsJump2ManufactureBuildingList(true)
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
	end
end

function slot0.clickWrongBtn(slot0, slot1, slot2)
	if ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView) and slot0._lastWrongBuildingUid == slot1 then
		slot0:closeWrongTipView()
	else
		slot0:clearSelectedSlotItem()
		slot0:clearSelectCritterSlotItem()
		ViewMgr.instance:openView(ViewName.RoomManufactureWrongTipView, {
			buildingUid = slot1,
			isRight = slot2
		})

		slot0._lastWrongBuildingUid = slot1
	end
end

function slot0.clickWrongJump(slot0, slot1, slot2, slot3, slot4)
	if not slot1 then
		return
	end

	if not RoomManufactureEnum.WrongTypeHandlerFunc[slot1] then
		return
	end

	if slot5(slot0, slot2, slot3, slot4) then
		slot0:closeWrongTipView()
	end
end

function slot0._addPreMat(slot0, slot1, slot2, slot3)
	slot4 = nil
	slot5 = slot3.isOverView

	if RoomMapBuildingModel.instance:getBuildingListByType(slot2, true) and #slot7 > 0 then
		if slot2 == RoomBuildingEnum.BuildingType.Collect then
			for slot11, slot12 in ipairs(slot7) do
				if slot0:getNextEmptySlot(slot12.id) then
					slot4 = slot12

					break
				end
			end

			if not slot4 then
				slot4 = slot7[1]
			end
		else
			for slot11, slot12 in ipairs(slot7) do
				if ManufactureConfig.instance:isManufactureItemBelongBuilding(slot12.buildingId, slot1) then
					slot4 = slot12

					break
				end
			end
		end
	end

	if not slot4 then
		return false
	end

	if slot5 then
		slot0:dispatchEvent(ManufactureEvent.ManufactureOverViewFocusAddPop, slot4.id, slot1)
	else
		slot0:openManufactureBuildingViewByBuilding(slot4, true, false, slot1)
	end

	return true
end

function slot0._lvUpBuilding(slot0, slot1, slot2, slot3)
	slot4 = nil
	slot5 = 0

	if RoomMapBuildingModel.instance:getBuildingListByType(slot2, true) and #slot6 > 0 then
		for slot10, slot11 in ipairs(slot6) do
			if ManufactureConfig.instance:isManufactureItemBelongBuilding(slot11.buildingId, slot1) then
				slot15 = slot11.level

				if not ManufactureModel.instance:isMaxLevel(slot11.id) and slot5 < slot15 then
					slot4 = slot11
					slot5 = slot15
				end
			end
		end
	end

	if not slot4 then
		return false
	end

	slot0:jumpToManufactureBuildingLevelUpView(slot4.id)

	return true
end

function slot0._linPath(slot0, slot1, slot2, slot3)
	if ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen) <= ManufactureModel.instance:getTradeLevel() then
		if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot2, slot3.pathToType) and slot7:isLinkFinish() and not (slot7 and slot7:hasCritterWorking()) then
			slot0:closeWrongTipView()
			ViewMgr.instance:closeView(ViewName.RoomOverView, true)
			RoomTransportController.instance:openTransportSiteView(RoomTransportHelper.fromTo2SiteType(slot2, slot3.pathToType), RoomEnum.CameraState.Overlook)

			if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
				slot0:closeCritterBuildingView(true)
			end

			if ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView) then
				ViewMgr.instance:closeView(ViewName.RoomManufactureBuildingView)
				ManufactureModel.instance:setCameraRecord()
			end
		else
			RoomJumpController.instance:jumpToTransportSiteView()
		end
	else
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)
	end
end

function slot0.closeWrongTipView(slot0)
	ViewMgr.instance:closeView(ViewName.RoomManufactureWrongTipView)
end

function slot0.clickSlotItem(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot4 then
		slot7 = RoomManufactureEnum.SlotState.Locked

		if RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
			slot7 = slot8:getSlotState(slot2)
		end

		if slot7 == RoomManufactureEnum.SlotState.Locked then
			GameFacade.showToast(ToastEnum.RoomSlotLocked, ManufactureConfig.instance:getSlotUnlockNeedLevel(ManufactureConfig.instance:getBuildingUpgradeGroup(slot8.buildingId), slot5))

			return
		end

		if slot7 == RoomManufactureEnum.SlotState.Complete then
			if slot3 then
				slot0:gainCompleteManufactureItem()
			else
				slot0:gainCompleteManufactureItem(slot1)
			end

			return
		end
	end

	if ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView) and ManufactureModel.instance:getSelectedSlot() == slot1 then
		slot0:clearSelectedSlotItem()
	else
		slot0:refreshSelectedSlotId(slot1, true)
		slot0:clearSelectCritterSlotItem()
		slot0:closeWrongTipView()
		ManufactureModel.instance:setReadNewManufactureFormula(slot1)
		ViewMgr.instance:openView(ViewName.RoomManufactureAddPopView, {
			inRight = slot3,
			highLightManufactureItem = slot6
		})
		slot0:dispatchEvent(ManufactureEvent.ManufactureReadNewFormula)
	end
end

function slot0.refreshSelectedSlotId(slot0, slot1, slot2)
	if not slot2 and not ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView) then
		slot0:clearSelectedSlotItem()

		return
	end

	ManufactureModel.instance:setSelectedSlot(slot1, slot0:getNextEmptySlot(slot1))
	slot0:dispatchEvent(ManufactureEvent.ChangeSelectedSlotItem)
end

function slot0.clearSelectedSlotItem(slot0)
	ViewMgr.instance:closeView(ViewName.RoomManufactureAddPopView)
	ManufactureModel.instance:setSelectedSlot()
	slot0:dispatchEvent(ManufactureEvent.ChangeSelectedSlotItem)
end

function slot0.setManufactureFormulaItemList(slot0, slot1)
	if RoomTradeModel.instance:isGetOrderInfo() then
		ManufactureFormulaListModel.instance:setManufactureFormulaItemList(slot1)
	else
		RoomRpc.instance:sendGetOrderInfoRequest(function ()
			ManufactureFormulaListModel.instance:setManufactureFormulaItemList(uv0)
		end, slot0)
	end
end

function slot0.clickFormulaItem(slot0, slot1)
	slot2, slot3 = ManufactureModel.instance:getSelectedSlot()

	if not slot2 or not slot3 then
		GameFacade.showToast(ToastEnum.RoomNotSelectedSlot)

		return
	end

	if not RoomMapBuildingModel.instance:getBuildingMOById(slot2) or not slot4:getSlotState(slot3) or slot5 ~= RoomManufactureEnum.SlotState.None then
		logError(string.format("ManufactureController:clickFormulaItem error, slot not empty, buildingUid:%s slotId:%s slotState:%s", slot2, slot3, slot5))

		return
	end

	slot0:setManufactureItems(slot2, {
		{
			priority = -1,
			slotId = slot3,
			operation = RoomManufactureEnum.SlotOperation.Add,
			productionId = slot1
		}
	})
end

function slot0.clickRemoveSlotManufactureItem(slot0, slot1, slot2)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) or not slot3:getSlotManufactureItemId(slot2) or slot4 == 0 then
		return
	end

	slot5 = {
		priority = -1,
		slotId = slot2,
		operation = RoomManufactureEnum.SlotOperation.Cancel,
		productionId = slot4
	}

	if (slot3 and slot3:getSlotState(slot2, true)) == RoomManufactureEnum.SlotState.Stop or slot6 == RoomManufactureEnum.SlotState.Running then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomRemoveHasProgressManufactureItem, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:setManufactureItems(uv1, {
				uv2
			})
		end)
	else
		slot0:setManufactureItems(slot1, {
			slot5
		})
	end
end

function slot0.moveManufactureItem(slot0, slot1, slot2, slot3)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) or not slot4:getSlotManufactureItemId(slot2) or slot5 == 0 then
		return
	end

	slot6 = slot4 and slot4:getSlotState(slot2, true)

	if slot6 == RoomManufactureEnum.SlotState.Running or slot6 == RoomManufactureEnum.SlotState.Stop or slot6 == RoomManufactureEnum.SlotState.Wait then
		slot11 = slot4:getSlotPriority(slot2) == RoomManufactureEnum.FirstSlotPriority

		if slot11 and slot3 or not slot11 and not slot3 then
			slot0:setManufactureItems(slot1, {
				{
					productionId = 0,
					priority = -1,
					slotId = slot2,
					operation = slot3 and RoomManufactureEnum.SlotOperation.MoveBottom or RoomManufactureEnum.SlotOperation.MoveTop
				}
			})
		end
	end
end

function slot0.getFormatTime(slot0, slot1, slot2)
	slot3 = ""
	slot6 = slot2 and TimeUtil.DateEnFormat.Minute or luaLang("time_minute2")
	slot7, slot8, slot9, slot10 = TimeUtil.secondsToDDHHMMSS(slot1)

	if slot7 > 0 then
		slot3 = string.format("%s%s%s%s", slot7, slot2 and TimeUtil.DateEnFormat.Day or luaLang("time_day"), slot8, slot2 and TimeUtil.DateEnFormat.Hour or luaLang("time_hour2"))
	elseif slot8 > 0 then
		if slot9 > 0 then
			slot3 = string.format("%s%s%s%s", slot8, slot5, slot9, slot6)
		else
			slot3 = string.format("%s%s", slot8, slot5)
		end
	else
		if slot9 <= 0 then
			slot9 = "<1"
		end

		slot3 = string.format("%s%s", slot9, slot6)
	end

	return slot3
end

function slot0.getNextEmptySlot(slot0, slot1)
	slot2 = nil

	if ManufactureModel.instance:getManufactureMOById(slot1) then
		slot2 = slot3:getNextEmptySlot()
	end

	return slot2
end

function slot0.checkPlaceProduceBuilding(slot0, slot1)
	slot2 = false

	if RoomMapBuildingModel.instance:getBuildingListByType(ManufactureConfig.instance:getManufactureItemBelongBuildingType(slot1)) and #slot4 > 0 then
		for slot8, slot9 in ipairs(slot4) do
			if ManufactureConfig.instance:isManufactureItemBelongBuilding(slot9.buildingId, slot1) then
				slot2 = true

				break
			end
		end
	end

	return slot2
end

function slot0.checkProduceBuildingLevel(slot0, slot1)
	slot2 = nil
	slot3 = true
	slot4 = 0

	if RoomMapBuildingModel.instance:getBuildingListByType(ManufactureConfig.instance:getManufactureItemBelongBuildingType(slot1)) and #slot6 > 0 then
		for slot10, slot11 in ipairs(slot6) do
			if ManufactureConfig.instance:isManufactureItemBelongBuilding(slot11.buildingId, slot1) then
				slot2 = slot11.id

				if ManufactureConfig.instance:getManufactureItemNeedLevel(slot12, slot1) <= slot11:getLevel() then
					slot3 = false

					break
				end
			end
		end
	end

	return slot3, slot2, slot4
end

function slot0.oneKeySelectCustomManufactureItem(slot0, slot1, slot2, slot3)
	slot4, slot5 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if not slot3 and slot4 == slot1 and slot2 == slot5 then
		return
	end

	OneKeyAddPopListModel.instance:setSelectedManufactureItem(slot1, slot2)
	slot0:dispatchEvent(ManufactureEvent.OneKeySelectCustomManufactureItem)
end

function slot0.clickCritterSlotItem(slot0, slot1, slot2)
	slot3 = false

	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) and slot4:getCanPlaceCritterCount() >= slot2 + 1 then
		slot3 = true
	end

	if not slot3 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.RoomCritterListView) and ManufactureModel.instance:getSelectedCritterSlot() == slot1 then
		slot0:clearSelectCritterSlotItem()
	else
		slot0:clearSelectedSlotItem()
		slot0:closeWrongTipView()
		slot0:refreshSelectedCritterSlotId(slot1, true)
		ViewMgr.instance:openView(ViewName.RoomCritterListView, {
			buildingUid = slot1
		})
	end
end

function slot0.refreshSelectedCritterSlotId(slot0, slot1, slot2)
	if not slot2 and not ViewMgr.instance:isOpen(ViewName.RoomCritterListView) then
		slot0:clearSelectCritterSlotItem()

		return
	end

	ManufactureModel.instance:setSelectedCritterSlot(slot1, slot0:getNextEmptyCritterSlot(slot1))
	slot0:dispatchEvent(ManufactureEvent.ChangeSelectedCritterSlotItem)
end

function slot0.getNextEmptyCritterSlot(slot0, slot1)
	slot2 = nil

	if ManufactureModel.instance:getManufactureMOById(slot1) then
		slot2 = slot3:getNextEmptyCritterSlot()
	end

	return slot2
end

function slot0.clearSelectCritterSlotItem(slot0)
	ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	ManufactureModel.instance:setSelectedCritterSlot()
	slot0:dispatchEvent(ManufactureEvent.ChangeSelectedCritterSlotItem)
end

function slot0.clickCritterItem(slot0, slot1)
	slot2, slot3 = ManufactureModel.instance:getSelectedCritterSlot()

	if not slot2 then
		logError(string.format("ManufactureController:clickCritterItem error, not select building"))

		return
	end

	if ManufactureModel.instance:getCritterWorkingBuilding(slot1) == slot2 then
		slot0:allocateCritter(slot4, CritterEnum.InvalidCritterUid, RoomMapBuildingModel.instance:getBuildingMOById(slot4) and slot6:getCritterWorkSlot(slot1))
	else
		slot6 = false
		slot7 = false

		if not RoomMapBuildingModel.instance:getBuildingMOById(slot2) then
			logError(string.format("ManufactureController:clickCritterItem error, can not find buildingUId:%s", slot2))

			return
		end

		if slot8:getCanPlaceCritterCount() == 1 then
			slot3 = 0
			slot7 = true
		end

		if not slot3 then
			GameFacade.showToast(ToastEnum.RoomNotSelectedCritterSlot)

			return
		end

		if slot9 >= slot3 + 1 then
			slot6 = true
		end

		if not slot6 then
			logError(string.format("ManufactureController:clickCritterItem error, critter slot not unlock, buildingUid:%s critterSlotId:%s", slot2, slot3))

			return
		end

		if slot8:getWorkingCritter(slot3) and not slot7 then
			logError(string.format("ManufactureController:clickCritterItem error, slot has critter, buildingUid:%s critterSlotId:%s", slot2, slot3))

			return
		end

		slot11 = 0

		if CritterModel.instance:getCritterMOByUid(slot1) then
			slot11 = slot12:getMoodValue()
		end

		if slot11 <= 0 then
			GameFacade.showToast(ToastEnum.RoomCritterNoMoodWork)

			return
		end

		if slot10 and slot7 then
			slot0:allocateCritter(slot2, CritterEnum.InvalidCritterUid, slot3)
		end

		slot0:allocateCritter(slot2, slot1, slot3)
	end
end

function slot0.clickTransportCritterSlotItem(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterListView) and ManufactureModel.instance:getSelectedTransportPath() == slot1 then
		slot0:clearSelectTransportPath()
	else
		ManufactureModel.instance:setSelectedTransportPath(slot1)
		ViewMgr.instance:openView(ViewName.RoomCritterListView, {
			pathId = slot1
		})
		slot0:dispatchEvent(ManufactureEvent.ChangeSelectedTransportPath)
	end
end

function slot0.clearSelectTransportPath(slot0)
	ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	ManufactureModel.instance:setSelectedTransportPath()
	slot0:dispatchEvent(ManufactureEvent.ChangeSelectedTransportPath)
end

function slot0.clickTransportCritterItem(slot0, slot1)
	if not ManufactureModel.instance:getSelectedTransportPath() then
		logError(string.format("ManufactureController:clickTransportCritterItem error, not select transport path"))

		return
	end

	slot3 = nil

	if (RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot1) and slot4.id) == slot2 then
		slot3 = CritterEnum.InvalidCritterUid
	else
		slot8 = RoomMapTransportPathModel.instance:getTransportPathMO(slot2) and slot7.critterUid

		if not slot7 or slot8 and slot8 ~= CritterEnum.InvalidCritterUid and slot8 ~= tonumber(CritterEnum.InvalidCritterUid) then
			GameFacade.showToast(ToastEnum.RoomNotSelectedCritterSlot)

			return
		end

		slot9 = 0

		if CritterModel.instance:getCritterMOByUid(slot1) then
			slot9 = slot10:getMoodValue()
		end

		if slot9 <= 0 then
			GameFacade.showToast(ToastEnum.RoomCritterNoMoodWork)

			return
		end

		slot3 = slot1
	end

	if slot2 and slot3 then
		RoomRpc.instance:sendAllotCritterRequestt(slot2, slot3)
	end
end

function slot0.checkTradeLevelCondition(slot0, slot1)
	slot2 = false
	slot3, slot4, slot5 = nil

	if ManufactureConfig.instance:getBuildingUpgradeGroup(RoomMapBuildingModel.instance:getBuildingMOById(slot1) and slot6.buildingId) ~= 0 then
		if ManufactureConfig.instance:getNeedTradeLevel(slot7, slot6.level + 1) then
			slot2 = slot5 <= ManufactureModel.instance:getTradeLevel()
		end
	end

	if not slot2 then
		slot3 = ToastEnum.RoomUpgradeFailByTradeLevel
		slot9 = ManufactureConfig.instance:getTradeLevelCfg(slot5)
		slot4 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_manufacutre_building_level_up_need_trade_level"), slot9.dimension, slot9.job)
	end

	return slot2, slot3, slot4
end

function slot0.oneKeyManufactureItem(slot0, slot1)
	if not slot0:checkCanFill(slot1) then
		return
	end

	slot3, slot4, slot5, slot6 = nil

	if slot1 == RoomManufactureEnum.OneKeyType.Customize then
		OneKeyAddPopListModel.instance:recordSelectManufactureItem()

		slot7, slot8 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

		if ManufactureConfig.instance:getManufactureItemBelongBuildingType(slot7) ~= RoomBuildingEnum.BuildingType.Collect then
			slot4 = ManufactureConfig.instance:getManufactureItemBelongBuildingList(slot7) and slot9[1]
		end

		slot5 = ManufactureConfig.instance:getItemId(slot7)
		slot9, slot10 = ManufactureConfig.instance:getManufactureItemUnitCountRange(slot7)
		slot6 = slot10 * slot8
	end

	ManufactureModel.instance:setRecordOneKeyType(slot1)
	RoomStatController.instance:oneKeyDispatch(false, slot1)
	RoomRpc.instance:sendBatchAddProctionsRequest(slot1, slot3, slot4, slot5, slot6)
	ViewMgr.instance:closeView(ViewName.RoomOneKeyView)
end

function slot0.checkCanFill(slot0, slot1)
	slot2 = true

	if slot1 == RoomManufactureEnum.OneKeyType.TracedOrder then
		slot3 = false

		for slot8, slot9 in ipairs(RoomTradeModel.instance:getDailyOrders()) do
			if slot9.isTraced then
				slot3 = true

				break
			end
		end

		if not slot3 then
			GameFacade.showToast(ToastEnum.RoomTraceOrderIsEnough)

			slot2 = false
		end
	elseif slot1 == RoomManufactureEnum.OneKeyType.Customize then
		if OneKeyAddPopListModel.instance:getSelectedManufactureItem() then
			slot4, slot5 = ManufactureModel.instance:getMaxCanProductCount(slot3)

			if slot5 then
				GameFacade.showToast(ToastEnum.RoomNoEmptyManufactureSlot)

				slot2 = false
			end
		else
			GameFacade.showToast(ToastEnum.RoomNotSelectedManufactureItem)

			slot2 = false
		end
	end

	return slot2
end

function slot0.oneKeyCritter(slot0, slot1)
	slot2 = slot1 and CritterEnum.OneKeyType.Transport or CritterEnum.OneKeyType.Manufacture

	RoomStatController.instance:oneKeyDispatch(true, slot2)
	RoomRpc.instance:sendBatchDispatchCrittersRequest(slot2)
end

function slot0.openRouseCritterView(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.infos) do
		slot8 = {
			buildingUid = slot7.buildingUid,
			roadId = slot7.roadId,
			critterUids = {}
		}

		for slot12, slot13 in ipairs(slot7.critterUids) do
			table.insert(slot8.critterUids, slot13)
		end

		table.insert(slot2, slot8)
	end

	if #slot2 <= 0 then
		GameFacade.showToast(ToastEnum.NoCritterCanWork)

		return
	end

	ViewMgr.instance:openView(ViewName.RoomCritterOneKeyView, {
		type = slot1.type,
		infoList = slot2
	})
end

function slot0.sendRouseCritter(slot0, slot1, slot2)
	RoomRpc.instance:sendRouseCrittersRequest(slot1, slot2)
end

function slot0.removeRestingCritterList(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = false

	for slot6, slot7 in ipairs(slot1) do
		if ManufactureModel.instance:getCritterBuildingMOById(ManufactureModel.instance:getCritterRestingBuilding(slot7)) then
			slot9:removeRestingCritter(slot7)

			slot2 = true
		end
	end

	if slot2 then
		RoomCritterModel.instance:initStayBuildingCritters()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
	end
end

function slot0.removeRestingCritter(slot0, slot1)
	slot2 = false

	if ManufactureModel.instance:getCritterBuildingMOById(ManufactureModel.instance:getCritterRestingBuilding(slot1)) then
		slot4:removeRestingCritter(slot1)

		slot2 = true
	end

	if slot2 then
		RoomCritterModel.instance:initStayBuildingCritters()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
	end
end

function slot0.resetCameraOnCloseView(slot0)
	slot2, slot3 = ManufactureModel.instance:getCameraRecord()

	if RoomCameraController.instance:getRoomScene() and slot2 and slot3 then
		slot1.camera:switchCameraState(slot2, slot3)
	end

	ManufactureModel.instance:setCameraRecord()
end

function slot0.getPlayAddEffDict(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if ManufactureModel.instance:getManufactureMOById(slot7.buildingUid) then
			for slot13, slot14 in ipairs(slot7.slotInfos) do
				if (not slot9:getSlotMO(slot14.slotId) or not slot16:getSlotManufactureItemId() or slot17 == 0) and slot14.productionId and slot14.productionId ~= 0 then
					slot2[slot8] = slot2[slot8] or {}
					slot2[slot8][slot15] = true
				end
			end
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
