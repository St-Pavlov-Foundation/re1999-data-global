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
	arg_1_0._gopreview = gohelper.findChild(arg_1_0.viewGO, "anim/#go_first")

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

	if arg_4_0._showPreviewChapterFlag then
		local var_4_0 = DungeonMainStoryModel.getKey(PlayerPrefsKey.OpenDungeonPreviewChapter, arg_4_0._mo.id)

		if not PlayerPrefsHelper.hasKey(var_4_0) then
			GameFacade.showMessageBox(MessageBoxIdDefine.PreviewChapterOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(var_4_0, 1)
				arg_4_0:_openDungeonChapterView()
			end, nil, nil)

			return
		end
	end

	arg_4_0:_openDungeonChapterView()
end

function var_0_0._openDungeonChapterView(arg_6_0)
	DungeonMainStoryModel.instance:saveClickChapterId(arg_6_0._mo.id)

	local var_6_0 = {
		chapterId = arg_6_0._mo.id
	}

	DungeonController.instance:openDungeonChapterView(var_6_0)
	arg_6_0:_setDotState(false)
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "anim")

	arg_7_0._anim = var_7_0:GetComponent(typeof(UnityEngine.Animation))
	arg_7_0._canvasGroup = var_7_0:GetComponent(typeof(UnityEngine.CanvasGroup))

	local var_7_1 = DungeonChapterListModel.instance.firstShowNormalTime

	arg_7_0._canPlayEnterAnim = var_7_1 and Time.time - var_7_1 < 0.5
	arg_7_0._click = SLFramework.UGUI.UIClickListener.Get(arg_7_0.viewGO)

	gohelper.setActive(arg_7_0._gopreview, false)

	local var_7_2 = GameConfig:GetCurLangType() == LangSettings.en

	if arg_7_0._txtname.gameObject:GetComponent(gohelper.Type_TextMesh) then
		arg_7_0._txtname.alignment = var_7_2 and TMPro.TextAlignmentOptions.Top or TMPro.TextAlignmentOptions.Center
	end
end

function var_0_0._editableAddEvents(arg_8_0)
	arg_8_0._click:AddClickListener(arg_8_0._btncategoryOnClick, arg_8_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_8_0._onCloseViewFinish, arg_8_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnGetPointReward, arg_8_0._updateMapTip, arg_8_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnGuidePlayUnlockAnim, arg_8_0._onGuidePlayUnlockAnim, arg_8_0)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_8_0._onStart, arg_8_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_8_0._onFinish, arg_8_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnShowStoryView, arg_8_0._setEnterAnimState, arg_8_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_8_0._onUpdateDungeonInfo, arg_8_0)
	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_8_0.onRefreshActivity, arg_8_0)
end

function var_0_0._editableRemoveEvents(arg_9_0)
	arg_9_0._click:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_9_0._onCloseViewFinish, arg_9_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGetPointReward, arg_9_0._updateMapTip, arg_9_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGuidePlayUnlockAnim, arg_9_0._onGuidePlayUnlockAnim, arg_9_0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, arg_9_0._onStart, arg_9_0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_9_0._onFinish, arg_9_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnShowStoryView, arg_9_0._setEnterAnimState, arg_9_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, arg_9_0._onUpdateDungeonInfo, arg_9_0)
	arg_9_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_9_0.onRefreshActivity, arg_9_0)
end

function var_0_0._onStart(arg_10_0, arg_10_1)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		arg_10_0._simagechapterIcon:UnLoadImage()
	end
end

function var_0_0._onFinish(arg_11_0, arg_11_1)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		arg_11_0._simagechapterIcon:LoadImage(ResUrl.getDungeonIcon(arg_11_0._mo.chapterpic))
	end
end

