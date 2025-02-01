module("modules.logic.gift.view.GiftMultipleChoiceListItem", package.seeall)

slot0 = class("GiftMultipleChoiceListItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._itemPos = gohelper.findChild(slot1, "itemPos")
	slot0._name = gohelper.findChildText(slot1, "name")
	slot0._choose = gohelper.findChild(slot1, "mask")
	slot0._clickGO = gohelper.findChild(slot1, "click")
	slot0._goneed = gohelper.findChild(slot1, "#go_needtag")
	slot0._clickitem = gohelper.getClick(slot0._clickGO)
	slot0._longclickItem = SLFramework.UGUI.UILongPressListener.Get(slot0._clickGO)

	slot0._longclickItem:SetLongPressTime({
		0.5,
		99999
	})

	slot0._rightClick = SLFramework.UGUI.UIRightClickListener.Get(slot0._clickGO)
end

function slot0.addEventListeners(slot0)
	slot0._clickitem:AddClickListener(slot0._onClickItem, slot0)
	slot0._longclickItem:AddLongPressListener(slot0._onLongClickItem, slot0)
	slot0._rightClick:AddClickListener(slot0._onRightClickItem, slot0)
	GiftController.instance:registerCallback(GiftEvent.MultipleChoice, slot0._refreshItem, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._clickitem:RemoveClickListener()
	slot0._longclickItem:RemoveLongPressListener()
	slot0._rightClick:RemoveClickListener()
	GiftController.instance:unregisterCallback(GiftEvent.MultipleChoice, slot0._refreshItem, slot0)
end

function slot0._refreshItem(slot0)
	gohelper.setActive(slot0._choose, slot0._mo.index == GiftModel.instance:getMultipleChoiceIndex())
end

function slot0._onClickItem(slot0)
	gohelper.setActive(slot0._choose, true)
	GiftModel.instance:setMultipleChoiceIndex(slot0._mo.index)
	GiftModel.instance:setMultipleChoiceId(slot0._mo.materilId)
	GiftController.instance:dispatchEvent(GiftEvent.MultipleChoice)
end

function slot0._onRightClickItem(slot0)
	GameGlobalMgr.instance:playTouchEffect()
	slot0:_onLongClickItem()
end

function slot0._onLongClickItem(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._mo.materilType, slot0._mo.materilId)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot0._mo.materilType, slot0._mo.materilId)

	if slot0._mo.materilType == MaterialEnum.MaterialType.Equip then
		slot0._itemIcon = IconMgr.instance:getCommonEquipIcon(slot0._itemPos)

		slot0._itemIcon:setMOValue(slot0._mo.materilType, slot0._mo.materilId, slot0._mo.quantity, nil, true)
		slot0._itemIcon:hideLv(true)
	else
		slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._itemPos)

		slot0._itemIcon:setMOValue(slot0._mo.materilType, slot0._mo.materilId, slot0._mo.quantity, nil, true)
	end

	slot0._name.text = slot2.name

	gohelper.setActive(slot0._goneed, GiftModel.instance:isGiftNeed(slot0._mo.materilId))
	slot0:_refreshItem()
end

function slot0.onDestroy(slot0)
end

return slot0
