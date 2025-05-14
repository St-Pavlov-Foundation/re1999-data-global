module("modules.logic.dungeon.view.DungeonChapterItem", package.seeall)

local var_0_0 = class("DungeonChapterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagechapterIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#simage_chapterIcon")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "anim/#go_lock")
	arg_1_0._simagechapterIconLock = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#go_lock/#simage_chapterIconLock")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "anim/#txt_name")
	arg_1_0._gobgdot = gohelper.findChild(arg_1_0.viewGO, "anim/bg_dot")
	arg_1_0._gobgdot2 = gohelper.findChild(arg_1_0.viewGO, "anim/bg_glow02")
	arg_1_0._gobgdot3 = gohelper.findChild(arg_1_0.viewGO, "anim/bg_glow03")
	arg_1_0._gobgdot4 = gohelper.findChild(arg_1_0.viewGO, "anim/bg_glow04")
	arg_1_0._imagelockicon = gohelper.findChildImage(arg_1_0.viewGO, "anim/#go_lock/icon")
	arg_1_0._txtchapterNum = gohelper.findChildText(arg_1_0.viewGO, "anim/#go_lock/#txt_chapterNum")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "anim/#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btncategoryOnClick(arg_4_0)
	arg_4_0._isLock, arg_4_0._lockCode, arg_4_0._lockToast, arg_4_0._lockToastParam = DungeonModel.instance:chapterIsLock(arg_4_0._mo.id)

	if arg_4_0._isLock then
		if arg_4_0._lockToast then
			GameFacade.showToast(arg_4_0._lockToast, arg_4_0._lockToastParam)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)

	local var_4_0 = {
		chapterId = arg_4_0._mo.id
	}

	DungeonController.instance:openDungeonChapterView(var_4_0)
	arg_4_0:_setDotState(false)
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = gohelper.findChild(arg_5_0.viewGO, "anim")

	arg_5_0._anim = var_5_0:GetComponent(typeof(UnityEngine.Animation))
	arg_5_0._canvasGroup = var_5_0:GetComponent(typeof(UnityEngine.CanvasGroup))

	local var_5_1 = DungeonChapterListModel.instance.firstShowNormalTime

	arg_5_0._canPlayEnterAnim = var_5_1 and Time.time - var_5_1 < 0.5
	arg_5_0._click = SLFramework.UGUI.UIClickListener.Get(arg_5_0.viewGO)

	local var_5_2 = GameConfig:GetCurLangType() == LangSettings.en

	if arg_5_0._txtname.gameObject:GetComponent(gohelper.Type_TextMesh) then
		arg_5_0._txtname.alignment = var_5_2 and TMPro.TextAlignmentOptions.Top or TMPro.TextAlignmentOptions.Center
	end
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0._click:AddClickListener(arg_6_0._btncategoryOnClick, arg_6_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_6_0._onCloseViewFinish, arg_6_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnGetPointReward, arg_6_0._updateMapTip, arg_6_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnGuidePlayUnlockAnim, arg_6_0._onGuidePlayUnlockAnim, arg_6_0)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_6_0._onStart, arg_6_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_6_0._onFinish, arg_6_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnShowStoryView, arg_6_0._setEnterAnimState, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0._click:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGetPointReward, arg_7_0._updateMapTip, arg_7_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGuidePlayUnlockAnim, arg_7_0._onGuidePlayUnlockAnim, arg_7_0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, arg_7_0._onStart, arg_7_0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_7_0._onFinish, arg_7_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnShowStoryView, arg_7_0._setEnterAnimState, arg_7_0)
end

function var_0_0._onStart(arg_8_0, arg_8_1)
	arg_8_0._simagechapterIcon:UnLoadImage()
end

function var_0_0._onFinish(arg_9_0, arg_9_1)
	arg_9_0._simagechapterIcon:LoadImage(ResUrl.getDungeonIcon(arg_9_0._mo.chapterpic))
end

function var_0_0._onGuidePlayUnlockAnim(arg_10_0)
	if arg_10_0:_isNewChapter() then
		DungeonModel.instance.chapterTriggerNewChapter = true

		arg_10_0:_doShowUnlockAnim()
	end
end

