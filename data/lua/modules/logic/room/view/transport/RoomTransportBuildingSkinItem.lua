module("modules.logic.room.view.transport.RoomTransportBuildingSkinItem", package.seeall)

slot0 = class("RoomTransportBuildingSkinItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#simage_icon")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_click")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_content/#go_reddot")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_content/#go_selected")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_content/#go_lock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._mo and slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:dispatchEvent(RoomEvent.TransportBuildingSkinSelect, slot0._mo)
	end
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1)
end

function slot0._refreshUI(slot0)
	slot2 = slot0._mo and slot1.config or slot1.buildingCfg

	if slot1 then
		slot0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. slot2.icon))
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, RoomBuildingEnum.RareFrame[slot2.rare] or RoomBuildingEnum.RareFrame[1])
		gohelper.setActive(slot0._golock, slot1.isLock)
	end
end

function slot0.onDestroyView(slot0)
end

slot0.prefabPath = "ui/viewres/room/transport/roomtransportbuildingskinitem.prefab"

return slot0
