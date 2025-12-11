module("modules.logic.roomfishing.view.RoomFishingStoreItem", package.seeall)

local var_0_0 = class("RoomFishingStoreItem", NormalStoreGoodsItem)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._gocurrency = gohelper.findChild(arg_1_0.viewGO, "go_currency")
	arg_1_0._imagecurrency = gohelper.findChildImage(arg_1_0.viewGO, "go_currency/icon")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "go_currency/txt_quantity")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
end

function var_0_0._onCurrencyChange(arg_4_0)
	arg_4_0:refreshCurrency()
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	var_0_0.super.onUpdateMO(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goNormalBg, false)
	arg_5_0:refreshCurrency()
end

function var_0_0.refreshRare(arg_6_0)
	UISpriteSetMgr.instance:setV2a5MainActivitySprite(arg_6_0._rare, "v2a5_store_quality_" .. arg_6_0.itemConfig.rare, true)
	gohelper.setActive(arg_6_0._rare.gameObject, true)
end

function var_0_0.refreshCurrency(arg_7_0)
	local var_7_0 = arg_7_0._mo
	local var_7_1 = StoreConfig.instance:getGoodsConfig(var_7_0.goodsId)
	local var_7_2 = var_7_1 and var_7_1.cost

	if string.nilorempty(var_7_2) then
		gohelper.setActive(arg_7_0._gocurrency, false)
	else
		local var_7_3 = string.split(var_7_2, "|")
		local var_7_4 = var_7_3[var_7_0.buyCount + 1] or var_7_3[#var_7_3]
		local var_7_5 = string.splitToNumber(var_7_4, "#")
		local var_7_6 = var_7_5[1]
		local var_7_7 = var_7_5[2]
		local var_7_8 = var_7_5[3]
		local var_7_9 = ItemModel.instance:getItemQuantity(var_7_6, var_7_7)

		arg_7_0._txtcurrency.text = GameUtil.numberDisplay(var_7_9)

		local var_7_10 = "#FFFFFF"
		local var_7_11 = "#0B0C0D"

		if var_7_8 and var_7_9 < var_7_8 then
			var_7_10 = "#BF2E11"
			var_7_11 = var_7_10
		end

		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtcurrency, var_7_10)
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtmaterialNum, var_7_11)

		local var_7_12 = ItemModel.instance:getItemConfigAndIcon(var_7_6, var_7_7)
		local var_7_13 = string.format("%s_1", var_7_12.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_7_0._imagecurrency, var_7_13)
		gohelper.setActive(arg_7_0._gocurrency, true)
	end
end

return var_0_0
