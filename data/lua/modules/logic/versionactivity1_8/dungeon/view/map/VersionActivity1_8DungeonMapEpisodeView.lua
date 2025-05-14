module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapEpisodeView", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapEpisodeView", BaseView)
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
	arg_1_0._hardModeLockTip = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock")
	arg_1_0._txtHardModeUnlockTime = gohelper.findChildText(arg_1_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")
	arg_1_0.excessiveAnimator = arg_1_0._goexcessive:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_2_0.onModeChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_2_0.hideUI, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, arg_2_0.showUI, arg_2_0)
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
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_3_0.hideUI, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, arg_3_0.showUI, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_3_0._onUpdateDungeonInfo, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.dailyRefresh, arg_3_0)
	arg_3_0._btnstorymode:RemoveClickListener()
	arg_3_0._btnhardmode:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._touch:RemoveClickDownListener()
end

function var_0_0.onModeChange(arg_4_0)
	arg_4_0:refreshModeNode()
	arg_4_0.chapterLayout:playAnimation("switch")
	arg_4_0.chapterLayout:refreshEpisodeNodes()

	if arg_4_0._changeModeCallback then
		arg_4_0._changeModeCallback(arg_4_0)

		arg_4_0._changeModeCallback = nil
	end
end

function var_0_0.showUI(arg_5_0)
	arg_5_0:setLayoutVisible(true)
end

function var_0_0.hideUI(arg_6_0)
	arg_6_0:setLayoutVisible(false)
end

function var_0_0.setLayoutVisible(arg_7_0, arg_7_1)
	if not arg_7_0.chapterLayout then
		return
	end

	if arg_7_0._episodeListTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._episodeListTweenId)

		arg_7_0._episodeListTweenId = nil
	end

	local var_7_0 = arg_7_0.chapterLayout.viewGO.transform
	local var_7_1 = var_0_8

	if arg_7_1 then
		var_7_1 = arg_7_0.chapterLayout.defaultY
	end

	arg_7_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(var_7_0, var_7_1, var_0_7)
end

function var_0_0._onUpdateDungeonInfo(arg_8_0)
	if arg_8_0.chapterLayout then
		arg_8_0.chapterLayout:refreshEpisodeNodes()
	end

	arg_8_0:refreshModeNode()
	arg_8_0:playUnlockAnimation()
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0.viewName then
		return
	end

	arg_9_0:playUnlockAnimation()
end

function var_0_0.dailyRefresh(arg_10_0)
	arg_10_0:refreshModeNode()
	arg_10_0:playUnlockAnimation()
end

function var_0_0.btnStoryModeClick(arg_11_0)
	arg_11_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function var_0_0.btnHardModeClick(arg_12_0)
	local var_12_0, var_12_1, var_12_2 = arg_12_0:checkHardModeIsOpen()

	if not var_12_0 then
		GameFacade.showToast(var_12_1, var_12_2)

		return
	end

	arg_12_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function var_0_0.checkHardModeIsOpen(arg_13_0)
	local var_13_0 = VersionActivity1_8Enum.ActivityId.Dungeon

	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(var_13_0)
end

function var_0_0.changeEpisodeMode(arg_14_0, arg_14_1)
	if not arg_14_0.chapterLayout or arg_14_1 == arg_14_0.activityDungeonMo.mode then
		return
	end

	arg_14_0.scrollRect.velocity = Vector2(0, 0)

	if arg_14_1 == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		arg_14_0.excessiveAnimator:Play("story")
	else
		arg_14_0.excessiveAnimator:Play("hard")
	end

	arg_14_0.activityDungeonMo.mode = arg_14_1

	TaskDispatcher.runDelay(arg_14_0.directChangeMode, arg_14_0, var_0_3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
end

function var_0_0.directChangeMode(arg_15_0)
	arg_15_0.activityDungeonMo:changeMode(arg_15_0.activityDungeonMo.mode)
end

function var_0_0._onDragBeginHandler(arg_16_0)
	arg_16_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_17_0)
	arg_17_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_18_0)
	arg_18_0._audioScroll:onClickDown()
end

function var_0_0._editableInitView(arg_19_0)
	gohelper.setActive(arg_19_0._gochaptercontentitem, false)
	gohelper.setActive(arg_19_0._goexcessive, true)
	recthelper.setAnchorY(arg_19_0.goScrollRect.transform, var_0_2)

	arg_19_0.scrollRect:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = var_0_1
	arg_19_0._changeModeCallback = nil
end

