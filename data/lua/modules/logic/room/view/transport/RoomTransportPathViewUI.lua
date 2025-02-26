module("modules.logic.room.view.transport.RoomTransportPathViewUI", package.seeall)

slot0 = class("RoomTransportPathViewUI", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gomapui = gohelper.findChild(slot0.viewGO, "go_mapui")
	slot0._gomapuiitem = gohelper.findChild(slot0.viewGO, "go_mapui/go_mapuiitem")
	slot0._gomapuiTrs = slot0._gomapui.transform
	slot0._buildingTypeIconColor = {
		[RoomBuildingEnum.BuildingType.Collect] = "#91D7F1",
		[RoomBuildingEnum.BuildingType.Process] = "#E2D487",
		[RoomBuildingEnum.BuildingType.Manufacture] = "#99EAC8"
	}
	slot0._uiitemTBList = {
		slot0:_createTB(slot0._gomapuiitem)
	}

	gohelper.setActive(slot0._gomapuiitem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)

	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, RoomEvent.TransportPathSelectLineItem, slot0.startWaitRunDelayTask, slot0)
	end

	slot0:startWaitRunDelayTask()
end

function slot0.onClose(slot0)
	slot0.__hasWaitRunDelayTask_ = false

	TaskDispatcher.cancelTask(slot0.__onWaitRunDelayTask_, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._cameraTransformUpdate(slot0)
	slot0:_refreshItemUIPos()
end

function slot0.startWaitRunDelayTask(slot0)
	if not slot0.__hasWaitRunDelayTask_ then
		slot0.__hasWaitRunDelayTask_ = true

		TaskDispatcher.runDelay(slot0.__onWaitRunDelayTask_, slot0, 0.001)
	end
end

function slot0.__onWaitRunDelayTask_(slot0)
	slot0.__hasWaitRunDelayTask_ = false

	slot0:_refreshItemList()
	slot0:_refreshItemUIPos()
end

function slot0._createTB(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goTrs = slot1.transform
	slot2._imageicon = gohelper.findChildImage(slot1, "image_icon")

	return slot2
end

function slot0._refreshTB(slot0, slot1, slot2, slot3)
	if slot1.buildingId ~= slot2 then
		UISpriteSetMgr.instance:setRoomSprite(slot1._imageicon, ManufactureConfig.instance:getManufactureBuildingIcon(slot2))
		SLFramework.UGUI.GuiHelper.SetColor(slot1._imageicon, RoomConfig.instance:getBuildingConfig(slot2) and slot0._buildingTypeIconColor[slot4.buildingType] or "#FFFFFF")
	end

	if slot1.hexPoint == nil or slot1.hexPoint ~= slot3 then
		slot1.hexPoint = slot3
		slot4, slot5 = HexMath.hexXYToPosXY(slot3.x, slot3.y, RoomBlockEnum.BlockSize)
		slot1.worldPos = Vector3(slot4, 0, slot5)
	end
end

function slot0._getBuildingMOList(slot0)
	if not RoomMapTransportPathModel.instance:getSelectBuildingType() then
		return nil
	end

	slot2, slot3 = RoomTransportHelper.getSiteFromToByType(slot1)

	if slot2 == nil and slot3 == nil then
		return nil
	end

	slot4 = {}

	for slot9, slot10 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot10:checkSameType(slot2) or slot10:checkSameType(slot3) then
			table.insert(slot4, slot10)
		end
	end

	return slot4
end

function slot0._refreshItemList(slot0)
	slot2 = 0

	if slot0:_getBuildingMOList() and #slot1 > 0 then
		slot3 = RoomMapHexPointModel.instance
		slot4 = RoomMapModel.instance

		for slot8, slot9 in ipairs(slot1) do
			slot10 = slot9.hexPoint

			for slot15, slot16 in ipairs(slot4:getBuildingPointList(slot9.buildingId, slot9.rotate)) do
				if not slot0._uiitemTBList[slot2 + 1] then
					slot0._uiitemTBList[slot2] = slot0:_createTB(gohelper.cloneInPlace(slot0._gomapuiitem))
				end

				slot0:_refreshTB(slot17, slot9.buildingId, slot3:getHexPoint(slot16.x + slot10.x, slot16.y + slot10.y))
			end
		end
	end

	for slot6 = 1, #slot0._uiitemTBList do
		if slot0._uiitemTBList[slot6].isActive ~= (slot6 <= slot2) then
			slot7.isActive = slot8

			gohelper.setActive(slot7.go, slot8)
		end
	end
end

function slot0._refreshItemUIPos(slot0)
	for slot4 = 1, #slot0._uiitemTBList do
		if slot0._uiitemTBList[slot4].isActive then
			slot0:_setUIPos(slot5.worldPos, slot5.goTrs, slot0._gomapuiTrs, 0.12)
		end
	end
end

function slot0._setUIPos(slot0, slot1, slot2, slot3, slot4)
	slot5 = RoomBendingHelper.worldToBendingSimple(slot1)
	slot9 = recthelper.worldPosToAnchorPos(Vector3(slot5.x, slot5.y + (slot4 or 0.12), slot5.z), slot3)

	recthelper.setAnchor(slot2, slot9.x, slot9.y)
end

return slot0
