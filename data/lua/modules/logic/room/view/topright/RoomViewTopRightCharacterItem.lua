module("modules.logic.room.view.topright.RoomViewTopRightCharacterItem", package.seeall)

slot0 = class("RoomViewTopRightCharacterItem", RoomViewTopRightBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0._customOnInit(slot0)
	slot0._resourceItem.simageicon = gohelper.findChildImage(slot0._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(slot0._resourceItem.simageicon, "img_juese")
	slot0:_setShow(true)
end

function slot0._onClick(slot0)
	slot1 = RoomCharacterModel.instance:getMaxCharacterCount()
	slot3 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(RoomMapModel.instance:getAllBuildDegree())

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.Character
	})
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmCharacter, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UnUseCharacter, slot0._refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._refreshUI(slot0)
	slot0._resourceItem.txtquantity.text = string.format("%d/%d", RoomCharacterModel.instance:getConfirmCharacterCount(), RoomCharacterModel.instance:getMaxCharacterCount())
end

function slot0._customOnDestory(slot0)
end

return slot0
