module("modules.logic.room.view.transport.RoomTransportSiteItem", package.seeall)

slot0 = class("RoomTransportSiteItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnswithItem:AddClickListener(slot0._btnswithItemOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnswithItem:RemoveClickListener()
end

function slot0._btnswithItemOnClick(slot0)
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:dispatchEvent(RoomEvent.TransportSiteSelect, slot0:getDataMO())
	end
end

function slot0._editableInitView(slot0)
	slot0._btnswithItem = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_swithItem")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "btn_swithItem/go_select")
	slot0._imageselecticon = gohelper.findChildImage(slot0.viewGO, "btn_swithItem/go_select/image_selecticon")
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "btn_swithItem/go_unselect")
	slot0._imageunselecticon = gohelper.findChildImage(slot0.viewGO, "btn_swithItem/go_unselect/image_unselecticon")
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.getDataMO(slot0)
	return slot0._dataMO
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._dataMO = slot1

	slot0:refreshUI()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
	gohelper.setActive(slot0._gounselect, not slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	slot1 = slot0._dataMO and RoomMapTransportPathModel.instance:getTransportPathMO(slot0._dataMO.pathId)
	slot2 = false

	if slot1 and RoomTransportHelper.getVehicleCfgByBuildingId(slot1.buildingId, slot1.buildingSkinId) then
		if slot3.id ~= slot0._lastVehicleId then
			UISpriteSetMgr.instance:setRoomSprite(slot0._imageselecticon, slot3.buildIcon)
			UISpriteSetMgr.instance:setRoomSprite(slot0._imageunselecticon, slot3.buildIcon)
		end

		slot2 = true
	end

	if slot0._lastIsActive ~= slot2 then
		gohelper.setActive(slot0._imageselecticon, slot2)
		gohelper.setActive(slot0._imageunselecticon, slot2)
	end
end

return slot0
