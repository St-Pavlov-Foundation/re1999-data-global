module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapEpisodeView", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapEpisodeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochaptercontentitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_content/#go_chaptercontentitem")
	arg_1_0._gomodecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer")
	arg_1_0._btnstorymode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switchmodecontainer/#go_storymode/#btn_storyMode")
	arg_1_0._btnhardmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#btn_hardMode")
	arg_1_0._imgstorymode = gohelper.findChildImage(arg_1_0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon")
	arg_1_0._gostorymodeNormal = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_normal")
	arg_1_0._gostorymodeSelect = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_select")
	arg_1_0._imghardmode = gohelper.findChildImage(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon")
	arg_1_0._gohardmodeNormal = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_normal")
	arg_1_0._gohardmodeSelect = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_select")
	arg_1_0._gohardmodelock = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_locked")
	arg_1_0._hardModeLockTip = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock")
	arg_1_0._txtunlocktime = gohelper.findChildText(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstorymode:AddClickListener(arg_2_0.btnStoryModeClick, arg_2_0)
	arg_2_0._btnhardmode:AddClickListener(arg_2_0.btnHardModeClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstorymode:RemoveClickListener()
	arg_3_0._btnhardmode:RemoveClickListener()
end

function var_0_0.btnStoryModeClick(arg_4_0)
	arg_4_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function var_0_0.btnHardModeClick(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = arg_5_0:checkHardModeIsOpen()

	if not var_5_0 then
		GameFacade.showToast(var_5_1, var_5_2)

		return
	end

	arg_5_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function var_0_0.checkHardModeIsOpen(arg_6_0)
	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function var_0_0.changeEpisodeMode(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0.activityDungeonMo.mode then
		return
	end

	if not arg_7_0.chapterLayout then
		return
	end

	arg_7_0.scrollRect.velocity = Vector2(0, 0)

	if arg_7_1 == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		arg_7_0.excessiveAnimator:Play("story", 0, 0)
	else
		arg_7_0.excessiveAnimator:Play("hard", 0, 0)
	end

	arg_7_0.activityDungeonMo.mode = arg_7_1

	TaskDispatcher.runDelay(arg_7_0.directChangeMode, arg_7_0, 0.41)
end

function var_0_0.directChangeMode(arg_8_0)
	arg_8_0.activityDungeonMo:changeMode(arg_8_0.activityDungeonMo.mode)
end

function var_0_0.dailyRefresh(arg_9_0)
	arg_9_0:refreshModeNode()
	arg_9_0:playUnlockAnimation()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.scrollRect = gohelper.findChild(arg_10_0.viewGO, "#scroll_content"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_10_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_10_0.scrollRect.gameObject, DungeonMapEpisodeAudio, arg_10_0.scrollRect)
	arg_10_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_10_0.scrollRect.gameObject)

	arg_10_0._drag:AddDragBeginListener(arg_10_0._onDragBeginHandler, arg_10_0)
	arg_10_0._drag:AddDragEndListener(arg_10_0._onDragEndHandler, arg_10_0)

	arg_10_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_10_0.scrollRect.gameObject)

	arg_10_0._touch:AddClickDownListener(arg_10_0._onClickDownHandler, arg_10_0)

	arg_10_0.scrollRect:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = 0.5

	gohelper.setActive(arg_10_0._gochaptercontentitem, false)
	gohelper.setActive(arg_10_0._goexcessive, true)

	arg_10_0.excessiveAnimator = arg_10_0._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0.goScrollRect = gohelper.findChild(arg_10_0.viewGO, "#scroll_content")

	recthelper.setAnchorY(arg_10_0.goScrollRect.transform, -240)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_10_0.dailyRefresh, arg_10_0)

	local var_10_0 = arg_10_0:getPlayUnlockAnimationKey()

	arg_10_0.isPlayedModeUnLockAnimation = PlayerPrefsHelper.getNumber(var_10_0, 0) == 1
end

function var_0_0._onDragBeginHandler(arg_11_0)
	arg_11_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_12_0)
	arg_12_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_13_0)
	arg_13_0._audioScroll:onClickDown()
end

function var_0_0.playOnOpenAnimation(arg_14_0)
	arg_14_0.chapterLayout:playAnimation(UIAnimationName.Open)

	if arg_14_0.viewContainer.viewParam.needSelectFocusItem then
		arg_14_0.chapterLayout:setSelectEpisodeId(arg_14_0.activityDungeonMo.episodeId)
	else
		arg_14_0.chapterLayout:playEpisodeItemAnimation("in")
	end
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:refreshModeNode()
	arg_15_0.chapterLayout:refreshEpisodeNodes()
	arg_15_0:playOnOpenAnimation()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_16_0.onModeChange, arg_16_0)
	arg_16_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, arg_16_0.hideUI, arg_16_0)
	arg_16_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, arg_16_0.showUI, arg_16_0)
	arg_16_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_16_0._onUpdateDungeonInfo, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_16_0._onCloseViewFinish, arg_16_0)
	arg_16_0:initChapterEpisodes()
	arg_16_0:refreshModeNode()
