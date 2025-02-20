module("modules.logic.handbook.view.HandbookStoryView", package.seeall)

slot0 = class("HandbookStoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#scroll_storylist/viewport/content/linelayout/#go_line")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_switch")
	slot0._gochapteritem = gohelper.findChild(slot0.viewGO, "#scroll_chapterlist/viewport/content/#go_chapteritem")
	slot0._scrollstorylist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_storylist")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnswitch:RemoveClickListener()
end

function slot0._btnswitchOnClick(slot0)
	HandbookController.instance:openCGView()
end

function slot0._editableInitView(slot0)
	slot0._goStoryListContent = gohelper.findChild(slot0.viewGO, "#scroll_storylist/viewport/content")

	gohelper.setActive(slot0._gochapteritem, false)

	slot0._chapterItemList = {}
	slot0._storyItemList = slot0:getUserDataTb_()
	slot0._delayStoryAnimList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goline.gameObject, false)

	slot0._lineSingleImageList = slot0:getUserDataTb_()
	slot0._lineAnimList = slot0:getUserDataTb_()

	slot0._simagebg:LoadImage(ResUrl.getStoryBg("story_bg/bg/huashengdunguangchang.jpg"))

	slot0.itemPrefab = slot0:_getStoryItemPrefab()

	gohelper.addUIClickAudio(slot0._btnswitch.gameObject, AudioEnum.UI.play_ui_screenplay_plot_switch)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)

	slot0._playLineAnim = true

	slot0:_refreshUI()
end

function slot0._getStoryItemPrefab(slot0)
	slot1 = ViewMgr.instance:getContainer(ViewName.HandbookStoryView)

	return slot1._abLoader:getAssetItem(slot1:getSetting().otherRes[1]):GetResource()
end

function slot0.onOpenFinish(slot0)
	slot0._anim.enabled = true
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.HandbookCGView then
		ViewMgr.instance:closeView(ViewName.HandbookStoryView, true)
	end
end

function slot0._refreshLine(slot0, slot1)
	for slot8 = 1, math.ceil((170 + slot1 * 480 - 58 * (slot1 - 1)) / recthelper.getWidth(slot0._goline.transform)) do
		if not slot0._lineSingleImageList[slot8] then
			slot10 = gohelper.cloneInPlace(slot0._goline, "item" .. slot8)
			slot9 = gohelper.getSingleImage(slot10)

			slot9:LoadImage(ResUrl.getHandbookBg("bg_timeline"))
			table.insert(slot0._lineSingleImageList, slot9)
			table.insert(slot0._lineAnimList, slot10:GetComponent(typeof(UnityEngine.Animation)))
		end

		gohelper.setActive(slot9.gameObject, true)

		if slot0._playLineAnim then
			slot0._lineAnimList[slot8]:Play()

			slot0._playLineAnim = false
		end
	end

	for slot8 = slot4 + 1, #slot0._lineSingleImageList do
		gohelper.setActive(slot0._lineSingleImageList[slot8].gameObject, false)
		slot0._lineAnimList[slot8]:Stop()
	end
end

function slot0._refreshUI(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(HandbookConfig.instance:getStoryChapterList()) do
		if HandbookModel.instance:getStoryGroupUnlockCount(slot7.id) > 0 then
			table.insert(slot1, slot7.id)
		end
	end

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]

		if not slot0._chapterItemList[slot6] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.cloneInPlace(slot0._gochapteritem, "item" .. slot6)
			slot8.gobeselected = gohelper.findChild(slot8.go, "beselected")
			slot8.gounselected = gohelper.findChild(slot8.go, "unselected")
			slot8.chapternamecn1 = gohelper.findChildText(slot8.go, "beselected/chapternamecn")
			slot8.chapternameen1 = gohelper.findChildText(slot8.go, "beselected/chapternameen")
			slot8.chapternamecn2 = gohelper.findChildText(slot8.go, "unselected/chapternamecn")
			slot8.chapternameen2 = gohelper.findChildText(slot8.go, "unselected/chapternameen")
			slot8.btnclick = gohelper.findChildButtonWithAudio(slot8.go, "btnclick", AudioEnum.UI.Play_UI_Universal_Click)

			slot8.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot8)
			table.insert(slot0._chapterItemList, slot8)
		end

		slot8.storyChapterId = slot7
		slot9 = HandbookConfig.instance:getStoryChapterConfig(slot7)
		slot8.chapternamecn1.text = slot9.name
		slot8.chapternamecn2.text = slot9.name
		slot8.chapternameen1.text = slot9.nameEn
		slot8.chapternameen2.text = slot9.nameEn

		gohelper.setActive(slot8.go, true)
	end

	for slot6 = #slot1 + 1, #slot0._chapterItemList do
		gohelper.setActive(slot0._chapterItemList[slot6].go, false)
	end

	if #slot0._chapterItemList > 0 then
		slot0:_btnclickOnClick(slot0._chapterItemList[1])
	else
		HandbookStoryListModel.instance:clearStoryList()
	end
end

function slot0._btnclickOnClick(slot0, slot1)
	slot7 = HandbookConfig.instance:getStoryGroupList()
	slot8 = slot1.storyChapterId

	HandbookStoryListModel.instance:setStoryList(slot7, slot8)

	for slot7, slot8 in ipairs(slot0._chapterItemList) do
		gohelper.setActive(slot8.gobeselected, slot2 == slot8.storyChapterId)
		gohelper.setActive(slot8.gounselected, slot2 ~= slot8.storyChapterId)
	end

	slot0:_refreshLine(HandbookModel.instance:getStoryGroupUnlockCount(slot2))

	slot0._scrollstorylist.horizontalNormalizedPosition = 0

	slot0:_cloneStoryItem()
end

function slot0._cloneStoryItem(slot0)
	slot0:_stopStoryItemEnterAnim()

	slot1 = HandbookStoryListModel.instance:getStoryList()
	slot0.storyItemMoList = slot1

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._storyItemList[slot5] then
			slot7 = {
				go = gohelper.clone(slot0.itemPrefab, slot0._goStoryListContent, "item" .. slot5)
			}
			slot7.anim = slot7.go:GetComponent(typeof(UnityEngine.Animator))
			slot7.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot7.go, HandbookStoryItem, slot0)
			slot7.anim.enabled = false

			table.insert(slot0._storyItemList, slot7)
		end

		gohelper.setActive(slot7.go, false)
		slot7.item:onInitView(slot7.go)
		slot7.item:onUpdateMO(slot6)
	end

	slot0.playedAnimIndex = 0

	slot0:_showStoryItemEnterAnim()
end

function slot0._stopStoryItemEnterAnim(slot0)
	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._showStoryItemEnterAnim, slot4)

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

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._lineSingleImageList) do
		slot5:UnLoadImage()
	end

	for slot4, slot5 in ipairs(slot0._chapterItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	slot0._simagebg:UnLoadImage()
end

return slot0
