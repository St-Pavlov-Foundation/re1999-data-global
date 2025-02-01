module("modules.logic.room.view.transport.RoomTransportBuildingItem", package.seeall)

slot0 = class("RoomTransportBuildingItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#simage_icon")
	slot0._txtbuildingname = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_buildingname")
	slot0._txtbuildingdec = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_buildingdec")
	slot0._gobeplaced = gohelper.findChild(slot0.viewGO, "#go_content/#go_beplaced")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_content/#go_select")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_click")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_content/#go_reddot")
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
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:dispatchEvent(RoomEvent.TransportBuildingSelect, slot0._mo)
	end

	if not slot0._mo.isNeedToBuy then
		slot0:_hideReddot()
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
	gohelper.setActive(slot0._goselect, slot1)
	gohelper.setActive(slot0._gobeplaced, slot0:_getIsUnse())
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshUI(slot0)
	slot0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. slot0._mo:getIcon()))
	gohelper.setActive(slot0._gobeplaced, slot0:_getIsUnse())

	slot0._txtbuildingname.text = slot0._mo.config.name
	slot0._txtbuildingdec.text = slot0._mo.config.useDesc

	UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, RoomBuildingEnum.RareFrame[slot0._mo.config.rare] or RoomBuildingEnum.RareFrame[1])
	gohelper.setActive(slot0._goreddot, not slot0._mo.use)
	gohelper.setActive(slot0._golock, slot0._mo.isNeedToBuy)

	if not slot0._mo.use then
		RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomBuildingPlace, slot0._mo.buildingId)
	end
end

function slot0._getIsUnse(slot0)
	if slot0._mo and slot0._view and slot0._view.viewContainer then
		return slot0._mo.id == slot0._view.viewContainer.useBuildingUid
	end

	return false
end

function slot0._hideReddot(slot0)
	if slot0._mo.use then
		return
	end

	if not RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBuildingPlace) or not slot1.infos then
		return
	end

	if not slot1.infos[slot0._mo.buildingId] then
		return
	end

	if slot2.value > 0 then
		RoomRpc.instance:sendHideBuildingReddotRequset(slot0._mo.buildingId)
	end
end

slot0.prefabPath = "ui/viewres/room/transport/roomtransportbuildingitem.prefab"

return slot0
