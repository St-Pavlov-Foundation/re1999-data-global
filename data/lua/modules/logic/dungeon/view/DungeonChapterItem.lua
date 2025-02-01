module("modules.logic.dungeon.view.DungeonChapterItem", package.seeall)

slot0 = class("DungeonChapterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simagechapterIcon = gohelper.findChildSingleImage(slot0.viewGO, "anim/#simage_chapterIcon")
	slot0._golock = gohelper.findChild(slot0.viewGO, "anim/#go_lock")
	slot0._simagechapterIconLock = gohelper.findChildSingleImage(slot0.viewGO, "anim/#go_lock/#simage_chapterIconLock")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "anim/#txt_name")
	slot0._gobgdot = gohelper.findChild(slot0.viewGO, "anim/bg_dot")
	slot0._gobgdot2 = gohelper.findChild(slot0.viewGO, "anim/bg_glow02")
	slot0._gobgdot3 = gohelper.findChild(slot0.viewGO, "anim/bg_glow03")
	slot0._gobgdot4 = gohelper.findChild(slot0.viewGO, "anim/bg_glow04")
	slot0._imagelockicon = gohelper.findChildImage(slot0.viewGO, "anim/#go_lock/icon")
	slot0._txtchapterNum = gohelper.findChildText(slot0.viewGO, "anim/#go_lock/#txt_chapterNum")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "anim/#go_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btncategoryOnClick(slot0)
	slot0._isLock, slot0._lockCode, slot0._lockToast, slot0._lockToastParam = DungeonModel.instance:chapterIsLock(slot0._mo.id)

	if slot0._isLock then
		if slot0._lockToast then
			GameFacade.showToast(slot0._lockToast, slot0._lockToastParam)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	DungeonController.instance:openDungeonChapterView({
		chapterId = slot0._mo.id
	})
	slot0:_setDotState(false)
end

function slot0._editableInitView(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "anim")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animation))
	slot0._canvasGroup = slot1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._canPlayEnterAnim = DungeonChapterListModel.instance.firstShowNormalTime and Time.time - slot2 < 0.5
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)

	if slot0._txtname.gameObject:GetComponent(gohelper.Type_TextMesh) then
		slot0._txtname.alignment = GameConfig:GetCurLangType() == LangSettings.en and TMPro.TextAlignmentOptions.Top or TMPro.TextAlignmentOptions.Center
	end
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._btncategoryOnClick, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnGetPointReward, slot0._updateMapTip, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnGuidePlayUnlockAnim, slot0._onGuidePlayUnlockAnim, slot0)
	StoryController.instance:registerCallback(StoryEvent.Start, slot0._onStart, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._onFinish, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnShowStoryView, slot0._setEnterAnimState, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGetPointReward, slot0._updateMapTip, slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGuidePlayUnlockAnim, slot0._onGuidePlayUnlockAnim, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, slot0._onStart, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, slot0._onFinish, slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnShowStoryView, slot0._setEnterAnimState, slot0)
end

function slot0._onStart(slot0, slot1)
	slot0._simagechapterIcon:UnLoadImage()
end

function slot0._onFinish(slot0, slot1)
	slot0._simagechapterIcon:LoadImage(ResUrl.getDungeonIcon(slot0._mo.chapterpic))
end

function slot0._onGuidePlayUnlockAnim(slot0)
	if slot0:_isNewChapter() then
		DungeonModel.instance.chapterTriggerNewChapter = true

		slot0:_doShowUnlockAnim()
	end
end

function slot0._onCloseViewFinish(slot0, slot1, slot2)
	if slot1 == ViewName.DungeonMapView then
		slot0:_updateMapTip()
		slot0:_doShowUnlockAnim()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._simagechapterIcon:LoadImage(ResUrl.getDungeonIcon(slot1.chapterpic))
	slot0._simagechapterIconLock:LoadImage(ResUrl.getDungeonIcon(slot1.chapterpic .. "_lock"))

	slot0._isLock, slot0._lockCode, slot0._lockToast, slot0._lockToastParam = DungeonModel.instance:chapterIsLock(slot0._mo.id)
	slot0._txtname.text = slot1.name

	if DungeonChapterListModel.instance:getChapterIndex(slot1.id) then
		slot0._txtchapterNum.text = string.format("CHAPTER %s", slot4)
	else
		slot0._txtchapterNum.text = "CHAPTER"
	end

	slot5, slot6 = DungeonModel.instance:getLastEpisodeConfigAndInfo()

	gohelper.setActive(slot0._gopointLight, slot2 == slot5.chapterId)

	if not slot0:_doShowUnlockAnim() then
		slot0:_setLockStatus(slot0:IsLock())
	end

	slot0:_setEnterAnim()
	slot0:_updateMapTip()
	slot0:refreshRed()
end

function slot0._setEnterAnim(slot0)
	if slot0._canPlayEnterAnim and slot0._anim:GetClip(slot0:_getInAnimName()) then
		slot0._anim:Play(slot1)

		slot0._canvasGroup.alpha = 0

		TaskDispatcher.cancelTask(slot0._onEnterAnimFinished, slot0)
		TaskDispatcher.runDelay(slot0._onEnterAnimFinished, slot0, slot2.length)

		return
	end

	slot0:playIdleAnim()
