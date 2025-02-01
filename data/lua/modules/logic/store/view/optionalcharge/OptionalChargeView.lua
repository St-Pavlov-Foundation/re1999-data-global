module("modules.logic.store.view.optionalcharge.OptionalChargeView", package.seeall)

slot0 = class("OptionalChargeView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title/#txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "Title/#txt_TitleEn")
	slot0._txtSelectNum = gohelper.findChildText(slot0.viewGO, "Title/image_TitleTips/#txt_SelectNum")
	slot0._goArea1 = gohelper.findChild(slot0.viewGO, "Gift1/#go_Area1")
	slot0._goArea2 = gohelper.findChild(slot0.viewGO, "Gift2/#go_Area2")
	slot0._goArea3 = gohelper.findChild(slot0.viewGO, "Gift3/#go_Area3")
	slot0._btnBuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Buy")
	slot0._txtPrice = gohelper.findChildText(slot0.viewGO, "#btn_Buy/#txt_Price")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._goOptionalItem = gohelper.findChild(slot0.viewGO, "OptionalItem")
	slot0._goGift1Special = gohelper.findChild(slot0.viewGO, "Gift1Special")
	slot0._goGift1 = gohelper.findChild(slot0.viewGO, "Gift1")
	slot0._simageItem1 = gohelper.findChildSingleImage(slot0.viewGO, "Gift1Special/Item1/simage_Item")
	slot0._simageItem2 = gohelper.findChildSingleImage(slot0.viewGO, "Gift1Special/Item2/simage_Item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnBuy:AddClickListener(slot0._btnBuyOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnBuy:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnBuyOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	if tabletool.len(slot0.selectIndexs) ~= 3 then
		GameFacade.showToast(ToastEnum.OptionalChargeSelectNotEnough)

		return
	end

	PayController.instance:startPay(slot0._mo.id, slot0.selectIndexs)
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(PayController.instance, PayEvent.PayFinished, slot0._payFinished, slot0)

	slot0.selectIndexs = {}

	slot0:initSelectItem()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._mo = slot0.viewParam
	slot0.chargeGoodsCfg = slot0.viewParam.config
	slot0.optionalGroups = StoreConfig.instance:getChargeOptionalGroup(slot0._mo.id)

	slot0:initOptionalItem()

	slot0._txtTitle.text = slot0.chargeGoodsCfg.name
	slot0._txtTitleEn.text = slot0.chargeGoodsCfg.nameEn
	slot0._txtPrice.text = formatLuaLang("price_cost", string.format("<color=#e98457>%s</color>", PayModel.instance:getProductPrice(slot0._mo.id)))

	gohelper.setActive(slot0._goGift1, slot0.optionalGroups[1].rare == 0)
	gohelper.setActive(slot0._goGift1Special, slot0.optionalGroups[1].rare == 1)
	slot0:refreshSelect()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageItem1:UnLoadImage()
	slot0._simageItem2:UnLoadImage()

	for slot4, slot5 in pairs(slot0.optionalItemList[1]) do
		if slot5.longPress then
			slot6:RemoveLongPressListener()
		end
	end
end

function slot0.initOptionalItem(slot0)
	slot0.optionalItemList = {}

	if slot0.optionalGroups[1].rare == 0 then
		gohelper.setActive(slot0._goGift1, true)
		gohelper.setActive(slot0._goGift1Special, false)
		slot0:creatOptionalItem(slot0._goArea1, slot0.optionalGroups[1].items, 1)
	else
		gohelper.setActive(slot0._goGift1, false)
		gohelper.setActive(slot0._goGift1Special, true)
		slot0:creatSpecialItem(slot0.optionalGroups[1].items)
	end

	slot0:creatOptionalItem(slot0._goArea2, slot0.optionalGroups[2].items, 2)
	slot0:creatOptionalItem(slot0._goArea3, slot0.optionalGroups[3].items, 3)
	gohelper.setActive(slot0._goOptionalItem, false)
end

function slot0.initSelectItem(slot0)
	slot0.selectItems = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot6 = "SelectItems/ItemSlot" .. slot4
		slot5.itemGo = gohelper.findChild(slot0.viewGO, slot6 .. "/go_commonitemicon")
		slot5.itemIcon = IconMgr.instance:getCommonItemIcon(slot5.itemGo)

		slot5.itemIcon:isEnableClick(false)
		slot5.itemIcon:setCountFontSize(37.8)

		slot5.goAddEffect = gohelper.findChild(slot0.viewGO, slot6 .. "/add")

		gohelper.setActive(slot5.itemGo, false)
		gohelper.setActive(slot5.goAddEffect, false)

		slot0.selectItems[slot4] = slot5
	end
end

function slot0.refreshSelect(slot0, slot1, slot2)
	slot0._txtSelectNum.text = string.format("<color=#e98457>%d</color>/%d", tabletool.len(slot0.selectIndexs), #slot0.optionalGroups)

	if slot1 then
		slot4 = slot0.selectIndexs[slot1]

		if slot2 then
			gohelper.setActive(slot0.selectItems[slot1].itemGo, true)
		else
			gohelper.setActive(slot5.goAddEffect, false)
		end

		gohelper.setActive(slot5.goAddEffect, true)

		slot6 = slot0.optionalItemList[slot1][slot4].itemArr

		slot5.itemIcon:setMOValue(slot6[1], slot6[2], slot6[3])
	end
end

function slot0.creatSpecialItem(slot0, slot1)
	slot0._simageItem1:LoadImage(ResUrl.getEquipSuit("1000"))
	slot0._simageItem2:LoadImage(ResUrl.getPropItemIcon("481005"))

	slot0.optionalItemList[1] = {}

	for slot6 = 1, 2 do
		slot7 = slot0:getUserDataTb_()
		slot7.itemArr = string.splitToNumber(string.split(slot1, "|")[slot6], "#")
		slot10 = gohelper.findChild(slot0.viewGO, "Gift1Special/Item" .. slot6)
		gohelper.findChildText(slot10, "image_Name/txt_Name").text = ItemConfig.instance:getItemConfig(slot7.itemArr[1], slot7.itemArr[2]).name .. luaLang("multiple") .. slot7.itemArr[3]
		slot7.sFrame = gohelper.findChild(slot10, "go_SelectedFrame")
		slot7.sYes = gohelper.findChild(slot10, "go_SelectedYes")

		slot0:addClickCb(gohelper.findChildClick(slot10, "btn_click"), slot0._clickSpecialItem, slot0, slot6)

		slot7.longPress = SLFramework.UGUI.UILongPressListener.GetWithPath(slot10, "btn_click")

		slot7.longPress:SetLongPressTime({
			0.5,
			99999
		})
		slot7.longPress:AddLongPressListener(slot0._longPressSpecial, slot0, slot6)
		gohelper.setActive(slot7.sFrame, false)
		gohelper.setActive(slot7.sYes, false)

		slot0.optionalItemList[1][slot6] = slot7
	end
end

function slot0._clickSpecialItem(slot0, slot1)
	if slot0.selectIndexs[1] == slot1 then
		return
	end

	slot2 = slot0.selectIndexs[1]
	slot0.selectIndexs[1] = slot1

	for slot6, slot7 in ipairs(slot0.optionalItemList[1]) do
		gohelper.setActive(slot7.sFrame, slot6 == slot1)
		gohelper.setActive(slot7.sYes, slot6 == slot1)
	end

	slot0:refreshSelect(1, slot2 == nil)
	slot0:_track(1, slot2, slot1)
end

function slot0._longPressSpecial(slot0, slot1)
	slot3 = slot0.optionalItemList[1][slot1].itemArr

	MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2], false, nil, , , , , , slot0.closeThis, slot0)
end

function slot0.creatOptionalItem(slot0, slot1, slot2, slot3)
	slot0.optionalItemList[slot3] = {}

	for slot8 = 1, #string.split(slot2, "|") do
		slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._goOptionalItem, slot1), OptionalChargeItem)

		slot10:setValue(slot4[slot8], slot0.clickOptional, slot0, slot3, slot8)

		slot0.optionalItemList[slot3][slot8] = slot10
	end
