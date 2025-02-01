module("modules.logic.room.controller.RoomJumpController", package.seeall)

slot0 = class("RoomJumpController", BaseController)

function slot0.jumpFormTaskView(slot0, slot1)
	if string.nilorempty(slot1) then
		return
	end

	slot2 = false

	if string.splitToNumber(slot1, "#")[1] == JumpEnum.JumpView.RoomView then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
			return
		end

		if slot0["jumpTo" .. slot3[2]] then
			slot2 = slot4(slot0, slot3)
		end
	end

	if slot2 and ViewMgr.instance:isOpen(ViewName.RoomRecordView) then
		ViewMgr.instance:closeView(ViewName.RoomRecordView, false)
	end
end

function slot0.jumpTo1(slot0, slot1)
	if (slot1[3] or 1) == 1 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.RoomRecordView) then
		RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
			animName = slot2 == 2 and RoomRecordEnum.AnimName.Task2Log or RoomRecordEnum.AnimName.Task2HandBook,
			view = slot2
		})
	else
		ManufactureController.instance:openRoomRecordView(slot2)
	end
end

function slot0.jumpTo2(slot0, slot1)
	slot2 = slot1[3] or 1

	if not ManufactureModel.instance:getCritterBuildingListInOrder() or #slot3 <= 0 then
		slot0:showRoomNotBuildingMessageBox()

		return
	end

	if slot2 == 3 then
		if not GuideModel.instance:isGuideFinish(RoomTradeEnum.GuideUnlock.Summon) then
			GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

			return
		end
	elseif slot2 == 4 and ManufactureModel.instance:getTradeLevel() < RoomTradeTaskModel.instance:getOpenCritterIncubateLevel() then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	return ManufactureController.instance:openCritterBuildingView(nil, slot2)
end

function slot0.jumpTo3(slot0, slot1)
	return ManufactureController.instance:openOverView()
end

function slot0.jumpTo4(slot0, slot1)
	return ManufactureController.instance:openRoomTradeView(nil, slot1[3] or 1)
end

function slot0.jumpTo5(slot0, slot1)
	return ManufactureController.instance:openRoomBackpackView()
end

function slot0.jumpTo6(slot0, slot1)
	return slot0:jumpToPlaceBuilding()
end

function slot0.jumpTo7(slot0, slot1)
	return slot0:jumpToManufactureBuilding(slot1[3])
end

function slot0.jumpTo8(slot0, slot1)
	return slot0:jumpToManufactureBuildingLevelUp(slot1[3])
end

function slot0.jumpTo9(slot0, slot1)
	JumpController.instance:jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function slot0.jumpTo10(slot0, slot1)
	if not (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen) <= ManufactureModel.instance:getTradeLevel()) then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	if not RoomTransportController.instance:_findLinkPathSiteType(slot1[3]) then
		slot0:showRoomNotTransportRoadMessageBox()

		return false
	end

	RoomTransportController.instance:openTransportSiteView(slot3)

	return true
end

function slot0.jumpTo11(slot0, slot1)
	return slot0:jumpToManufactureBuilding(nil, slot1[3])
end

function slot0.jumpTo12(slot0, slot1)
	return slot0:jumpToManufactureBuildingLevelUp(nil, slot1[3])
end

function slot0.jumpTo13(slot0, slot1)
	if not (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen) <= ManufactureModel.instance:getTradeLevel()) then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	return slot0:jumpToTransportSiteView()
end

function slot0.jumpToPlaceBuilding(slot0)
	ManufactureController.instance:jump2PlaceManufactureBuildingView()

	return true
end

function slot0.jumpToTransportSiteView(slot0)
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		if RoomMapBuildingAreaModel.instance:getCount() < 2 then
			GameFacade.showToast(ToastEnum.RoomTranspathUnableEdite)

			return false
		end

		if ViewMgr.instance:isOpen(ViewName.RoomTradeView) then
			RoomTradeController.instance:dispatchEvent(RoomTradeEvent.PlayCloseTVAnim)
		end

		if ViewMgr.instance:isOpen(ViewName.RoomBackpackView) or ViewMgr.instance:isOpen(ViewName.RoomOverView) then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
		end

		ViewMgr.instance:closeView(ViewName.RoomManufactureMaterialTipView)
		RoomTransportPathModel.instance:setIsJumpTransportSite(true)
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
	end

	return true
end

function slot0.jumpToManufactureBuilding(slot0, slot1, slot2)
	if slot2 then
		if RoomMapBuildingModel.instance:getBuildingMoByBuildingId(slot2) then
			ManufactureController.instance:openManufactureBuildingViewByBuilding(slot3)
		else
			slot0:showRoomNotBuildingMessageBox()

			return false
		end
	else
		slot3, slot4 = slot0:isHasBuilding(slot1)

		if not slot3 then
			slot0:showRoomNotBuildingMessageBox()

			return false
		end

		ManufactureController.instance:openManufactureBuildingViewByType(slot4)
	end

	return true
end

function slot0.jumpToManufactureBuildingLevelUp(slot0, slot1, slot2)
	if slot2 then
		if RoomMapBuildingModel.instance:getBuildingMoByBuildingId(slot2) then
			ManufactureController.instance:jumpToManufactureBuildingLevelUpView(slot3.buildingUid)
		else
			slot0:showRoomNotBuildingMessageBox()

			return false
		end
	else
		slot3, slot4 = slot0:isHasBuilding(slot1)

		if not slot3 then
			slot0:showRoomNotBuildingMessageBox()

			return false
		end

		if RoomMapBuildingModel.instance:getBuildingListByType(slot4) and #slot5 > 0 then
			ManufactureController.instance:jumpToManufactureBuildingLevelUpView(slot5[1].buildingUid)
		end
	end

	return true
end

function slot0.isHasBuilding(slot0, slot1)
	if slot1 and slot1 > 0 then
		return RoomMapBuildingModel.instance:getBuildingListByType(slot1) and #slot2 > 0, slot1
	end

	for slot5, slot6 in pairs(RoomJumpEnum.ManufactureBuildingType) do
		if RoomMapBuildingModel.instance:getBuildingListByType(slot6) and #slot7 > 0 then
			return true, slot6
		end
	end
end

function slot0.showRoomNotBuildingMessageBox(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomNotBuilding, MsgBoxEnum.BoxType.Yes_No, slot0.jumpToPlaceBuilding)
end

function slot0.showRoomNotTransportRoadMessageBox(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomNotTransportRoad, MsgBoxEnum.BoxType.Yes_No, slot0.jumpToTransportSiteView)
end

slot0.instance = slot0.New()

return slot0
