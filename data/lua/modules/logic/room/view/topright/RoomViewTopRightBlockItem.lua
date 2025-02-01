module("modules.logic.room.view.topright.RoomViewTopRightBlockItem", package.seeall)

slot0 = class("RoomViewTopRightBlockItem", RoomViewTopRightBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0._customOnInit(slot0)
	slot0._resourceItem.imageicon = gohelper.findChildImage(slot0._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(slot0._resourceItem.imageicon, "icon_zongkuai_light")
	recthelper.setSize(slot0._resourceItem.imageicon.transform, 68, 52)
	slot0:_setShow(true)
end

function slot0._imageLoaded(slot0)
	slot0._resourceItem.imageicon:SetNativeSize()
end

function slot0._onClick(slot0)
	if RoomController.instance:isVisitMode() then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.Block
	})
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientTryBackBlock, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBackBlock, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBackBlock, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateInventoryCount, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmSelectBlockPackage, slot0._refreshUI, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientPlaceBlock, slot0._refreshAddNumUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBlock, slot0._refreshAddNumUI, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._getPlaceBlockNum(slot0)
	if RoomController.instance:isEditMode() and RoomMapBlockModel.instance:getTempBlockMO() then
		return 1
	end

	return 0
end

function slot0._refreshAddNumUI(slot0)
	if slot0:_getPlaceBlockNum() > 0 then
		slot0._resourceItem.txtaddNum.text = "+" .. slot1
	end

	gohelper.setActive(slot0._resourceItem.txtaddNum, slot1 > 0)
end

function slot0._refreshUI(slot0)
	if RoomController.instance:isVisitMode() then
		slot0._resourceItem.txtquantity.text = RoomMapBlockModel.instance:getConfirmBlockCount()
	else
		slot0._resourceItem.txtquantity.text = string.format("%s/%s", slot1, RoomMapBlockModel.instance:getMaxBlockCount())
	end

	slot0:_refreshAddNumUI()
end

function slot0._customOnDestory(slot0)
end

return slot0
