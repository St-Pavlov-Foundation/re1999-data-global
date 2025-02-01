module("modules.logic.versionactivity1_5.act142.view.Activity142MapCategoryItem", package.seeall)

slot0 = class("Activity142MapCategoryItem", LuaCompBase)
slot1 = 1

function slot0.ctor(slot0, slot1)
	slot0._index = slot1.index
	slot0._clickCb = slot1.clickCb
	slot0._clickCbObj = slot1.clickCbObj
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._go)
	slot0._golock = gohelper.findChild(slot0._go, "#go_lock")
	slot0._simagelock = gohelper.findChildImage(slot0._go, "#go_lock")
	slot0._txtlock = gohelper.findChildText(slot0._go, "#go_lock/#txt_lock")
	slot0._gounlock = gohelper.findChild(slot0._go, "#go_unlock")
	slot0._gonormal = gohelper.findChild(slot0._go, "#go_unlock/#go_normal")
	slot0._simagenormal = gohelper.findChildImage(slot0._go, "#go_unlock/#go_normal")
	slot0._txtnormal = gohelper.findChildText(slot0._go, "#go_unlock/#go_normal/#txt_normal")
	slot0._goselect = gohelper.findChild(slot0._go, "#go_unlock/#go_select")
	slot0._simageselect = gohelper.findChildImage(slot0._go, "#go_unlock/#go_select")
	slot0._txtselect = gohelper.findChildText(slot0._go, "#go_unlock/#go_select/#txt_select")
	slot0._btncategory = gohelper.findChildButtonWithAudio(slot0._go, "#btn_click")

	slot0:setChapterId()
	slot0:setIsSelected(false)
end

function slot0.addEventListeners(slot0)
	slot0._btncategory:AddClickListener(slot0.onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btncategory:RemoveClickListener()
end

function slot0.onClick(slot0, slot1)
	if slot0._isSelected or not slot0._chapterId or not slot0._index then
		return
	end

	if not slot0:isChapterOpen() then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	if slot0._clickCb then
		slot0._clickCb(slot0._clickCbObj, slot0._index, slot1)
	end
end

function slot0.setChapterId(slot0, slot1)
	slot0:cancelAllTaskDispatcher()

	slot0._chapterId = slot1

	if slot0._chapterId then
		slot2 = Activity142Model.instance:getActivityId()
		slot3 = Activity142Config.instance:getChapterName(slot2, slot0._chapterId)
		slot0._txtnormal.text = slot3
		slot0._txtselect.text = slot3

		if Activity142Config.instance:getChapterCategoryTxtColor(slot2, slot0._chapterId) then
			slot5 = GameUtil.parseColor(slot4)
			slot0._txtnormal.color = slot5
			slot0._txtselect.color = slot5
		end

		if Activity142Config.instance:getChapterCategoryNormalSP(slot2, slot0._chapterId) then
			UISpriteSetMgr.instance:setV1a5ChessSprite(slot0._simagenormal, slot5)
		end

		if Activity142Config.instance:getChapterCategorySelectSP(slot2, slot0._chapterId) then
			UISpriteSetMgr.instance:setV1a5ChessSprite(slot0._simageselect, slot6)
		end

		if Activity142Config.instance:getChapterCategoryLockSP(slot2, slot0._chapterId) then
			UISpriteSetMgr.instance:setV1a5ChessSprite(slot0._simagelock, slot7)
		end

		slot0:refresh()
		slot0:setIsSelected(false)
	end

	gohelper.setActive(slot0._go, slot0._chapterId)
end

function slot0.getChapterId(slot0)
	return slot0._chapterId
end

function slot0.refresh(slot0, slot1)
	if slot0._animatorPlayer and slot0._animatorPlayer.isActiveAndEnabled then
		slot0._animatorPlayer:Play(Activity142Enum.CATEGORY_IDLE_ANIM)
	end

	if slot0._chapterId ~= Activity142Enum.NOT_PLAY_UNLOCK_ANIM_CHAPTER and not Activity142Controller.instance:havePlayedUnlockAni(string.format("%s_%s", Activity142Enum.CATEGORY_CACHE_KEY, slot0._chapterId)) and slot2 and slot0:isChapterOpen() then
		slot0:playUnlockAnim(slot1)
	else
		gohelper.setActive(slot0._gounlock, slot3)
		gohelper.setActive(slot0._golock, not slot3)
	end
end

function slot0.setIsSelected(slot0, slot1)
	slot0._isSelected = slot1

	gohelper.setActive(slot0._goselect, slot0._isSelected)
	gohelper.setActive(slot0._gonormal, not slot0._isSelected)
end

function slot0.isChapterOpen(slot0)
	return Activity142Model.instance:isChapterOpen(slot0._chapterId)
end

function slot0.playUnlockAnim(slot0, slot1)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.MAP_CATEGORY_UNLOCK)
	gohelper.setActive(slot0._golock, true)
	gohelper.setActive(slot0._gounlock, false)

	if slot1 and slot1 > 0 then
		TaskDispatcher.runDelay(slot0._delayPlayUnlockAnim, slot0, slot1)
	else
		slot0:_delayPlayUnlockAnim()
	end
end

function slot0._delayPlayUnlockAnim(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	gohelper.setActive(slot0._gounlock, true)
	TaskDispatcher.runDelay(slot0.playUnlockAudio, slot0, uv0)
	slot0._animatorPlayer:Play(Activity142Enum.MAP_ITEM_UNLOCK_ANIM, slot0._finishUnlockAnim, slot0)
end

function slot0.playUnlockAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockChapter)
end

function slot0._finishUnlockAnim(slot0)
	Activity142Controller.instance:setPlayedUnlockAni(string.format("%s_%s", Activity142Enum.CATEGORY_CACHE_KEY, slot0._chapterId))
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.MAP_CATEGORY_UNLOCK)
end

function slot0.onDestroy(slot0)
	slot0._index = nil
	slot0._chapterId = nil
	slot0._clickCb = nil
	slot0._clickCbObj = nil
	slot0._isSelected = false

	slot0:cancelAllTaskDispatcher()
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.MAP_CATEGORY_UNLOCK)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.cancelAllTaskDispatcher(slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayUnlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0.playUnlockAudio, slot0)
end

return slot0
