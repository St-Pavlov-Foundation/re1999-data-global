module("modules.logic.backpack.view.BackpackCategoryListItem", package.seeall)

slot0 = class("BackpackCategoryListItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._bgs = slot0:getUserDataTb_()
	slot0._nameTxt = slot0:getUserDataTb_()
	slot0._subnameTxt = slot0:getUserDataTb_()

	for slot5 = 1, 2 do
		slot0._bgs[slot5] = gohelper.findChild(slot1, "bg" .. tostring(slot5))
		slot0._nameTxt[slot5] = gohelper.findChildText(slot0._bgs[slot5], "#txt_itemcn" .. tostring(slot5))
		slot0._subnameTxt[slot5] = gohelper.findChildText(slot0._bgs[slot5], "#txt_itemen" .. tostring(slot5))
	end

	gohelper.setActive(slot0._bgs[2], false)

	slot0._btnCategory = SLFramework.UGUI.UIClickListener.Get(slot1)
	slot0._deadline1 = gohelper.findChild(slot1, "bg1/#txt_itemcn1/deadline1")
	slot0._deadlinebg = gohelper.findChildImage(slot1, "bg1/#txt_itemcn1/deadline1/deadlinebg")
	slot0._deadlineTxt1 = gohelper.findChildText(slot0._deadline1, "deadlinetxt")
	slot0._deadlineEffect = gohelper.findChild(slot0._deadline1, "#effect")
	slot0._deadlinetimeicon = gohelper.findChildImage(slot0._deadline1, "deadlinetxt/timeicon")
	slot0._format1 = gohelper.findChildText(slot0._deadline1, "deadlinetxt/format")
	slot0._lastIsDay = nil
end

function slot0.addEventListeners(slot0)
	slot0._btnCategory:AddClickListener(slot0._onItemClick, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
end

function slot0.removeEventListeners(slot0)
	slot0._btnCategory:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0, 1)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot0:_isSelected()

	gohelper.setActive(slot0._bgs[1], not slot2)
	gohelper.setActive(slot0._bgs[2], slot2)

	if slot2 then
		slot0._nameTxt[2].text = slot1.name
		slot0._subnameTxt[2].text = slot1.subname
	else
		slot0._nameTxt[1].text = slot1.name
		slot0._subnameTxt[1].text = slot1.subname
	end

	slot0:_onRefreshDeadline()
end

function slot0._onRefreshDeadline(slot0)
	if slot0:_isSelected() then
		return
	end

	slot1, slot2, slot3, slot4, slot5, slot6, slot7 = nil

	if slot0._mo.id == ItemEnum.CategoryType.Equip then
		gohelper.setActive(slot0._deadline1, false)

		return
	end

	slot2 = slot0._deadlineTxt1
	slot3 = slot0._format1
	slot5 = slot0._deadlinebg
	slot6 = slot0._deadlinetimeicon
	slot7 = slot0._deadlineEffect

	if BackpackModel.instance:getCategoryItemsDeadline(slot0._mo.id) and slot8 > 0 and slot0._mo.id ~= 0 then
		gohelper.setActive(slot1, true)

		if math.floor(slot8 - ServerTime.now()) <= 0 then
			gohelper.setActive(slot1, false)

			return
		end

		slot2.text, slot3.text, slot4 = TimeUtil.secondToRoughTime(slot9, true)

		if slot0._lastIsDay == nil or slot0._lastIsDay ~= slot4 then
			UISpriteSetMgr.instance:setCommonSprite(slot5, slot4 and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(slot6, slot4 and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(slot2, slot4 and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(slot3, slot4 and "#98D687" or "#E99B56")
			gohelper.setActive(slot7, not slot4)

			slot0._lastIsDay = slot4
		end
	else
		gohelper.setActive(slot1, false)
	end

	gohelper.setActive(slot0._deadline2, false)
end

function slot0._isSelected(slot0)
	return slot0._mo.id == BackpackModel.instance:getCurCategoryId()
end

function slot0._onItemClick(slot0)
	if slot0:_isSelected() then
		return
	end

	BackpackModel.instance:setItemAniHasShown(false)
	BackpackModel.instance:setCurCategoryId(slot0._mo.id)
	BackpackController.instance:dispatchEvent(BackpackEvent.SelectCategory)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0.onDestroy(slot0)
	slot0._lastIsDay = nil
end

return slot0
