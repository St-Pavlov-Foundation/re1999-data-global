module("modules.logic.room.view.trade.RoomWholesaleItem", package.seeall)

local var_0_0 = class("RoomWholesaleItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "stuff/#go_icon")
	arg_1_0._txtpricechange = gohelper.findChildText(arg_1_0.viewGO, "stuff/change/#txt_pricechange")
	arg_1_0._txtprice = gohelper.findChildText(arg_1_0.viewGO, "stuff/#txt_price")
	arg_1_0._simagerewardicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "stuff/#txt_price/#simage_rewardicon")
	arg_1_0._txtinventory = gohelper.findChildText(arg_1_0.viewGO, "order/#txt_inventory ")
	arg_1_0._txtinventorycount = gohelper.findChildText(arg_1_0.viewGO, "order/#txt_inventorycount")
	arg_1_0._txtsold = gohelper.findChildText(arg_1_0.viewGO, "order/#txt_sold")
	arg_1_0._txtsoldcount = gohelper.findChildText(arg_1_0.viewGO, "order/#txt_soldcount")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "order/valuebg/#input_value")
	arg_1_0._btnsub = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "order/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "order/#btn_add")
	arg_1_0._txttotalprice = gohelper.findChildText(arg_1_0.viewGO, "price/#txt_price")
	arg_1_0._simagerewardicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "price/#txt_price/#simage_rewardicon")
	arg_1_0._btnunconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_unconfirm")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnunconfirm:AddClickListener(arg_2_0._btnunconfirmOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnunconfirm:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnValueChanged()

	if arg_3_0._btnsublongPrees then
		arg_3_0._btnsublongPrees:RemoveLongPressListener()
	end

	if arg_3_0._btnaddlongPrees then
		arg_3_0._btnaddlongPrees:RemoveLongPressListener()
	end
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1

	arg_4_0:onInitView()
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEvents()
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeEvents()
end

function var_0_0._btnsubOnClick(arg_7_0)
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	arg_7_0._mo:reduceSoldCount()
	arg_7_0:_refreshSoldCount()
end

function var_0_0._btnaddOnClick(arg_8_0)
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	arg_8_0._mo:addSoldCount()
	arg_8_0:_refreshSoldCount()
end

function var_0_0._btnconfirmOnClick(arg_9_0)
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	if arg_9_0._mo:getSoldCount() <= 0 then
		return
	end

	RoomTradeController.instance:finishDailyOrder(RoomTradeEnum.Mode.Wholesale, arg_9_0._mo.orderId, arg_9_0._mo:getSoldCount())
end

function var_0_0._btnunconfirmOnClick(arg_10_0)
	GameFacade.showToast(ToastEnum.RoomOrderNotCommit)
end

function var_0_0._onSubLongPress(arg_11_0)
	arg_11_0:_btnsubOnClick()
end

function var_0_0._onAddLongPress(arg_12_0)
	arg_12_0:_btnaddOnClick()
end

local var_0_1 = 0.5
local var_0_2 = 0.1

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._btnsublongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_13_0._btnsub.gameObject)

	arg_13_0._btnsublongPrees:SetLongPressTime({
		var_0_1,
		var_0_2
	})
	arg_13_0._btnsublongPrees:AddLongPressListener(arg_13_0._onSubLongPress, arg_13_0)

	arg_13_0._btnaddlongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_13_0._btnadd.gameObject)

	arg_13_0._btnaddlongPrees:SetLongPressTime({
		var_0_1,
		var_0_2
	})
	arg_13_0._btnaddlongPrees:AddLongPressListener(arg_13_0._onAddLongPress, arg_13_0)
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	return
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroy(arg_17_0)
	arg_17_0._simagerewardicon1:UnLoadImage()
	arg_17_0._simagerewardicon2:UnLoadImage()
end

function var_0_0.onUpdateMo(arg_18_0, arg_18_1)
	arg_18_0._mo = arg_18_1
	arg_18_0._txtname.text = arg_18_1:getGoodsName()

	arg_18_0:setIconItem()
	arg_18_0:setUnitPrice()
	arg_18_0:onRefresh()
