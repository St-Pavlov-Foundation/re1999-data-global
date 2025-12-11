module("modules.logic.store.view.optionalcharge.OptionalChargeView", package.seeall)

local var_0_0 = class("OptionalChargeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_TitleEn")
	arg_1_0._txtSelectNum = gohelper.findChildText(arg_1_0.viewGO, "Title/image_TitleTips/#txt_SelectNum")
	arg_1_0._goArea1 = gohelper.findChild(arg_1_0.viewGO, "Gift1/#go_Area1")
	arg_1_0._goArea2 = gohelper.findChild(arg_1_0.viewGO, "Gift2/#go_Area2")
	arg_1_0._goArea3 = gohelper.findChild(arg_1_0.viewGO, "Gift3/#go_Area3")
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Buy")
	arg_1_0._txtPrice = gohelper.findChildText(arg_1_0.viewGO, "#btn_Buy/#txt_Price")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._goOptionalItem = gohelper.findChild(arg_1_0.viewGO, "OptionalItem")
	arg_1_0._goGift1Special = gohelper.findChild(arg_1_0.viewGO, "Gift1Special")
	arg_1_0._goGift1 = gohelper.findChild(arg_1_0.viewGO, "Gift1")
	arg_1_0._simageItem1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Gift1Special/Item1/simage_Item")
	arg_1_0._simageItem2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Gift1Special/Item2/simage_Item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0._btnBuyOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBuy:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnBuyOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	if tabletool.len(arg_4_0.selectIndexs) ~= 3 then
		GameFacade.showToast(ToastEnum.OptionalChargeSelectNotEnough)

		return
	end

	PayController.instance:startPay(arg_4_0._mo.id, arg_4_0.selectIndexs)
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_6_0._payFinished, arg_6_0)

	arg_6_0.selectIndexs = {}

	arg_6_0:initSelectItem()
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._mo = arg_8_0.viewParam
	arg_8_0.chargeGoodsCfg = arg_8_0.viewParam.config
	arg_8_0.optionalGroups = StoreConfig.instance:getChargeOptionalGroup(arg_8_0._mo.id)

	arg_8_0:initOptionalItem()

	arg_8_0._txtTitle.text = arg_8_0.chargeGoodsCfg.name
	arg_8_0._txtTitleEn.text = arg_8_0.chargeGoodsCfg.nameEn

	local var_8_0 = string.format("<color=#e98457>%s</color>", PayModel.instance:getProductPrice(arg_8_0._mo.id))

	arg_8_0._txtPrice.text = formatLuaLang("price_cost", var_8_0)

	gohelper.setActive(arg_8_0._goGift1, arg_8_0.optionalGroups[1].rare == 0)
	gohelper.setActive(arg_8_0._goGift1Special, arg_8_0.optionalGroups[1].rare == 1)
	arg_8_0:refreshSelect()
	StoreController.instance:statOpenChargeGoods(arg_8_0._mo.belongStoreId, arg_8_0.chargeGoodsCfg)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageItem1:UnLoadImage()
	arg_10_0._simageItem2:UnLoadImage()

	for iter_10_0, iter_10_1 in pairs(arg_10_0.optionalItemList[1]) do
		local var_10_0 = iter_10_1.longPress

		if var_10_0 then
			var_10_0:RemoveLongPressListener()
		end
	end
end

function var_0_0.initOptionalItem(arg_11_0)
	arg_11_0.optionalItemList = {}

	if arg_11_0.optionalGroups[1].rare == 0 then
		gohelper.setActive(arg_11_0._goGift1, true)
		gohelper.setActive(arg_11_0._goGift1Special, false)
		arg_11_0:creatOptionalItem(arg_11_0._goArea1, arg_11_0.optionalGroups[1].items, 1)
	else
		gohelper.setActive(arg_11_0._goGift1, false)
		gohelper.setActive(arg_11_0._goGift1Special, true)
		arg_11_0:creatSpecialItem(arg_11_0.optionalGroups[1].items)
	end

	arg_11_0:creatOptionalItem(arg_11_0._goArea2, arg_11_0.optionalGroups[2].items, 2)
	arg_11_0:creatOptionalItem(arg_11_0._goArea3, arg_11_0.optionalGroups[3].items, 3)
	gohelper.setActive(arg_11_0._goOptionalItem, false)