function var_0_0._onGuidePlayUnlockAnim(arg_12_0)
	if arg_12_0:_isNewChapter() then
		DungeonModel.instance.chapterTriggerNewChapter = true

		arg_12_0:_doShowUnlockAnim()
	end
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == ViewName.DungeonMapView then
		arg_13_0:_updateMapTip()
		arg_13_0:_doShowUnlockAnim()
	end
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._mo = arg_14_1

	local var_14_0 = arg_14_1.id
	local var_14_1 = ResUrl.getDungeonIcon(arg_14_1.chapterpic)

	arg_14_0._simagechapterIcon:LoadImage(var_14_1)
	arg_14_0._simagechapterIconLock:LoadImage(ResUrl.getDungeonIcon(arg_14_1.chapterpic .. "_lock"))

	arg_14_0._isLock, arg_14_0._lockCode, arg_14_0._lockToast, arg_14_0._lockToastParam = DungeonModel.instance:chapterIsLock(arg_14_0._mo.id)
	arg_14_0._txtname.text = arg_14_1.name

	local var_14_2 = DungeonChapterListModel.instance:getChapterIndex(var_14_0)

	if var_14_2 then
		arg_14_0._txtchapterNum.text = string.format("CHAPTER %s", var_14_2)
	else
		arg_14_0._txtchapterNum.text = "CHAPTER"
	end

	local var_14_3, var_14_4 = DungeonModel.instance:getLastEpisodeConfigAndInfo()

	gohelper.setActive(arg_14_0._gopointLight, var_14_0 == var_14_3.chapterId)

	if not arg_14_0:_doShowUnlockAnim() then
		arg_14_0:_setLockStatus(arg_14_0:IsLock())
	end

	arg_14_0:_setEnterAnim()
	arg_14_0:_updateMapTip()
	arg_14_0:refreshRed()
	arg_14_0:_updatePreviewFlag()
end

function var_0_0._updatePreviewFlag(arg_15_0)
	arg_15_0._showPreviewChapterFlag = DungeonMainStoryModel.instance:showPreviewChapterFlag(arg_15_0._mo.id)

	gohelper.setActive(arg_15_0._gopreview, arg_15_0._showPreviewChapterFlag)
end

function var_0_0._setEnterAnim(arg_16_0)
	if arg_16_0._canPlayEnterAnim then
		local var_16_0 = arg_16_0:_getInAnimName()
		local var_16_1 = arg_16_0._anim:GetClip(var_16_0)

		if var_16_1 then
			arg_16_0._anim:Play(var_16_0)

			arg_16_0._canvasGroup.alpha = 0

			TaskDispatcher.cancelTask(arg_16_0._onEnterAnimFinished, arg_16_0)
			TaskDispatcher.runDelay(arg_16_0._onEnterAnimFinished, arg_16_0, var_16_1.length)

			return
		end
	end

	arg_16_0:playIdleAnim()
end

function var_0_0.playIdleAnim(arg_17_0)
	local var_17_0 = arg_17_0:_getInAnimName()

	if not var_17_0 then
		return
	end

	if arg_17_0._anim:GetClip(var_17_0) then
		arg_17_0._canvasGroup.alpha = 1

		arg_17_0._anim:Play(var_17_0)
	end
end

function var_0_0.playCloseAnim(arg_18_0)
	arg_18_0._isPlayCloseAnim = true

	local var_18_0 = arg_18_0:_getCloseAnimName()

	arg_18_0._anim:Play(var_18_0)
end

function var_0_0.getIsPlayCloseAnim(arg_19_0)
	return arg_19_0._isPlayCloseAnim
end

function var_0_0._getInAnimName(arg_20_0)
	return "dungeonchapteritem_in"
end

function var_0_0._getCloseAnimName(arg_21_0)
	return "dungeonchapteritem_close"
end

function var_0_0._onEnterAnimFinished(arg_22_0)
	arg_22_0._canPlayEnterAnim = false
end

function var_0_0._setEnterAnimState(arg_23_0)
	arg_23_0._canPlayEnterAnim = true

	arg_23_0:_setDotState(false)
	arg_23_0:_setEnterAnim()
end

function var_0_0._onUpdateDungeonInfo(arg_24_0)
	if arg_24_0._showPreviewChapterFlag then
		arg_24_0:_updatePreviewFlag()
	end
end

function var_0_0.onRefreshActivity(arg_25_0)
	if arg_25_0._showPreviewChapterFlag then
		arg_25_0:_updatePreviewFlag()

		if not arg_25_0._showPreviewChapterFlag then
			arg_25_0._isLock, arg_25_0._lockCode, arg_25_0._lockToast, arg_25_0._lockToastParam = DungeonModel.instance:chapterIsLock(arg_25_0._mo.id)

			arg_25_0:_setLockStatus(arg_25_0:IsLock())
		end
	end
end

function var_0_0.IsLock(arg_26_0)
	return arg_26_0._isLock or arg_26_0:_isNewChapter()
end

function var_0_0._isShowBtnGift(arg_27_0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward)
end

function var_0_0._updateMapTip(arg_28_0)
	return
end

function var_0_0._isNewChapter(arg_29_0)
	return arg_29_0._mo.id == DungeonModel.instance.unlockNewChapterId or DungeonModel.instance:needUnlockChapterAnim(arg_29_0._mo.id)
