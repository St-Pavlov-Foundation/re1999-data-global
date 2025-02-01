module("modules.logic.room.view.manufacture.RoomCritterRestViewFoodItem", package.seeall)

slot0 = class("RoomCritterRestViewFoodItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagequality = gohelper.findChildImage(slot0.viewGO, "#simage_quality")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_num/#txt_num")
	slot0._goprefer = gohelper.findChild(slot0.viewGO, "#go_prefer")
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_click")
	slot0._goclickEff = gohelper.findChild(slot0.viewGO, "click_full")

	gohelper.setActive(slot0._goclickEff, false)
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0.onClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.refreshQuantity, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.refreshQuantity, slot0)
end

function slot0.onClick(slot0)
	slot1, slot2 = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1):getRestingCritter(slot2) then
		return
	end

	if ItemModel.instance:getItemCount(slot0._mo.id) <= 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.IsJumpCritterStoreBuyFood, MsgBoxEnum.BoxType.Yes_No, slot0._confirmJumpStore, nil, , slot0, nil, , slot0._name)

		return
	end

	slot8 = 0

	if CritterModel.instance:getCritterMOByUid(slot4) then
		slot8 = slot7:getMoodValue()
	end

	if slot8 ~= 0 and (tonumber(ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)) or 0) <= slot8 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomFeedCritterMaxMood, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:sendFeedRequest(uv1)
		end)
	else
		slot0:sendFeedRequest(slot4)
	end
end

function slot0._confirmJumpStore(slot0)
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.CritterStore)
end

function slot0.sendFeedRequest(slot0, slot1)
	RoomRpc.instance:sendFeedCritterRequest(slot1, {
		quantity = 1,
		type = MaterialEnum.MaterialType.Item,
		id = slot0._mo.id
	}, slot0._afterFeed, slot0)
end

function slot0._afterFeed(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot4 = false
	slot5, slot6 = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if CritterModel.instance:getCritterMOByUid(RoomMapBuildingModel.instance:getBuildingMOById(slot5) and slot7:getRestingCritter(slot6)) then
		slot4 = CritterConfig.instance:isFavoriteFood(slot9:getDefineId(), slot0._mo.id)
	end

	slot0:playClickEff()
	CritterController.instance:dispatchEvent(CritterEvent.CritterFeedFood, {
		[slot3.critterUid] = true
	}, slot4)
end

function slot0.playClickEff(slot0)
	gohelper.setActive(slot0._goclickEff, false)
	gohelper.setActive(slot0._goclickEff, true)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, slot0._mo.id)
	slot0._name = slot3.name

	UISpriteSetMgr.instance:setCritterSprite(slot0._imagequality, RoomManufactureEnum.RareImageMap[slot3.rare])
	slot0._simageicon:LoadImage(slot4)
	slot0:refreshQuantity()
	gohelper.setActive(slot0._goprefer, slot0._mo.isFavorite)
	gohelper.setActive(slot0._goclickEff, false)
end

function slot0.refreshQuantity(slot0)
	slot0._txtnum.text = ItemModel.instance:getItemCount(slot0._mo.id)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
end

return slot0