end

function var_0_0.initSelectItem(arg_12_0)
	arg_12_0.selectItems = {}

	for iter_12_0 = 1, 3 do
		local var_12_0 = arg_12_0:getUserDataTb_()
		local var_12_1 = "SelectItems/ItemSlot" .. iter_12_0

		var_12_0.itemGo = gohelper.findChild(arg_12_0.viewGO, var_12_1 .. "/go_commonitemicon")
		var_12_0.itemIcon = IconMgr.instance:getCommonItemIcon(var_12_0.itemGo)

		var_12_0.itemIcon:isEnableClick(false)
		var_12_0.itemIcon:setCountFontSize(37.8)

		var_12_0.goAddEffect = gohelper.findChild(arg_12_0.viewGO, var_12_1 .. "/add")

		gohelper.setActive(var_12_0.itemGo, false)
		gohelper.setActive(var_12_0.goAddEffect, false)

		arg_12_0.selectItems[iter_12_0] = var_12_0
	end
end

function var_0_0.refreshSelect(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = tabletool.len(arg_13_0.selectIndexs)

	arg_13_0._txtSelectNum.text = string.format("<color=#e98457>%d</color>/%d", var_13_0, #arg_13_0.optionalGroups)

	if arg_13_1 then
		local var_13_1 = arg_13_0.selectIndexs[arg_13_1]
		local var_13_2 = arg_13_0.selectItems[arg_13_1]

		if arg_13_2 then
			gohelper.setActive(var_13_2.itemGo, true)
		else
			gohelper.setActive(var_13_2.goAddEffect, false)
		end

		gohelper.setActive(var_13_2.goAddEffect, true)

		local var_13_3 = arg_13_0.optionalItemList[arg_13_1][var_13_1].itemArr

		var_13_2.itemIcon:setMOValue(var_13_3[1], var_13_3[2], var_13_3[3])
	end
end

function var_0_0.creatSpecialItem(arg_14_0, arg_14_1)
	arg_14_0._simageItem1:LoadImage(ResUrl.getEquipSuit("1000"))
	arg_14_0._simageItem2:LoadImage(ResUrl.getPropItemIcon("481005"))

	local var_14_0 = string.split(arg_14_1, "|")

	arg_14_0.optionalItemList[1] = {}

	for iter_14_0 = 1, 2 do
		local var_14_1 = arg_14_0:getUserDataTb_()

		var_14_1.itemArr = string.splitToNumber(var_14_0[iter_14_0], "#")

		local var_14_2 = ItemConfig.instance:getItemConfig(var_14_1.itemArr[1], var_14_1.itemArr[2])
		local var_14_3 = "Gift1Special/Item" .. iter_14_0
		local var_14_4 = gohelper.findChild(arg_14_0.viewGO, var_14_3)

		gohelper.findChildText(var_14_4, "image_Name/txt_Name").text = var_14_2.name .. luaLang("multiple") .. var_14_1.itemArr[3]
		var_14_1.sFrame = gohelper.findChild(var_14_4, "go_SelectedFrame")
		var_14_1.sYes = gohelper.findChild(var_14_4, "go_SelectedYes")

		local var_14_5 = gohelper.findChildClick(var_14_4, "btn_click")

		arg_14_0:addClickCb(var_14_5, arg_14_0._clickSpecialItem, arg_14_0, iter_14_0)

		var_14_1.longPress = SLFramework.UGUI.UILongPressListener.GetWithPath(var_14_4, "btn_click")

		var_14_1.longPress:SetLongPressTime({
			0.5,
			99999
		})
		var_14_1.longPress:AddLongPressListener(arg_14_0._longPressSpecial, arg_14_0, iter_14_0)
		gohelper.setActive(var_14_1.sFrame, false)
		gohelper.setActive(var_14_1.sYes, false)

		arg_14_0.optionalItemList[1][iter_14_0] = var_14_1
	end
end

function var_0_0._clickSpecialItem(arg_15_0, arg_15_1)
	if arg_15_0.selectIndexs[1] == arg_15_1 then
		return
	end

	local var_15_0 = arg_15_0.selectIndexs[1]

	arg_15_0.selectIndexs[1] = arg_15_1

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.optionalItemList[1]) do
		gohelper.setActive(iter_15_1.sFrame, iter_15_0 == arg_15_1)
		gohelper.setActive(iter_15_1.sYes, iter_15_0 == arg_15_1)
	end

	arg_15_0:refreshSelect(1, var_15_0 == nil)
	arg_15_0:_track(1, var_15_0, arg_15_1)
end

function var_0_0._longPressSpecial(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.optionalItemList[1][arg_16_1].itemArr

	MaterialTipController.instance:showMaterialInfo(var_16_0[1], var_16_0[2], false, nil, nil, nil, nil, nil, nil, arg_16_0.closeThis, arg_16_0)
end

function var_0_0.creatOptionalItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = string.split(arg_17_2, "|")

	arg_17_0.optionalItemList[arg_17_3] = {}

	for iter_17_0 = 1, #var_17_0 do
		local var_17_1 = gohelper.clone(arg_17_0._goOptionalItem, arg_17_1)
		local var_17_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_1, OptionalChargeItem)

		var_17_2:setValue(var_17_0[iter_17_0], arg_17_0.clickOptional, arg_17_0, arg_17_3, iter_17_0)

		arg_17_0.optionalItemList[arg_17_3][iter_17_0] = var_17_2
	end
end

function var_0_0.clickOptional(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.selectIndexs[arg_18_1] == arg_18_2 then
		return
	end

	local var_18_0 = arg_18_0.selectIndexs[arg_18_1]

	arg_18_0.selectIndexs[arg_18_1] = arg_18_2

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.optionalItemList[arg_18_1]) do
		iter_18_1:refreshSelect(iter_18_0 == arg_18_2)
	end

	arg_18_0:refreshSelect(arg_18_1, var_18_0 == nil)
	arg_18_0:_track(arg_18_1, var_18_0, arg_18_2)
end

function var_0_0._payFinished(arg_19_0)
	arg_19_0:closeThis()
end

function var_0_0._track(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_2 and arg_20_0:_getItemNameByIndex(arg_20_1, arg_20_2) or ""
	local var_20_1 = arg_20_0:_getItemNameByIndex(arg_20_1, arg_20_3)

	StatController.instance:track(StatEnum.EventName.SelectOptionalCharge, {
		[StatEnum.EventProperties.PackName] = arg_20_0.chargeGoodsCfg.name,
		[StatEnum.EventProperties.StuffGearId] = tostring(arg_20_1),
		[StatEnum.EventProperties.BeforeStuffName] = var_20_0,
		[StatEnum.EventProperties.AfterStuffName] = var_20_1,
		[StatEnum.EventProperties.SelectedStuffName] = arg_20_0:_getSelectItemNameList()
	})
end

function var_0_0._getSelectItemNameList(arg_21_0)
	local var_21_0 = {}

	for iter_21_0 = 1, 3 do
		local var_21_1 = arg_21_0.selectIndexs[iter_21_0]

		var_21_0[#var_21_0 + 1] = var_21_1 and arg_21_0:_getItemNameByIndex(iter_21_0, var_21_1) or ""
	end

	return var_21_0
end

function var_0_0._getItemNameByIndex(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.optionalItemList[arg_22_1][arg_22_2].itemArr

	return ItemConfig.instance:getItemConfig(var_22_0[1], var_22_0[2]).name
end

return var_0_0
