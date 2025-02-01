module("modules.logic.store.view.optionalcharge.OptionalChargeItem", package.seeall)

slot0 = class("OptionalChargeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._imageQuality = gohelper.findChildImage(slot1, "#img_Quality")
	slot0._simageItem = gohelper.findChildSingleImage(slot1, "#simage_Item")
	slot0._txtNum = gohelper.findChildText(slot1, "image_NumBG/#txt_Num")
	slot0._txtItemName = gohelper.findChildText(slot1, "#txt_ItemName")
	slot0.goSelected = gohelper.findChild(slot1, "#go_Selected")
	slot0.click = gohelper.findChildClick(slot1, "click")
	slot0.longPress = SLFramework.UGUI.UILongPressListener.GetWithPath(slot1, "click")

	slot0.longPress:SetLongPressTime({
		0.5,
		99999
	})
	slot0:refreshSelect()
end

function slot0.onStart(slot0)
	slot0.click:AddClickListener(slot0._onClickItem, slot0)
	slot0.longPress:AddLongPressListener(slot0._onClickInfo, slot0)
end

function slot0.onDestroy(slot0)
	slot0.click:RemoveClickListener()
	slot0.longPress:RemoveLongPressListener()

	if slot0._simageItem then
		slot0._simageItem:UnLoadImage()
	end
end

function slot0.setValue(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.itemStr = slot1
	slot0.itemArr = string.splitToNumber(slot1, "#")
	slot0.clickCallback = slot2
	slot0.view = slot3
	slot0.areaIndex = slot4
	slot0.index = slot5
	slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot0.itemArr[1], slot0.itemArr[2])

	UISpriteSetMgr.instance:setOptionalGiftSprite(slot0._imageQuality, "bg_pinjidi_" .. slot6.rare)
	slot0._simageItem:LoadImage(slot7)

	slot0._txtNum.text = GameUtil.numberDisplay(slot0.itemArr[3])
	slot0._txtItemName.text = slot6.name
end

function slot0.refreshSelect(slot0, slot1)
	gohelper.setActive(slot0.goSelected, slot1)
end

function slot0._onClickInfo(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0.itemArr[1], slot0.itemArr[2], false, nil, , , , , , slot0.view.closeThis, slot0.view)
end

function slot0._onClickItem(slot0)
	if slot0.clickCallback then
		slot0.clickCallback(slot0.view, slot0.areaIndex, slot0.index)
	end
end

return slot0