end

function var_0_0._doShowUnlockAnim(arg_30_0)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		return false
	end

	local var_30_0 = GameGlobalMgr.instance:getLoadingState()

	if var_30_0 and var_30_0:getLoadingViewName() then
		return false
	end

	if DungeonModel.instance.chapterTriggerNewChapter and arg_30_0:_isNewChapter() or DungeonModel.instance:needUnlockChapterAnim(arg_30_0._mo.id) then
		arg_30_0:_setLockStatus(true)
		TaskDispatcher.runDelay(arg_30_0.showUnlockAnim, arg_30_0, 0.5)

		return true
	end

	return false
end

function var_0_0._setLockStatus(arg_31_0, arg_31_1)
	arg_31_0._golock:SetActive(arg_31_1)
	gohelper.setActive(arg_31_0._txtname.gameObject, not arg_31_1)
end

function var_0_0._onAnimFinished(arg_32_0)
	arg_32_0:_endBlock()
	arg_32_0:_setLockStatus(false)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
end

function var_0_0._endBlock(arg_33_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(arg_33_0:_getBlockName())

	arg_33_0._startBlock = false
end

function var_0_0._getBlockName(arg_34_0)
	arg_34_0._blockName = arg_34_0._blockName or "UnlockNewChapterAnim" .. tostring(arg_34_0._mo.id)

	return arg_34_0._blockName
end

function var_0_0.showUnlockAnim(arg_35_0)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		arg_35_0:_setLockStatus(arg_35_0:IsLock())

		return
	end

	local var_35_0 = DungeonModel.instance.chapterTriggerNewChapter and arg_35_0:_isNewChapter()

	if var_35_0 or DungeonModel.instance:needUnlockChapterAnim(arg_35_0._mo.id) then
		if var_35_0 then
			DungeonModel.instance.chapterTriggerNewChapter = nil
			DungeonModel.instance.unlockNewChapterId = nil
		end

		DungeonModel.instance:clearUnlockChapterAnim(arg_35_0._mo.id)

		if not gohelper.isNil(arg_35_0._anim) then
			local var_35_1 = arg_35_0:_getUnlockAnimName()
			local var_35_2 = arg_35_0._anim:GetClip(var_35_1)

			if var_35_2 then
				UIBlockMgr.instance:endAll()
				UIBlockMgrExtend.setNeedCircleMv(false)
				UIBlockMgr.instance:startBlock(arg_35_0:_getBlockName())

				arg_35_0._startBlock = true

				TaskDispatcher.runDelay(arg_35_0._onAnimFinished, arg_35_0, var_35_2.length)
				gohelper.setActive(arg_35_0._txtname.gameObject, true)
			end

			arg_35_0._canvasGroup.alpha = 1

			arg_35_0._anim:Play(var_35_1)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	end
end

function var_0_0._getUnlockAnimName(arg_36_0)
	return "dungeonchapteritem_unlock"
end

function var_0_0.onSelect(arg_37_0, arg_37_1)
	return
end

function var_0_0._setDotState(arg_38_0, arg_38_1)
	gohelper.setActive(arg_38_0._gobgdot, arg_38_1)
	gohelper.setActive(arg_38_0._gobgdot2, arg_38_1)
	gohelper.setActive(arg_38_0._gobgdot3, arg_38_1)
	gohelper.setActive(arg_38_0._gobgdot4, arg_38_1)
	ZProj.UGUIHelper.SetColorAlpha(arg_38_0._imagelockicon, 1)
end

function var_0_0.refreshRed(arg_39_0)
	local var_39_0 = DungeonModel.instance:getChapterRedId(arg_39_0._mo.id)

	if var_39_0 and var_39_0 > 0 then
		if not arg_39_0.redDot then
			arg_39_0.redDot = RedDotController.instance:addRedDot(arg_39_0._goreddot, var_39_0, 0)
		else
			arg_39_0.redDot:refreshDot()
		end
	end
end

function var_0_0.onDestroyView(arg_40_0)
	arg_40_0._simagechapterIcon:UnLoadImage()
	arg_40_0._simagechapterIconLock:UnLoadImage()
	TaskDispatcher.cancelTask(arg_40_0._onEnterAnimFinished, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0._onAnimFinished, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.showUnlockAnim, arg_40_0)

	if arg_40_0._startBlock then
		arg_40_0:_endBlock()
	end
end

return var_0_0
