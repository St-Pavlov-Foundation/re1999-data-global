module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapEpisodeView", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonMapEpisodeView", BaseView)
local var_0_1 = 0.5
local var_0_2 = -240
local var_0_3 = 0.41
local var_0_4 = 1.7
local var_0_5 = 0
local var_0_6 = 1
local var_0_7 = 0.2
local var_0_8 = -260

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goScrollRect = gohelper.findChild(arg_1_0.viewGO, "#scroll_content")
	arg_1_0.scrollRect = gohelper.findChild(arg_1_0.viewGO, "#scroll_content"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_1_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_1_0.scrollRect.gameObject, DungeonMapEpisodeAudio, arg_1_0.scrollRect)
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0.scrollRect.gameObject)
	arg_1_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_1_0.scrollRect.gameObject)
	arg_1_0._gochaptercontentitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_content/#go_chaptercontentitem")
	arg_1_0._btnstorymode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switchmodecontainer/#go_storymode/#btn_storyMode")
	arg_1_0._gostorymodeNormal = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_normal")
	arg_1_0._gostorymodeSelect = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_select")
	arg_1_0._hardModeBtnAnimator = gohelper.findChildComponent(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)
	arg_1_0._btnhardmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#btn_hardMode")
	arg_1_0._gohardmodeNormal = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_normal")
	arg_1_0._gohardmodeSelect = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_select")
	arg_1_0._gohardmodelock = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_locked")
	arg_1_0._hardModeLockTip = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock")
	arg_1_0._hardModeCurrency = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeUnLock")
	arg_1_0._hardModeUnlockvx = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/#go_hardModeUnLock")
	arg_1_0._txthardModeCurrency = gohelper.findChildText(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeUnLock/#txt_num")
	arg_1_0._txtHardModeUnlockTime = gohelper.findChildText(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")
	arg_1_0.excessiveAnimator = arg_1_0._goexcessive:GetComponent(gohelper.Type_Animator)
	arg_1_0._cghardModeCurrency = arg_1_0._hardModeCurrency:GetComponent(typeof(UnityEngine.CanvasGroup))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_2_0.onModeChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, arg_2_0.hideUI, arg_2_0)
	arg_2_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, arg_2_0.showUI, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_2_0._onUpdateDungeonInfo, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.dailyRefresh, arg_2_0)
	arg_2_0._btnstorymode:AddClickListener(arg_2_0.btnStoryModeClick, arg_2_0)
	arg_2_0._btnhardmode:AddClickListener(arg_2_0.btnHardModeClick, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBeginHandler, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEndHandler, arg_2_0)
	arg_2_0._touch:AddClickDownListener(arg_2_0._onClickDownHandler, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_3_0.onModeChange, arg_3_0)

	local var_3_0 = VersionActivityFixedHelper.getVersionActivityDungeonController(arg_3_0._bigVersion, arg_3_0._smallVersion)

	arg_3_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, arg_3_0.hideUI, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, arg_3_0.showUI, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_3_0._onUpdateDungeonInfo, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.dailyRefresh, arg_3_0)
	arg_3_0._btnstorymode:RemoveClickListener()
	arg_3_0._btnhardmode:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._touch:RemoveClickDownListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._bigVersion, arg_4_0._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	gohelper.setActive(arg_4_0._gochaptercontentitem, false)
	gohelper.setActive(arg_4_0._goexcessive, true)
	recthelper.setAnchorY(arg_4_0.goScrollRect.transform, var_0_2)

	arg_4_0.scrollRect:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = var_0_1
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:refreshModeNode()
	arg_5_0.chapterLayout:refreshEpisodeNodes()
	arg_5_0:playOnOpenAnimation()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:initChapterEpisodes()
	arg_6_0:refreshModeNode()
	TaskDispatcher.runRepeat(arg_6_0.refreshModeLockText, arg_6_0, TimeUtil.OneMinuteSecond)
	arg_6_0:_refreshHardModeVx()
end