end

function slot0.playIdleAnim(slot0)
	if not slot0:_getIdleAnimName() then
		return
	end

	if slot0._anim:GetClip(slot1) then
		slot0._canvasGroup.alpha = 1

		slot0._anim:Play(slot1)
	end
end

function slot0._getIdleAnimName(slot0)
	return nil
end

function slot0.playCloseAnim(slot0)
	slot0._isPlayCloseAnim = true

	slot0._anim:Play(slot0:_getCloseAnimName())
end

function slot0.getIsPlayCloseAnim(slot0)
	return slot0._isPlayCloseAnim
end

function slot0._getInAnimName(slot0)
	return "dungeonchapteritem_in"
end

function slot0._getCloseAnimName(slot0)
	return "dungeonchapteritem_close"
end

function slot0._onEnterAnimFinished(slot0)
	slot0._canPlayEnterAnim = false
end

function slot0._setEnterAnimState(slot0)
	slot0._canPlayEnterAnim = true

	slot0:_setDotState(false)
	slot0:_setEnterAnim()
end

function slot0.IsLock(slot0)
	return slot0._isLock or slot0:_isNewChapter()
end

function slot0._isShowBtnGift(slot0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward)
end

function slot0._updateMapTip(slot0)
end

function slot0._isNewChapter(slot0)
	return slot0._mo.id == DungeonModel.instance.unlockNewChapterId or DungeonModel.instance:needUnlockChapterAnim(slot0._mo.id)
end

function slot0._doShowUnlockAnim(slot0)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		return false
	end

	if GameGlobalMgr.instance:getLoadingState() and slot1:getLoadingViewName() then
		return false
	end

	if DungeonModel.instance.chapterTriggerNewChapter and slot0:_isNewChapter() or DungeonModel.instance:needUnlockChapterAnim(slot0._mo.id) then
		slot0:_setLockStatus(true)
		TaskDispatcher.runDelay(slot0.showUnlockAnim, slot0, 0.5)

		return true
	end

	return false
end

function slot0._setLockStatus(slot0, slot1)
	slot0._golock:SetActive(slot1)
	gohelper.setActive(slot0._txtname.gameObject, not slot1)
end

function slot0._onAnimFinished(slot0)
	slot0:_endBlock()
	slot0:_setLockStatus(false)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
end

function slot0._endBlock(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(slot0:_getBlockName())

	slot0._startBlock = false
end

function slot0._getBlockName(slot0)
	slot0._blockName = slot0._blockName or "UnlockNewChapterAnim" .. tostring(slot0._mo.id)

	return slot0._blockName
end

function slot0.showUnlockAnim(slot0)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		slot0:_setLockStatus(slot0:IsLock())

		return
	end

	if DungeonModel.instance.chapterTriggerNewChapter and slot0:_isNewChapter() or DungeonModel.instance:needUnlockChapterAnim(slot0._mo.id) then
		if slot1 then
			DungeonModel.instance.chapterTriggerNewChapter = nil
			DungeonModel.instance.unlockNewChapterId = nil
		end

		DungeonModel.instance:clearUnlockChapterAnim(slot0._mo.id)

		if not gohelper.isNil(slot0._anim) then
			if slot0._anim:GetClip(slot0:_getUnlockAnimName()) then
				UIBlockMgr.instance:endAll()
				UIBlockMgrExtend.setNeedCircleMv(false)
				UIBlockMgr.instance:startBlock(slot0:_getBlockName())

				slot0._startBlock = true

				TaskDispatcher.runDelay(slot0._onAnimFinished, slot0, slot3.length)
				gohelper.setActive(slot0._txtname.gameObject, true)
			end

			slot0._canvasGroup.alpha = 1

			slot0._anim:Play(slot2)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	end
end

function slot0._getUnlockAnimName(slot0)
	return "dungeonchapteritem_unlock"
end

function slot0.onSelect(slot0, slot1)
end

function slot0._setDotState(slot0, slot1)
	gohelper.setActive(slot0._gobgdot, slot1)
	gohelper.setActive(slot0._gobgdot2, slot1)
	gohelper.setActive(slot0._gobgdot3, slot1)
	gohelper.setActive(slot0._gobgdot4, slot1)
	ZProj.UGUIHelper.SetColorAlpha(slot0._imagelockicon, 1)
end

function slot0.refreshRed(slot0)
	if DungeonModel.instance:getChapterRedId(slot0._mo.id) and slot1 > 0 then
		if not slot0.redDot then
			slot0.redDot = RedDotController.instance:addRedDot(slot0._goreddot, slot1, 0)
		else
			slot0.redDot:refreshDot()
		end
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagechapterIcon:UnLoadImage()
	slot0._simagechapterIconLock:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._onEnterAnimFinished, slot0)
	TaskDispatcher.cancelTask(slot0._onAnimFinished, slot0)
	TaskDispatcher.cancelTask(slot0.showUnlockAnim, slot0)

	if slot0._startBlock then
		slot0:_endBlock()
	end
end

return slot0
