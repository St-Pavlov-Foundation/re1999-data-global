module("modules.logic.room.view.trade.RoomWholesaleItem", package.seeall)

slot0 = class("RoomWholesaleItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "stuff/#go_icon")
	slot0._txtpricechange = gohelper.findChildText(slot0.viewGO, "stuff/change/#txt_pricechange")
	slot0._txtprice = gohelper.findChildText(slot0.viewGO, "stuff/#txt_price")
	slot0._simagerewardicon1 = gohelper.findChildSingleImage(slot0.viewGO, "stuff/#txt_price/#simage_rewardicon")
	slot0._txtinventory = gohelper.findChildText(slot0.viewGO, "order/#txt_inventory ")
	slot0._txtinventorycount = gohelper.findChildText(slot0.viewGO, "order/#txt_inventorycount")
	slot0._txtsold = gohelper.findChildText(slot0.viewGO, "order/#txt_sold")
	slot0._txtsoldcount = gohelper.findChildText(slot0.viewGO, "order/#txt_soldcount")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "order/valuebg/#input_value")
	slot0._btnsub = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "order/#btn_sub")
	slot0._btnadd = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "order/#btn_add")
	slot0._txttotalprice = gohelper.findChildText(slot0.viewGO, "price/#txt_price")
	slot0._simagerewardicon2 = gohelper.findChildSingleImage(slot0.viewGO, "price/#txt_price/#simage_rewardicon")
	slot0._btnunconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_unconfirm")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnunconfirm:AddClickListener(slot0._btnunconfirmOnClick, slot0)
	slot0._inputvalue:AddOnValueChanged(slot0._onValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnunconfirm:RemoveClickListener()
	slot0._inputvalue:RemoveOnValueChanged()

	if slot0._btnsublongPrees then
		slot0._btnsublongPrees:RemoveLongPressListener()
	end

	if slot0._btnaddlongPrees then
		slot0._btnaddlongPrees:RemoveLongPressListener()
	end
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0._btnsubOnClick(slot0)
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	slot0._mo:reduceSoldCount()
	slot0:_refreshSoldCount()
end

function slot0._btnaddOnClick(slot0)
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	slot0._mo:addSoldCount()
	slot0:_refreshSoldCount()
end

function slot0._btnconfirmOnClick(slot0)
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	if slot0._mo:getSoldCount() <= 0 then
		return
	end

	RoomTradeController.instance:finishDailyOrder(RoomTradeEnum.Mode.Wholesale, slot0._mo.orderId, slot0._mo:getSoldCount())
end

function slot0._btnunconfirmOnClick(slot0)
	GameFacade.showToast(ToastEnum.RoomOrderNotCommit)
end

function slot0._onSubLongPress(slot0)
	slot0:_btnsubOnClick()
end

function slot0._onAddLongPress(slot0)
	slot0:_btnaddOnClick()
end

slot1 = 0.5
slot2 = 0.1

function slot0._editableInitView(slot0)
	slot0._btnsublongPrees = SLFramework.UGUI.UILongPressListener.Get(slot0._btnsub.gameObject)

	slot0._btnsublongPrees:SetLongPressTime({
		uv0,
		uv1
	})
	slot0._btnsublongPrees:AddLongPressListener(slot0._onSubLongPress, slot0)

	slot0._btnaddlongPrees = SLFramework.UGUI.UILongPressListener.Get(slot0._btnadd.gameObject)

	slot0._btnaddlongPrees:SetLongPressTime({
		uv0,
		uv1
	})
	slot0._btnaddlongPrees:AddLongPressListener(slot0._onAddLongPress, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroy(slot0)
	slot0._simagerewardicon1:UnLoadImage()
	slot0._simagerewardicon2:UnLoadImage()
end

function slot0.onUpdateMo(slot0, slot1)
	slot0._mo = slot1
	slot0._txtname.text = slot1:getGoodsName()

	slot0:setIconItem()
	slot0:setUnitPrice()
	slot0:onRefresh()
end

function slot0.setIconItem(slot0)
	if not slot0._iconItem then
		slot0._iconItem = IconMgr.instance:getCommonItemIcon(slot0._goicon.gameObject)
	end

	slot1, slot2, slot3 = slot0._mo:getItem()

	slot0._iconItem:setMOValue(slot1, slot2, slot3, nil, true)
	transformhelper.setLocalScale(slot0._iconItem.go.transform, 0.8, 0.8, 1)
	slot0._iconItem:isShowQuality(false)
	slot0._iconItem:isShowCount(false)
end

function slot0.setUnitPrice(slot0)
	slot1, slot2, slot3 = slot0._mo:getUnitPrice()
	slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot1, slot2)

	if slot5 ~= slot0._priceIcon then
		slot0._simagerewardicon1:LoadImage(slot5)
		slot0._simagerewardicon2:LoadImage(slot5)

		slot0._priceIcon = slot5
	end

	slot0._txtprice.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_wholesaleorder_utilprice"), GameUtil.numberDisplay(slot3))
	slot0._txtpricechange.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_wholesaleorder_priceratio"), slot0._mo:getPriceRatio())
end

function slot0.onRefresh(slot0)
	slot0._txtinventorycount.text = slot0._mo:getMaxCountStr()
	slot0._txtsoldcount.text = slot0._mo:getTodaySoldCountStr()

	slot0:_refreshSoldCount()
	slot0:_refreshBtn()
end

function slot0._refreshSoldCount(slot0)
	slot1 = slot0._mo:getSoldCount() or 0
	slot2, slot3, slot4 = slot0._mo:getUnitPrice()

	slot0._inputvalue:SetText(slot1)

	slot0._txttotalprice.text = GameUtil.numberDisplay(slot1 * slot4)

	slot0:_refreshBtn()
end

function slot0._onValueChanged(slot0)
	if string.nilorempty(slot0._inputvalue:GetText()) then
		slot1 = 0
	end

	slot0._mo:setSoldCount(tonumber(slot1))
	slot0:_refreshSoldCount()
end

function slot0._refreshBtn(slot0)
	slot1 = RoomTradeModel.instance:isMaxWeelyOrder()
	slot2 = slot0._mo:getMaxCount() > 0
	slot3 = slot0._mo:getSoldCount() or 0

	gohelper.setActive(slot0._btnunconfirm.gameObject, not slot2)
	gohelper.setActive(slot0._btnconfirm.gameObject, slot2)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnconfirm.gameObject, slot1 or slot0._mo:getSoldCount() <= 0)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnsub.gameObject, slot3 <= 0 or slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnadd.gameObject, slot0._mo:getMaxCount() <= slot3 or slot1)
end

slot0.ResUrl = "ui/viewres/room/trade/roomwholesaleitem.prefab"

return slot0