function var_0_0.onOpenFinish(arg_7_0)
	arg_7_0:playUnlockAnimation(true)
end

function var_0_0.refreshModeNode(arg_8_0)
	local var_8_0 = arg_8_0.activityDungeonMo.mode
	local var_8_1 = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local var_8_2 = VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(arg_8_0._gostorymodeSelect, var_8_0 == var_8_1)
	gohelper.setActive(arg_8_0._gostorymodeNormal, var_8_0 ~= var_8_1)
	gohelper.setActive(arg_8_0._gohardmodeSelect, var_8_0 == var_8_2)
	gohelper.setActive(arg_8_0._gohardmodeNormal, var_8_0 ~= var_8_2)
	arg_8_0:refreshModeLockText()

	if var_8_2 then
		arg_8_0:_refreshHardModeVx()
	end
end

function var_0_0.initChapterEpisodes(arg_9_0)
	arg_9_0._uiLoader = MultiAbLoader.New()

	local var_9_0 = arg_9_0.activityDungeonMo:getLayoutPrefabUrl()

	arg_9_0._uiLoader:addPath(var_9_0)
	arg_9_0._uiLoader:startLoad(arg_9_0.onLoadLayoutFinish, arg_9_0)
end

function var_0_0.onLoadLayoutFinish(arg_10_0)
	arg_10_0.goChapterContent = gohelper.cloneInPlace(arg_10_0._gochaptercontentitem, "#go_chaptercontent")

	gohelper.setAsLastSibling(arg_10_0.goChapterContent)
	gohelper.setActive(arg_10_0.goChapterContent, true)

	arg_10_0.scrollRect.content = arg_10_0.goChapterContent.transform
	arg_10_0.scrollRect.velocity = Vector2(0, 0)
	arg_10_0.scrollRect.horizontalNormalizedPosition = 0

	local var_10_0 = arg_10_0.activityDungeonMo:getLayoutPrefabUrl()
	local var_10_1 = arg_10_0._uiLoader:getAssetItem(var_10_0):GetResource(var_10_0)
	local var_10_2 = gohelper.clone(var_10_1, arg_10_0.goChapterContent)

	arg_10_0.chapterLayout = arg_10_0.activityDungeonMo:getLayoutClass().New()
	arg_10_0.chapterLayout.viewContainer = arg_10_0.viewContainer
	arg_10_0.chapterLayout.activityDungeonMo = arg_10_0.activityDungeonMo

	arg_10_0.chapterLayout:initView(var_10_2, {
		goChapterContent = arg_10_0.goChapterContent
	})
	arg_10_0.chapterLayout:refreshEpisodeNodes()
	arg_10_0:playOnOpenAnimation()
end

function var_0_0.refreshModeLockText(arg_11_0)
	local var_11_0 = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivityFixedHelper.getVersionActivityDungeonEnum(arg_11_0._bigVersion, arg_11_0._smallVersion).DungeonChapterId.Hard)
	local var_11_1 = ServerTime.now()
	local var_11_2 = false

	if var_11_1 < var_11_0 then
		local var_11_3 = var_11_0 - var_11_1
		local var_11_4 = Mathf.Floor(var_11_3 / TimeUtil.OneDaySecond)
		local var_11_5 = var_11_3 % TimeUtil.OneDaySecond
		local var_11_6 = Mathf.Floor(var_11_5 / TimeUtil.OneHourSecond)
		local var_11_7 = ActivityModel.instance:getActivityInfo()[VersionActivityFixedHelper.getVersionActivityEnum(arg_11_0._bigVersion, arg_11_0._smallVersion).ActivityId.Dungeon]

		if var_11_4 > 0 then
			local var_11_8 = var_11_7:getRemainTimeStr2(var_11_3)

			if var_11_6 > 0 then
				var_11_8 = GameUtil.getSubPlaceholderLuaLang(luaLang("hournum"), {
					var_11_8,
					var_11_6
				})
			end

			arg_11_0._txtHardModeUnlockTime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_11_8)
		else
			arg_11_0._txtHardModeUnlockTime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_11_7:getRemainTimeStr4(var_11_3))
		end

		gohelper.setActive(arg_11_0._hardModeLockTip, true)
		gohelper.setActive(arg_11_0._gohardmodelock, true)
	else
		local var_11_9, var_11_10 = DungeonModel.instance:chapterIsUnLock(arg_11_0.activityDungeonMo.activityDungeonConfig.hardChapterId)

		if var_11_9 then
			gohelper.setActive(arg_11_0._hardModeLockTip, false)
			gohelper.setActive(arg_11_0._gohardmodelock, false)

			var_11_2 = true
		else
			local var_11_11 = DungeonConfig.instance:getEpisodeCO(var_11_10)
			local var_11_12 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_11_11.chapterId, var_11_10)
			local var_11_13 = DungeonConfig.instance:getChapterCO(var_11_11.chapterId).chapterIndex

			arg_11_0._txtHardModeUnlockTime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), var_11_13 .. "-" .. var_11_12)

			gohelper.setActive(arg_11_0._hardModeLockTip, true)
			gohelper.setActive(arg_11_0._gohardmodelock, true)
		end
	end

	arg_11_0:_refreshHardModeCurrency(var_11_2)
