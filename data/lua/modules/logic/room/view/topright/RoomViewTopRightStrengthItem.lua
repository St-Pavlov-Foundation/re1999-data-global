module("modules.logic.room.view.topright.RoomViewTopRightStrengthItem", package.seeall)

slot0 = class("RoomViewTopRightStrengthItem", RoomViewTopRightBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0._customOnInit(slot0)
	slot0._strengthId = slot0._param.strengthId
	slot0._strengthShowType = slot0._param.strengthShowType or 0
	slot0._resourceItem.simageicon = gohelper.findChildSingleImage(slot0._resourceItem.go, "icon")

	slot0._resourceItem.simageicon:LoadImage(ItemModel.instance:getItemSmallIcon(slot0._strengthId))
	slot0:_setShow(true)
end

function slot0._onClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, slot0._strengthId, nil, , , , true)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.ConfirmBuilding, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.UnUseBuilding, slot0._refreshUI, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.UpdateBuildingLocalLevels, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.UpdateBuildingLevels, slot0._refreshUI, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._refreshUI(slot0)
	slot1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot0._strengthId)
	slot0._resourceItem.txtquantity.text = string.format("%s/%s", GameUtil.numberDisplay(slot1), GameUtil.numberDisplay(slot1))

	gohelper.setActive(slot0._resourceItem.go, slot0._strengthShowType ~= 1 or slot1 > 0)
end

function slot0._customOnDestory(slot0)
	slot0._resourceItem.simageicon:UnLoadImage()
end

return slot0
