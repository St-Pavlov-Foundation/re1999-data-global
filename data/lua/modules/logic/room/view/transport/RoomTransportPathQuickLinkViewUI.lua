module("modules.logic.room.view.transport.RoomTransportPathQuickLinkViewUI", package.seeall)

slot0 = class("RoomTransportPathQuickLinkViewUI", BaseView)

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
	slot0._gomapuiitem = gohelper.findChild(slot0.viewGO, "go_mapui/go_quickuiitem")
	slot0._gomapuiTrs = slot0._gomapui.transform
	slot0._uiitemTBList = {
		slot0:_createTB(slot0._gomapuiitem)
	}

	gohelper.setActive(slot0._gomapuiitem, false)

	slot0._isLinkFinsh = true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._quickLinkMO = RoomTransportQuickLinkMO.New()

	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)

	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, RoomEvent.TransportPathSelectLineItem, slot0._onSelectLineItem, slot0)
	end

	slot0._quickLinkMO:init()
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

function slot0._onSelectLineItem(slot0, slot1)
	if slot1 == nil then
		return
	end

	if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot1.fromType, slot1.toType) and slot2:isLinkFinish() then
		slot0._isLinkFinsh = true
	else
		slot0._isLinkFinsh = false

		slot0._quickLinkMO:findPath(slot1.fromType, slot1.toType, true)
	end

	slot0:startWaitRunDelayTask()
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
	slot2._txtquick = gohelper.findChildText(slot1, "txt_quick")

	return slot2
end

function slot0._refreshTB(slot0, slot1, slot2, slot3)
	if slot1.searchIndex ~= slot2.searchIndex then
		slot1.searchIndex = slot2.searchIndex
		slot1._txtquick.text = slot2.searchIndex
	end

	if slot1.hexPoint == nil or slot1.hexPoint ~= slot3 then
		slot1.hexPoint = slot3
		slot4, slot5 = HexMath.hexXYToPosXY(slot3.x, slot3.y, RoomBlockEnum.BlockSize)
		slot1.worldPos = Vector3(slot4, 0, slot5)
	end
end

function slot0._refreshItemList(slot0)
	slot1 = slot0._quickLinkMO:getNodeList()
	slot2 = 0

	if not slot0._isLinkFinsh and slot1 and #slot1 > 0 then
		slot3 = RoomMapHexPointModel.instance
		slot4 = RoomMapModel.instance

		for slot8, slot9 in ipairs(slot1) do
			if not slot0._uiitemTBList[slot2 + 1] then
				slot0._uiitemTBList[slot2] = slot0:_createTB(gohelper.cloneInPlace(slot0._gomapuiitem))
			end

			slot0:_refreshTB(slot10, slot9, slot9.hexPoint)
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