end

function var_0_0.initChapterEpisodes(arg_17_0)
	arg_17_0._uiLoader = MultiAbLoader.New()

	arg_17_0._uiLoader:addPath(arg_17_0.activityDungeonMo:getLayoutPrefabUrl())
	arg_17_0._uiLoader:startLoad(arg_17_0.onLoadLayoutFinish, arg_17_0)
end

function var_0_0.onLoadLayoutFinish(arg_18_0)
	local var_18_0 = arg_18_0.activityDungeonMo:getLayoutPrefabUrl()
	local var_18_1 = arg_18_0._uiLoader:getAssetItem(var_18_0):GetResource(var_18_0)

	arg_18_0.goChapterContent = gohelper.cloneInPlace(arg_18_0._gochaptercontentitem, "#go_chaptercontent")

	gohelper.setAsLastSibling(arg_18_0.goChapterContent)
	gohelper.setActive(arg_18_0.goChapterContent, true)

	arg_18_0.scrollRect.content = arg_18_0.goChapterContent.transform
	arg_18_0.scrollRect.velocity = Vector2(0, 0)
	arg_18_0.scrollRect.horizontalNormalizedPosition = 0

	local var_18_2 = gohelper.clone(var_18_1, arg_18_0.goChapterContent)

	arg_18_0.chapterLayout = arg_18_0.activityDungeonMo:getLayoutClass().New()
	arg_18_0.chapterLayout.viewContainer = arg_18_0.viewContainer
	arg_18_0.chapterLayout.activityDungeonMo = arg_18_0.activityDungeonMo

	arg_18_0.chapterLayout:initView(var_18_2, {
		goChapterContent = arg_18_0.goChapterContent
	})
	arg_18_0.chapterLayout:refreshEpisodeNodes()
	arg_18_0:playOnOpenAnimation()
end

function var_0_0.onOpenFinish(arg_19_0)
	arg_19_0:playUnlockAnimation()
end

function var_0_0.refreshModeNode(arg_20_0)
	arg_20_0._imgstorymode.color = arg_20_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story and VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor
	arg_20_0._imghardmode.color = arg_20_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor

	gohelper.setActive(arg_20_0._gostorymodeSelect, arg_20_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_20_0._gostorymodeNormal, arg_20_0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_20_0._gohardmodeSelect, arg_20_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(arg_20_0._gohardmodeNormal, arg_20_0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	arg_20_0:refreshModeLockText()
end

function var_0_0.onModeChange(arg_21_0)
	arg_21_0:refreshModeNode()
	arg_21_0.chapterLayout:playAnimation("switch")
	arg_21_0.chapterLayout:refreshEpisodeNodes()
end

function var_0_0.showUI(arg_22_0)
	gohelper.setActive(arg_22_0._gomodecontainer, true)
	arg_22_0:showLayout()
end

function var_0_0.hideUI(arg_23_0)
	gohelper.setActive(arg_23_0._gomodecontainer, false)
	arg_23_0:hideLayout()
end

function var_0_0.showLayout(arg_24_0)
	if not arg_24_0.chapterLayout then
		return
	end

	arg_24_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_24_0.chapterLayout.viewGO.transform, arg_24_0.chapterLayout.defaultY, 0.2)
end

function var_0_0.hideLayout(arg_25_0)
	if not arg_25_0.chapterLayout then
		return
	end

	arg_25_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_25_0.chapterLayout.viewGO.transform, -260, 0.2)
end

function var_0_0._onUpdateDungeonInfo(arg_26_0)
	if arg_26_0.chapterLayout then
		arg_26_0.chapterLayout:refreshEpisodeNodes()
	end

	arg_26_0:playUnlockAnimation()
end

function var_0_0._onCloseViewFinish(arg_27_0, arg_27_1)
	arg_27_0:playUnlockAnimation()
end