function var_0_0._onCloseViewFinish(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == ViewName.DungeonMapView then
		arg_11_0:_updateMapTip()
		arg_11_0:_doShowUnlockAnim()
	end
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0._mo = arg_12_1

	local var_12_0 = arg_12_1.id
	local var_12_1 = ResUrl.getDungeonIcon(arg_12_1.chapterpic)

	arg_12_0._simagechapterIcon:LoadImage(var_12_1)
	arg_12_0._simagechapterIconLock:LoadImage(ResUrl.getDungeonIcon(arg_12_1.chapterpic .. "_lock"))

	arg_12_0._isLock, arg_12_0._lockCode, arg_12_0._lockToast, arg_12_0._lockToastParam = DungeonModel.instance:chapterIsLock(arg_12_0._mo.id)
	arg_12_0._txtname.text = arg_12_1.name

	local var_12_2 = DungeonChapterListModel.instance:getChapterIndex(var_12_0)

	if var_12_2 then
		arg_12_0._txtchapterNum.text = string.format("CHAPTER %s", var_12_2)
	else
		arg_12_0._txtchapterNum.text = "CHAPTER"
	end

	local var_12_3, var_12_4 = DungeonModel.instance:getLastEpisodeConfigAndInfo()

	gohelper.setActive(arg_12_0._gopointLight, var_12_0 == var_12_3.chapterId)

	if not arg_12_0:_doShowUnlockAnim() then
		arg_12_0:_setLockStatus(arg_12_0:IsLock())
	end

	arg_12_0:_setEnterAnim()
	arg_12_0:_updateMapTip()
	arg_12_0:refreshRed()
end

function var_0_0._setEnterAnim(arg_13_0)
	if arg_13_0._canPlayEnterAnim then
		local var_13_0 = arg_13_0:_getInAnimName()
		local var_13_1 = arg_13_0._anim:GetClip(var_13_0)

		if var_13_1 then
			arg_13_0._anim:Play(var_13_0)

			arg_13_0._canvasGroup.alpha = 0

			TaskDispatcher.cancelTask(arg_13_0._onEnterAnimFinished, arg_13_0)
			TaskDispatcher.runDelay(arg_13_0._onEnterAnimFinished, arg_13_0, var_13_1.length)

			return
		end
	end

	arg_13_0:playIdleAnim()
end

function var_0_0.playIdleAnim(arg_14_0)
	local var_14_0 = arg_14_0:_getIdleAnimName()

	if not var_14_0 then
		return
	end

	if arg_14_0._anim:GetClip(var_14_0) then
		arg_14_0._canvasGroup.alpha = 1

		arg_14_0._anim:Play(var_14_0)
	end
end

function var_0_0._getIdleAnimName(arg_15_0)
	return nil
end

function var_0_0.playCloseAnim(arg_16_0)
	arg_16_0._isPlayCloseAnim = true

	local var_16_0 = arg_16_0:_getCloseAnimName()

	arg_16_0._anim:Play(var_16_0)
end

function var_0_0.getIsPlayCloseAnim(arg_17_0)
	return arg_17_0._isPlayCloseAnim
end

function var_0_0._getInAnimName(arg_18_0)
	return "dungeonchapteritem_in"
end

function var_0_0._getCloseAnimName(arg_19_0)
	return "dungeonchapteritem_close"
end

function var_0_0._onEnterAnimFinished(arg_20_0)
	arg_20_0._canPlayEnterAnim = false
end

function var_0_0._setEnterAnimState(arg_21_0)
	arg_21_0._canPlayEnterAnim = true

	arg_21_0:_setDotState(false)
	arg_21_0:_setEnterAnim()
end

function var_0_0.IsLock(arg_22_0)
	return arg_22_0._isLock or arg_22_0:_isNewChapter()
end

function var_0_0._isShowBtnGift(arg_23_0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward)
end

function var_0_0._updateMapTip(arg_24_0)
	return
end

function var_0_0._isNewChapter(arg_25_0)
	return arg_25_0._mo.id == DungeonModel.instance.unlockNewChapterId or DungeonModel.instance:needUnlockChapterAnim(arg_25_0._mo.id)
end

function var_0_0._doShowUnlockAnim(arg_26_0)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		return false
	end

	local var_26_0 = GameGlobalMgr.instance:getLoadingState()

	if var_26_0 and var_26_0:getLoadingViewName() then
		return false
	end

	if DungeonModel.instance.chapterTriggerNewChapter and arg_26_0:_isNewChapter() or DungeonModel.instance:needUnlockChapterAnim(arg_26_0._mo.id) then
		arg_26_0:_setLockStatus(true)
		TaskDispatcher.runDelay(arg_26_0.showUnlockAnim, arg_26_0, 0.5)

		return true
	end

	return false
end

function var_0_0._setLockStatus(arg_27_0, arg_27_1)
	arg_27_0._golock:SetActive(arg_27_1)
	gohelper.setActive(arg_27_0._txtname.gameObject, not arg_27_1)
end

function var_0_0._onAnimFinished(arg_28_0)
	arg_28_0:_endBlock()
	arg_28_0:_setLockStatus(false)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
end

function var_0_0._endBlock(arg_29_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(arg_29_0:_getBlockName())

	arg_29_0._startBlock = false
end

function var_0_0._getBlockName(arg_30_0)
	arg_30_0._blockName = arg_30_0._blockName or "UnlockNewChapterAnim" .. tostring(arg_30_0._mo.id)

	return arg_30_0._blockName
end

function var_0_0.showUnlockAnim(arg_31_0)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		arg_31_0:_setLockStatus(arg_31_0:IsLock())

		return
	end

	local var_31_0 = DungeonModel.instance.chapterTriggerNewChapter and arg_31_0:_isNewChapter()

	if var_31_0 or DungeonModel.instance:needUnlockChapterAnim(arg_31_0._mo.id) then
		if var_31_0 then
			DungeonModel.instance.chapterTriggerNewChapter = nil
			DungeonModel.instance.unlockNewChapterId = nil
		end

		DungeonModel.instance:clearUnlockChapterAnim(arg_31_0._mo.id)

		if not gohelper.isNil(arg_31_0._anim) then
			local var_31_1 = arg_31_0:_getUnlockAnimName()
			local var_31_2 = arg_31_0._anim:GetClip(var_31_1)

			if var_31_2 then
				UIBlockMgr.instance:endAll()
				UIBlockMgrExtend.setNeedCircleMv(false)
				UIBlockMgr.instance:startBlock(arg_31_0:_getBlockName())

				arg_31_0._startBlock = true

				TaskDispatcher.runDelay(arg_31_0._onAnimFinished, arg_31_0, var_31_2.length)
				gohelper.setActive(arg_31_0._txtname.gameObject, true)
			end

			arg_31_0._canvasGroup.alpha = 1

			arg_31_0._anim:Play(var_31_1)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	end
end

function var_0_0._getUnlockAnimName(arg_32_0)
	return "dungeonchapteritem_unlock"
end

function var_0_0.onSelect(arg_33_0, arg_33_1)
	return
end

function var_0_0._setDotState(arg_34_0, arg_34_1)
	gohelper.setActive(arg_34_0._gobgdot, arg_34_1)
	gohelper.setActive(arg_34_0._gobgdot2, arg_34_1)
	gohelper.setActive(arg_34_0._gobgdot3, arg_34_1)
	gohelper.setActive(arg_34_0._gobgdot4, arg_34_1)
	ZProj.UGUIHelper.SetColorAlpha(arg_34_0._imagelockicon, 1)
end

function var_0_0.refreshRed(arg_35_0)
	local var_35_0 = DungeonModel.instance:getChapterRedId(arg_35_0._mo.id)

	if var_35_0 and var_35_0 > 0 then
		if not arg_35_0.redDot then
			arg_35_0.redDot = RedDotController.instance:addRedDot(arg_35_0._goreddot, var_35_0, 0)
		else
			arg_35_0.redDot:refreshDot()
		end
	end
end

function var_0_0.onDestroyView(arg_36_0)
	arg_36_0._simagechapterIcon:UnLoadImage()
	arg_36_0._simagechapterIconLock:UnLoadImage()
	TaskDispatcher.cancelTask(arg_36_0._onEnterAnimFinished, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._onAnimFinished, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.showUnlockAnim, arg_36_0)

	if arg_36_0._startBlock then
		arg_36_0:_endBlock()
	end
end

return var_0_0