end

function var_0_0.onModeChange(arg_12_0)
	arg_12_0:refreshModeNode()
	arg_12_0.chapterLayout:playAnimation("switch")
	arg_12_0.chapterLayout:refreshEpisodeNodes()
end

function var_0_0.showUI(arg_13_0)
	arg_13_0:setLayoutVisible(true)
end

function var_0_0.hideUI(arg_14_0)
	arg_14_0:setLayoutVisible(false)
end

function var_0_0.setLayoutVisible(arg_15_0, arg_15_1)
	if not arg_15_0.chapterLayout then
		return
	end

	if arg_15_0._episodeListTweenId then
		ZProj.TweenHelper.KillById(arg_15_0._episodeListTweenId)

		arg_15_0._episodeListTweenId = nil
	end

	local var_15_0 = arg_15_0.chapterLayout.viewGO.transform
	local var_15_1 = var_0_8

	if arg_15_1 then
		var_15_1 = arg_15_0.chapterLayout.defaultY
	end

	arg_15_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(var_15_0, var_15_1, var_0_7)
end

function var_0_0._onUpdateDungeonInfo(arg_16_0)
	if arg_16_0.chapterLayout then
		arg_16_0.chapterLayout:refreshEpisodeNodes()
	end

	arg_16_0:refreshModeNode()
	arg_16_0:playUnlockAnimation()
end

function var_0_0._onCloseViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0.viewName then
		return
	end

	arg_17_0:playUnlockAnimation()
end

function var_0_0.dailyRefresh(arg_18_0)
	arg_18_0:refreshModeNode()
	arg_18_0:playUnlockAnimation()
end

function var_0_0.btnStoryModeClick(arg_19_0)
	arg_19_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function var_0_0.btnHardModeClick(arg_20_0)
	local var_20_0, var_20_1, var_20_2 = arg_20_0:checkHardModeIsOpen()

	if not var_20_0 then
		GameFacade.showToast(var_20_1, var_20_2)

		return
	end

	arg_20_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	VersionActivityFixedDungeonModel.instance:setTipHardModeUnlockOpen()
end

function var_0_0.checkHardModeIsOpen(arg_21_0)
	local var_21_0 = VersionActivityFixedHelper.getVersionActivityEnum(arg_21_0._bigVersion, arg_21_0._smallVersion).ActivityId.Dungeon

	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(var_21_0)
end