function var_0_0.playUnlockAnimation(arg_28_0)
	if arg_28_0.isPlayedModeUnLockAnimation then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_28_0.viewName) then
		return
	end

	if arg_28_0:needPlayUnLockAnimation() then
		PlayerPrefsHelper.setNumber(arg_28_0:getPlayUnlockAnimationKey(), 1)

		local var_28_0 = gohelper.findChildComponent(arg_28_0.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)

		if var_28_0 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_explore_open)
			var_28_0:Play("unlock", 0, 0)
			TaskDispatcher.runDelay(arg_28_0.unlockAnimDone, arg_28_0, VersionActivity1_5DungeonEnum.HardModeUnlockAnimDuration)
		end
	end
end

function var_0_0.unlockAnimDone(arg_29_0)
	local var_29_0 = gohelper.findChildComponent(arg_29_0.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)
	local var_29_1 = gohelper.findChild(arg_29_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#unlock")

	var_29_0.enabled = false

	gohelper.setActive(var_29_1, false)
	arg_29_0:refreshModeLockText()
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function var_0_0.needPlayUnLockAnimation(arg_30_0)
	if PlayerPrefsHelper.getNumber(arg_30_0:getPlayUnlockAnimationKey(), 0) == 1 then
		return false
	end

	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_5Enum.ActivityId.Dungeon) then
		return false
	end

	return true
end

function var_0_0.getPlayUnlockAnimationKey(arg_31_0)
	return PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_5EnterController.GetActivityPrefsKey(PlayerPrefsKey.LeiMiTeBeiPlayHardModeUnlockAnimationKey))
end

function var_0_0.refreshModeLockText(arg_32_0)
	local var_32_0 = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_5DungeonEnum.DungeonChapterId.Hard)
	local var_32_1 = ServerTime.now()

	if var_32_1 < var_32_0 then
		local var_32_2 = var_32_0 - var_32_1
		local var_32_3 = Mathf.Floor(var_32_2 / TimeUtil.OneDaySecond)
		local var_32_4 = var_32_2 % TimeUtil.OneDaySecond
		local var_32_5 = Mathf.Floor(var_32_4 / TimeUtil.OneHourSecond)
		local var_32_6 = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.Dungeon]

		if var_32_3 > 0 then
			local var_32_7

			if LangSettings.instance:isEn() then
				var_32_7 = string.format("%s%s %s%s", var_32_3, luaLang("time_day"), var_32_5, luaLang("time_hour2"))
			else
				var_32_7 = string.format("%s%s%s%s", var_32_3, luaLang("time_day"), var_32_5, luaLang("time_hour2"))
			end

			arg_32_0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_32_7)
		else
			arg_32_0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_32_6:getRemainTimeStr2(var_32_2))
		end

		gohelper.setActive(arg_32_0._gohardmodelock, true)
		gohelper.setActive(arg_32_0._hardModeLockTip, true)

		return
	end

	local var_32_8, var_32_9 = DungeonModel.instance:chapterIsUnLock(arg_32_0.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not var_32_8 then
		local var_32_10 = DungeonConfig.instance:getEpisodeCO(var_32_9)

		arg_32_0._txtunlocktime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "RUG-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_32_10.chapterId, var_32_9))

		gohelper.setActive(arg_32_0._gohardmodelock, true)
		gohelper.setActive(arg_32_0._hardModeLockTip, true)

		return
	end

	gohelper.setActive(arg_32_0._gohardmodelock, false)
	gohelper.setActive(arg_32_0._hardModeLockTip, false)
end

function var_0_0.onClose(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0.directChangeMode, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0.unlockAnimDone, arg_33_0)
end

function var_0_0.onDestroyView(arg_34_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_34_0.dailyRefresh, arg_34_0)

	if arg_34_0._uiLoader then
		arg_34_0._uiLoader:dispose()
	end

	if arg_34_0.chapterLayout then
		arg_34_0.chapterLayout:destroyView()

		arg_34_0.chapterLayout = nil
	end

	if arg_34_0._audioScroll then
		arg_34_0._audioScroll:dispose()

		arg_34_0._audioScroll = nil
	end

	if arg_34_0._drag then
		arg_34_0._drag:RemoveDragBeginListener()
		arg_34_0._drag:RemoveDragEndListener()

		arg_34_0._drag = nil
	end

	if arg_34_0._touch then
		arg_34_0._touch:RemoveClickDownListener()

		arg_34_0._touch = nil
	end

	if arg_34_0._episodeListTweenId then
		ZProj.TweenHelper.KillById(arg_34_0._episodeListTweenId)
	end
end

return var_0_0
