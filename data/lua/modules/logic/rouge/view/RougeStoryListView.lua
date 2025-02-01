module("modules.logic.rouge.view.RougeStoryListView", package.seeall)

slot0 = class("RougeStoryListView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollstorylist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_storylist")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#scroll_storylist/viewport/content/linelayout/#go_line")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goStoryListContent = gohelper.findChild(slot0.viewGO, "#scroll_storylist/viewport/content")
	slot0._storyItemList = slot0:getUserDataTb_()
end

function slot0._cloneStoryItem(slot0)
	slot0:_stopStoryItemEnterAnim()

	slot1 = RougeFavoriteConfig.instance:getStoryList()
	slot0.storyItemMoList = slot1

	for slot6, slot7 in ipairs(slot1) do
		if not slot0._storyItemList[slot6] then
			slot8 = {
				go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goStoryListContent, "item" .. slot6)
			}
			slot8.anim = slot8.go:GetComponent(typeof(UnityEngine.Animator))
			slot8.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot8.go, RougeStoryListItem)
			slot8.anim.enabled = false

			table.insert(slot0._storyItemList, slot8)
		end

		gohelper.setActive(slot8.go, false)
		slot8.item:onUpdateMO(slot7)
	end

	slot0.playedAnimIndex = 0

	slot0:_showStoryItemEnterAnim()
end

function slot0._stopStoryItemEnterAnim(slot0)
	TaskDispatcher.cancelTask(slot0._showStoryItemEnterAnim, slot0)

	for slot4, slot5 in ipairs(slot0._storyItemList) do
		slot5.anim.enabled = false

		gohelper.setActive(slot5.go, false)
	end
end

function slot0._showStoryItemEnterAnim(slot0)
	if slot0.playedAnimIndex >= #slot0.storyItemMoList then
		return
	end

	slot0.playedAnimIndex = slot0.playedAnimIndex + 1

	gohelper.setActive(slot0._storyItemList[slot0.playedAnimIndex].go, true)

	slot0._storyItemList[slot0.playedAnimIndex].anim.enabled = true

	TaskDispatcher.runDelay(slot0._showStoryItemEnterAnim, slot0, 0.03)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showStoryItemEnterAnim, slot0)
end

function slot0.onOpen(slot0)
	slot0:_cloneStoryItem()
end

function slot0.onDestroyView(slot0)
end

return slot0
