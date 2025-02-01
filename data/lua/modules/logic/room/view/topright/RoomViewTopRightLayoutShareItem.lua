module("modules.logic.room.view.topright.RoomViewTopRightLayoutShareItem", package.seeall)

slot0 = class("RoomViewTopRightLayoutShareItem", RoomViewTopRightBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._ismap = slot0._param.ismap
end

function slot0._customOnInit(slot0)
	slot0._resourceItem.simageicon = gohelper.findChildImage(slot0._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(slot0._resourceItem.simageicon, "room_layout_icon_redu")
end

function slot0._onClick(slot0)
	if RoomController.instance:isVisitMode() then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.PlanShare,
		shareCount = slot0:_getQuantity()
	})
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._refreshUI(slot0)
	slot1 = true

	if slot0._ismap and not RoomController.instance:isVisitShareMode() then
		slot1 = false
	end

	if slot1 then
		slot0._resourceItem.txtquantity.text = slot0:_getQuantity()
	end

	slot0:_setShow(slot1)
end

function slot0._getQuantity(slot0)
	if slot0._ismap then
		return RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode()) and slot1.useCount or 0
	end

	return RoomLayoutModel.instance:getUseCount()
end

return slot0