end

function var_0_0.setIconItem(arg_19_0)
	if not arg_19_0._iconItem then
		arg_19_0._iconItem = IconMgr.instance:getCommonItemIcon(arg_19_0._goicon.gameObject)
	end

	local var_19_0, var_19_1, var_19_2 = arg_19_0._mo:getItem()

	arg_19_0._iconItem:setMOValue(var_19_0, var_19_1, var_19_2, nil, true)
	transformhelper.setLocalScale(arg_19_0._iconItem.go.transform, 0.8, 0.8, 1)
	arg_19_0._iconItem:isShowQuality(false)
	arg_19_0._iconItem:isShowCount(false)
end

function var_0_0.setUnitPrice(arg_20_0)
	local var_20_0, var_20_1, var_20_2 = arg_20_0._mo:getUnitPrice()
	local var_20_3, var_20_4 = ItemModel.instance:getItemConfigAndIcon(var_20_0, var_20_1)

	if var_20_4 ~= arg_20_0._priceIcon then
		arg_20_0._simagerewardicon1:LoadImage(var_20_4)
		arg_20_0._simagerewardicon2:LoadImage(var_20_4)

		arg_20_0._priceIcon = var_20_4
	end

	local var_20_5 = luaLang("room_wholesaleorder_utilprice")

	arg_20_0._txtprice.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_20_5, GameUtil.numberDisplay(var_20_2))

	local var_20_6 = luaLang("room_wholesaleorder_priceratio")

	arg_20_0._txtpricechange.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_20_6, arg_20_0._mo:getPriceRatio())
end

function var_0_0.onRefresh(arg_21_0)
	arg_21_0._txtinventorycount.text = arg_21_0._mo:getMaxCountStr()
	arg_21_0._txtsoldcount.text = arg_21_0._mo:getTodaySoldCountStr()

	arg_21_0:_refreshSoldCount()
	arg_21_0:_refreshBtn()
end

function var_0_0._refreshSoldCount(arg_22_0)
	local var_22_0 = arg_22_0._mo:getSoldCount() or 0
	local var_22_1, var_22_2, var_22_3 = arg_22_0._mo:getUnitPrice()
	local var_22_4 = GameUtil.numberDisplay(var_22_0 * var_22_3)

	arg_22_0._inputvalue:SetText(var_22_0)

	arg_22_0._txttotalprice.text = var_22_4

	arg_22_0:_refreshBtn()
end

function var_0_0._onValueChanged(arg_23_0)
	local var_23_0 = arg_23_0._inputvalue:GetText()

	if string.nilorempty(var_23_0) then
		var_23_0 = 0
	end

	arg_23_0._mo:setSoldCount(tonumber(var_23_0))
	arg_23_0:_refreshSoldCount()
end

function var_0_0._refreshBtn(arg_24_0)
	local var_24_0 = RoomTradeModel.instance:isMaxWeelyOrder()
	local var_24_1 = arg_24_0._mo:getMaxCount() > 0
	local var_24_2 = arg_24_0._mo:getSoldCount() or 0

	gohelper.setActive(arg_24_0._btnunconfirm.gameObject, not var_24_1)
	gohelper.setActive(arg_24_0._btnconfirm.gameObject, var_24_1)
	ZProj.UGUIHelper.SetGrayscale(arg_24_0._btnconfirm.gameObject, var_24_0 or arg_24_0._mo:getSoldCount() <= 0)
	ZProj.UGUIHelper.SetGrayscale(arg_24_0._btnsub.gameObject, var_24_2 <= 0 or var_24_0)
	ZProj.UGUIHelper.SetGrayscale(arg_24_0._btnadd.gameObject, var_24_2 >= arg_24_0._mo:getMaxCount() or var_24_0)
end

var_0_0.ResUrl = "ui/viewres/room/trade/roomwholesaleitem.prefab"

return var_0_0