function var_0_0.onUpdateParam(arg_20_0)
	arg_20_0:refreshModeNode()
	arg_20_0.chapterLayout:refreshEpisodeNodes()
	arg_20_0:playOnOpenAnimation()
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:initChapterEpisodes()
	arg_21_0:refreshModeNode()
	TaskDispatcher.runRepeat(arg_21_0.refreshModeLockText, arg_21_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.initChapterEpisodes(arg_22_0)
	arg_22_0._uiLoader = MultiAbLoader.New()

	local var_22_0 = arg_22_0.activityDungeonMo:getLayoutPrefabUrl()

	arg_22_0._uiLoader:addPath(var_22_0)
	arg_22_0._uiLoader:startLoad(arg_22_0.onLoadLayoutFinish, arg_22_0)
end

function var_0_0.onLoadLayoutFinish(arg_23_0)
	arg_23_0.goChapterContent = gohelper.cloneInPlace(arg_23_0._gochaptercontentitem, "#go_chaptercontent")

	gohelper.setAsLastSibling(arg_23_0.goChapterContent)
	gohelper.setActive(arg_23_0.goChapterContent, true)

	arg_23_0.scrollRect.content = arg_23_0.goChapterContent.transform
	arg_23_0.scrollRect.velocity = Vector2(0, 0)
	arg_23_0.scrollRect.horizontalNormalizedPosition = 0

	local var_23_0 = arg_23_0.activityDungeonMo:getLayoutPrefabUrl()
	local var_23_1 = arg_23_0._uiLoader:getAssetItem(var_23_0):GetResource(var_23_0)
	local var_23_2 = gohelper.clone(var_23_1, arg_23_0.goChapterContent)

	arg_23_0.chapterLayout = arg_23_0.activityDungeonMo:getLayoutClass().New()
	arg_23_0.chapterLayout.viewContainer = arg_23_0.viewContainer
	arg_23_0.chapterLayout.activityDungeonMo = arg_23_0.activityDungeonMo

	arg_23_0.chapterLayout:initView(var_23_2, {
		goChapterContent = arg_23_0.goChapterContent
	})
	arg_23_0.chapterLayout:refreshEpisodeNodes()
	arg_23_0:playOnOpenAnimation()
end

function var_0_0.refreshModeNode(arg_24_0)
	local var_24_0 = arg_24_0.activityDungeonMo.mode
	local var_24_1 = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local var_24_2 = VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(arg_24_0._gostorymodeSelect, var_24_0 == var_24_1)
	gohelper.setActive(arg_24_0._gostorymodeNormal, var_24_0 ~= var_24_1)
	gohelper.setActive(arg_24_0._gohardmodeSelect, var_24_0 == var_24_2)
	gohelper.setActive(arg_24_0._gohardmodeNormal, var_24_0 ~= var_24_2)
	arg_24_0:refreshModeLockText()
end

function var_0_0.refreshModeLockText(arg_25_0)
	local var_25_0 = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_8DungeonEnum.DungeonChapterId.Hard)
	local var_25_1 = ServerTime.now()

	if var_25_1 < var_25_0 then
		local var_25_2 = var_25_0 - var_25_1
		local var_25_3 = Mathf.Floor(var_25_2 / TimeUtil.OneDaySecond)
		local var_25_4 = var_25_2 % TimeUtil.OneDaySecond
		local var_25_5 = Mathf.Floor(var_25_4 / TimeUtil.OneHourSecond)
		local var_25_6 = ActivityModel.instance:getActivityInfo()[VersionActivity1_8Enum.ActivityId.Dungeon]

		if var_25_3 > 0 then
			local var_25_7 = var_25_6:getRemainTimeStr2(var_25_2)

			if var_25_5 > 0 then
				var_25_7 = GameUtil.getSubPlaceholderLuaLang(luaLang("hournum"), {
					var_25_7,
					var_25_5
				})
			end

			arg_25_0._txtHardModeUnlockTime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_25_7)
		else
			arg_25_0._txtHardModeUnlockTime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_25_6:getRemainTimeStr4(var_25_2))
		end

		gohelper.setActive(arg_25_0._hardModeLockTip, true)
	else
		local var_25_8, var_25_9 = DungeonModel.instance:chapterIsUnLock(arg_25_0.activityDungeonMo.activityDungeonConfig.hardChapterId)

		if var_25_8 then
			gohelper.setActive(arg_25_0._hardModeLockTip, false)
		else
			local var_25_10 = DungeonConfig.instance:getEpisodeCO(var_25_9)
			local var_25_11 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_25_10.chapterId, var_25_9)

			arg_25_0._txtHardModeUnlockTime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "FR-" .. var_25_11)

			gohelper.setActive(arg_25_0._hardModeLockTip, true)
		end
	end
end

function var_0_0.onOpenFinish(arg_26_0)
	arg_26_0:playUnlockAnimation(true)
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

	if arg_28_0:IsNeedPlayHardModeUnlockAnimation() then
		local var_28_0 = VersionActivity1_8DungeonEnum.PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim

		VersionActivity1_8DungeonController.instance:savePlayerPrefs(var_28_0, var_0_6)

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

function var_0_0.IsNeedPlayHardModeUnlockAnimation(arg_29_0)
	local var_29_0 = false
	local var_29_1 = VersionActivity1_8DungeonEnum.PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim

	if VersionActivity1_8DungeonController.instance:getPlayerPrefs(var_29_1, var_0_5) ~= var_0_6 then
		local var_29_2 = VersionActivity1_8Enum.ActivityId.Dungeon

		if VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_29_2) then
			var_29_0 = true
		end
	end

	return var_29_0
end

function var_0_0._unlockAniDone(arg_30_0)
	local var_30_0 = VersionActivity1_8Enum.ActivityId.Dungeon

	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_30_0) then
		return
	end

	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function var_0_0.onDestroyView(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.refreshModeLockText, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.directChangeMode, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._unlockAniDone, arg_31_0)

	if arg_31_0._uiLoader then
		arg_31_0._uiLoader:dispose()
	end

	if arg_31_0.chapterLayout then
		arg_31_0.chapterLayout:destroyView()

		arg_31_0.chapterLayout = nil
	end

	if arg_31_0._audioScroll then
		arg_31_0._audioScroll:dispose()

		arg_31_0._audioScroll = nil
	end

	if arg_31_0._episodeListTweenId then
		ZProj.TweenHelper.KillById(arg_31_0._episodeListTweenId)
	end
end

return var_0_0