function var_0_0.changeEpisodeMode(arg_22_0, arg_22_1)
	if not arg_22_0.chapterLayout or arg_22_1 == arg_22_0.activityDungeonMo.mode then
		return
	end

	arg_22_0.scrollRect.velocity = Vector2(0, 0)

	if arg_22_1 == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		arg_22_0.excessiveAnimator:Play("story")
	else
		arg_22_0.excessiveAnimator:Play("hard")
	end

	arg_22_0.activityDungeonMo.mode = arg_22_1

	TaskDispatcher.runDelay(arg_22_0.directChangeMode, arg_22_0, var_0_3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
end

function var_0_0.directChangeMode(arg_23_0)
	arg_23_0.activityDungeonMo:changeMode(arg_23_0.activityDungeonMo.mode)
end

function var_0_0._onDragBeginHandler(arg_24_0)
	arg_24_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_25_0)
	arg_25_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_26_0)
	arg_26_0._audioScroll:onClickDown()
end

function var_0_0.playOnOpenAnimation(arg_27_0)
	arg_27_0.chapterLayout:playAnimation(UIAnimationName.Open)

	if arg_27_0.viewContainer.viewParam.needSelectFocusItem then
		arg_27_0.chapterLayout:setSelectEpisodeId(arg_27_0.activityDungeonMo.episodeId)
	else
		arg_27_0.chapterLayout:playEpisodeItemAnimation("in")
	end
end

function var_0_0.playUnlockAnimation(arg_28_0, arg_28_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_28_0.viewName) then
		return
	end

	if VersionActivityFixedDungeonModel.instance:isNeedPlayHardModeUnlockAnimation() then
		VersionActivityFixedDungeonModel.instance:savePlayerPrefsPlayHardModeUnlockAnimation()

		if arg_28_0._hardModeBtnAnimator then
			arg_28_0._hardModeBtnAnimator:Play(UIAnimationName.Unlock, 0, 0)
			TaskDispatcher.runDelay(arg_28_0._unlockAniDone, arg_28_0, var_0_4)

			return
		end
	end

	if arg_28_1 then
		arg_28_0:_unlockAniDone()
	end
end

function var_0_0._refreshHardModeCurrency(arg_29_0, arg_29_1)
	local var_29_0, var_29_1 = VersionActivityFixedDungeonModel.instance:getHardModeCurrenyNum(arg_29_0.activityDungeonMo.activityDungeonConfig.hardChapterId)
	local var_29_2 = luaLang("activitymap_hardmode_reward_count")

	arg_29_0._txthardModeCurrency.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_29_2, var_29_0, var_29_1)

	gohelper.setActive(arg_29_0._hardModeCurrency, arg_29_1)

	local var_29_3 = arg_29_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and 1 or 0.5

	arg_29_0._cghardModeCurrency.alpha = var_29_3
end

function var_0_0._refreshHardModeVx(arg_30_0)
	local var_30_0 = VersionActivityFixedHelper.getVersionActivityEnum(arg_30_0._bigVersion, arg_30_0._smallVersion).ActivityId.Dungeon
	local var_30_1 = VersionActivityFixedDungeonModel.instance:isTipHardModeUnlockOpen(var_30_0)

	gohelper.setActive(arg_30_0._hardModeUnlockvx, var_30_1)

	if var_30_1 then
		VersionActivityFixedDungeonModel.instance:refreshVersionActivityEnterRedDot()
	end
end

function var_0_0._unlockAniDone(arg_31_0)
	local var_31_0 = VersionActivityFixedHelper.getVersionActivityEnum(arg_31_0._bigVersion, arg_31_0._smallVersion).ActivityId.Dungeon

	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_31_0) then
		return
	end

	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function var_0_0.onDestroyView(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.refreshModeLockText, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.directChangeMode, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._unlockAniDone, arg_32_0)

	if arg_32_0._uiLoader then
		arg_32_0._uiLoader:dispose()
	end

	if arg_32_0.chapterLayout then
		arg_32_0.chapterLayout:destroyView()

		arg_32_0.chapterLayout = nil
	end

	if arg_32_0._audioScroll then
		arg_32_0._audioScroll:dispose()

		arg_32_0._audioScroll = nil
	end

	if arg_32_0._episodeListTweenId then
		ZProj.TweenHelper.KillById(arg_32_0._episodeListTweenId)
	end
end

return var_0_0
