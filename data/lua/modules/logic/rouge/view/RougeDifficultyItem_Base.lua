module("modules.logic.rouge.view.RougeDifficultyItem_Base", package.seeall)

slot0 = class("RougeDifficultyItem_Base", RougeItemNodeBase)

function slot0._editableInitView(slot0)
	slot0._itemClick = gohelper.getClickWithAudio(slot0.viewGO)
	slot0._goNumList = slot0:getUserDataTb_()
	slot0._txtNumList = slot0:getUserDataTb_()

	slot0:_fillUserDataTb("_txtnum", slot0._goNumList, slot0._txtNumList)

	slot0._goBgList = slot0:getUserDataTb_()

	slot0:_fillUserDataTb("_goBg", slot0._goBgList)
end

function slot0.addEventListeners(slot0)
	RougeItemNodeBase.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
	RougeItemNodeBase.removeEventListeners(slot0)
	GameUtil.onDestroyViewMember_ClickListener(slot0, "_itemClick")
end

function slot0._onItemClick(slot0)
	slot0:dispatchEvent(RougeEvent.RougeDifficultyView_OnSelectIndex, slot0:index())
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1
	slot4 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(slot1.difficultyCO.difficulty)

	for slot8, slot9 in ipairs(slot0._goNumList) do
		gohelper.setActive(slot9, false)
	end

	slot8 = true

	gohelper.setActive(slot0._goNumList[slot4], slot8)

	for slot8, slot9 in ipairs(slot0._goBgList) do
		gohelper.setActive(slot9, false)
	end

	gohelper.setActive(slot0._goBgList[slot4], true)

	slot0._txtNumList[slot4].text = slot3
	slot0._txtname.text = slot2.title
	slot0._txten.text = slot2.title_en
end

return slot0
