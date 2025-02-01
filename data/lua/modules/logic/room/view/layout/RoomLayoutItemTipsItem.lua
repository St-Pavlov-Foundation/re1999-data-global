module("modules.logic.room.view.layout.RoomLayoutItemTipsItem", package.seeall)

slot0 = class("RoomLayoutItemTipsItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "content")
	slot0._gobuildingicon = gohelper.findChild(slot0.viewGO, "content/#go_buildingicon")
	slot0._godikuaiicon = gohelper.findChild(slot0.viewGO, "content/#go_dikuaiicon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "content/#txt_name")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "content/#txt_num")
	slot0._txtdegree = gohelper.findChildText(slot0.viewGO, "content/#txt_degree")
	slot0._gobtnbuy = gohelper.findChild(slot0.viewGO, "#btn_buy")
	slot0._gocanbuy = gohelper.findChild(slot0.viewGO, "#btn_buy/canBuy")
	slot0._gonotcanbuy = gohelper.findChild(slot0.viewGO, "#btn_buy/notCanBuy")
	slot0._btnbuy = gohelper.getClickWithDefaultAudio(slot0._gobtnbuy)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._onBtnBuyClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
end

function slot0._onBtnBuyClick(slot0)
	if StoreConfig.instance:getRoomProductGoodsId(slot0._layoutItemMO and slot1.materialType, slot1 and slot1.itemId) and StoreModel.instance:getGoodsMO(slot4) and slot0:isCanBuyGoods() then
		StoreController.instance:checkAndOpenStoreView(tonumber(slot6.config.storeId), slot4)
	else
		GameFacade.showToast(ToastEnum.RoomNoneGoods)
	end
end

function slot0._editableInitView(slot0)
	slot0._canvasGroup = gohelper.onceAddComponent(slot0._gocontent, gohelper.Type_CanvasGroup)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._layoutItemMO = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0._refreshUI(slot0)
	if not slot0._layoutItemMO then
		return
	end

	if not slot1:getItemConfig() then
		logError(string.format("itemId:%s itemType:%s not find itemConfig.", slot1.itemId, slot1.itemType))

		return
	end

	gohelper.setActive(slot0._gobuildingicon, slot1:isBuilding())
	gohelper.setActive(slot0._godikuaiicon, slot1:isBlockPackage() or slot1:isSpecialBlock())

	slot3 = slot1.itemNum or 0
	slot4 = 0
	slot5 = slot1:isLack()

	if slot1:isBuilding() then
		slot3 = RoomMapModel.instance:getBuildingConfigParam(slot1.itemId) and slot6.pointList and #slot6.pointList or 0
		slot4 = slot2.buildDegree or 0
	elseif slot1:isBlockPackage() then
		slot4 = (slot2.blockBuildDegree or 0) * slot3
	elseif slot1:isSpecialBlock() then
		slot4 = RoomConfig.instance:getBlockPackageConfig(RoomBlockPackageEnum.ID.RoleBirthday) and slot6.blockBuildDegree or 0
	end

	if slot5 then
		slot0._txtname.text = formatLuaLang("room_layoutplan_namemask_lack", slot2.name)
	else
		slot0._txtname.text = slot2.name
	end

	slot0._txtnum.text = slot3
	slot0._txtdegree.text = slot4
	slot0._canvasGroup.alpha = slot5 and 0.3 or 1

	slot0:refreshBtnBuy()
end

function slot0.refreshBtnBuy(slot0)
	slot1 = false
	slot2 = slot0._layoutItemMO

	if slot0._view and slot0._view.viewParam and slot0._view.viewParam.showBuy then
		slot1 = slot2 and slot2:isLack()
	end

	if slot1 then
		slot3 = slot0:isCanBuyGoods()

		gohelper.setActive(slot0._gocanbuy, slot3)
		gohelper.setActive(slot0._gonotcanbuy, not slot3)
	end

	gohelper.setActive(slot0._gobtnbuy, slot1)
end

function slot0.isCanBuyGoods(slot0)
	slot1 = false

	if StoreConfig.instance:getRoomProductGoodsId(slot0._layoutItemMO and slot2.materialType, slot2 and slot2.itemId) and StoreModel.instance:getGoodsMO(slot5) then
		slot7 = false

		if slot6:getOfflineTime() > 0 then
			slot7 = slot8 - ServerTime.now() <= 0
		end

		slot1 = not slot7 and not slot6:isSoldOut() and slot6:checkJumpGoodCanOpen()
	end

	return slot1
end

function slot0.onDestroyView(slot0)
end

return slot0