end

function slot0.clickOptional(slot0, slot1, slot2)
	if slot0.selectIndexs[slot1] == slot2 then
		return
	end

	slot3 = slot0.selectIndexs[slot1]
	slot0.selectIndexs[slot1] = slot2

	for slot7, slot8 in ipairs(slot0.optionalItemList[slot1]) do
		slot8:refreshSelect(slot7 == slot2)
	end

	slot0:refreshSelect(slot1, slot3 == nil)
	slot0:_track(slot1, slot3, slot2)
end

function slot0._payFinished(slot0)
	slot0:closeThis()
end

function slot0._track(slot0, slot1, slot2, slot3)
	StatController.instance:track(StatEnum.EventName.SelectOptionalCharge, {
		[StatEnum.EventProperties.PackName] = slot0.chargeGoodsCfg.name,
		[StatEnum.EventProperties.StuffGearId] = tostring(slot1),
		[StatEnum.EventProperties.BeforeStuffName] = slot2 and slot0:_getItemNameByIndex(slot1, slot2) or "",
		[StatEnum.EventProperties.AfterStuffName] = slot0:_getItemNameByIndex(slot1, slot3),
		[StatEnum.EventProperties.SelectedStuffName] = slot0:_getSelectItemNameList()
	})
end

function slot0._getSelectItemNameList(slot0)
	slot1 = {}

	for slot5 = 1, 3 do
		slot1[#slot1 + 1] = slot0.selectIndexs[slot5] and slot0:_getItemNameByIndex(slot5, slot6) or ""
	end

	return slot1
end

function slot0._getItemNameByIndex(slot0, slot1, slot2)
	slot3 = slot0.optionalItemList[slot1][slot2].itemArr

	return ItemConfig.instance:getItemConfig(slot3[1], slot3[2]).name
end

return slot0
