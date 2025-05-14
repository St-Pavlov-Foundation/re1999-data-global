module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapEpisodeView", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonMapEpisodeView", BaseView)
local var_0_1 = VersionActivity1_6Enum.ActivityId.Dungeon .. "UnlockHardModeBtnAnim"

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
	arg_1_0._bossBtnLockTip = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_bossmode/#go_bossModeLock")
	arg_1_0._btnBoss = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switchmodecontainer/#go_bossmode/#btn_hardMode")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstorymode:AddClickListener(arg_2_0.btnStoryModeClick, arg_2_0)
	arg_2_0._btnhardmode:AddClickListener(arg_2_0.btnHardModeClick, arg_2_0)
	arg_2_0._btnBoss:AddClickListener(arg_2_0._btnDungeonBossClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstorymode:RemoveClickListener()
	arg_3_0._btnhardmode:RemoveClickListener()
	arg_3_0._btnBoss:RemoveClickListener()
end

function var_0_0._onDragBeginHandler(arg_4_0)
	arg_4_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_5_0)
	arg_5_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_6_0)
	arg_6_0._audioScroll:onClickDown()
end

function var_0_0.btnStoryModeClick(arg_7_0)
	arg_7_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function var_0_0.btnHardModeClick(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = arg_8_0:checkHardModeIsOpen()

	if not var_8_0 then
		GameFacade.showToast(var_8_1, var_8_2)

		return
	end

	arg_8_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function var_0_0._btnDungeonBossClick(arg_9_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102) then
		local var_9_0, var_9_1 = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Act_60102)

		GameFacade.showToastWithTableParam(var_9_0, var_9_1)

		return
	end

	if arg_9_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		if arg_9_0.activityDungeonMo.episodeId == VersionActivity1_6DungeonEnum.DungeonBossEpisodeId then
			arg_9_0:_forceToBossElement()
		else
			arg_9_0:_forceToBossEpisode()
		end
	else
		arg_9_0._changeModeCallback = arg_9_0._forceToBossEpisode

		arg_9_0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
	end
end

function var_0_0._forceToBossEpisode(arg_10_0)
	arg_10_0.activityDungeonMo:changeEpisode(VersionActivity1_6DungeonEnum.DungeonBossEpisodeId)
	arg_10_0.chapterLayout:setSelectEpisodeId(VersionActivity1_6DungeonEnum.DungeonBossEpisodeId, true)
	arg_10_0:markSelectBossEpisode()
end

function var_0_0._forceToBossElement(arg_11_0)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.FocusElement, VersionActivity1_6DungeonEnum.DungeonBossMapElementId)
end

function var_0_0.markSelectBossEpisode(arg_12_0)
	VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(VersionActivity1_6DungeonEnum.DungeonChapterId.Story, VersionActivity1_6DungeonEnum.DungeonBossEpisodeId)
end

function var_0_0.checkHardModeIsOpen(arg_13_0)
	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(VersionActivity1_6Enum.ActivityId.Dungeon)
end

function var_0_0.changeEpisodeMode(arg_14_0, arg_14_1)
	if arg_14_1 == arg_14_0.activityDungeonMo.mode then
		return
	end

	if not arg_14_0.chapterLayout then
		return
	end

	arg_14_0.scrollRect.velocity = Vector2(0, 0)

	if arg_14_1 == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		arg_14_0.excessiveAnimator:Play("story")
	else
		arg_14_0.excessiveAnimator:Play("hard")
	end

	arg_14_0.activityDungeonMo.mode = arg_14_1

	TaskDispatcher.runDelay(arg_14_0.directChangeMode, arg_14_0, 0.41)
end

function var_0_0.directChangeMode(arg_15_0)
	arg_15_0.activityDungeonMo:changeMode(arg_15_0.activityDungeonMo.mode)
end

function var_0_0.dailyRefresh(arg_16_0)
	arg_16_0:refreshModeNode()
	arg_16_0:playUnlockAnimation()
end

function var_0_0._editableInitView(arg_17_0)
	arg_17_0.scrollRect = gohelper.findChild(arg_17_0.viewGO, "#scroll_content"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_17_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_17_0.scrollRect.gameObject, DungeonMapEpisodeAudio, arg_17_0.scrollRect)
	arg_17_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_17_0.scrollRect.gameObject)

	arg_17_0._drag:AddDragBeginListener(arg_17_0._onDragBeginHandler, arg_17_0)
	arg_17_0._drag:AddDragEndListener(arg_17_0._onDragEndHandler, arg_17_0)

	arg_17_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_17_0.scrollRect.gameObject)

	arg_17_0._touch:AddClickDownListener(arg_17_0._onClickDownHandler, arg_17_0)

	arg_17_0.scrollRect:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = 0.5

	gohelper.setActive(arg_17_0._gochaptercontentitem, false)
	gohelper.setActive(arg_17_0._bossBtnLockTip, false)
	gohelper.setActive(arg_17_0._goexcessive, true)

	arg_17_0.excessiveAnimator = arg_17_0._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	arg_17_0.goScrollRect = gohelper.findChild(arg_17_0.viewGO, "#scroll_content")

	recthelper.setAnchorY(arg_17_0.goScrollRect.transform, -240)

	arg_17_0._changeModeCallback = nil

	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_17_0.dailyRefresh, arg_17_0)
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0:refreshModeNode()
	arg_18_0.chapterLayout:refreshEpisodeNodes()
	arg_18_0:playOnOpenAnimation()
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_19_0.onModeChange, arg_19_0)
	arg_19_0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.OnClickElement, arg_19_0.onClickElement, arg_19_0)
	arg_19_0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.OnHideInteractUI, arg_19_0.showUI, arg_19_0)
	arg_19_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_19_0._onUpdateDungeonInfo, arg_19_0)
	arg_19_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_19_0.onFunUnlockRefreshUI, arg_19_0)
	arg_19_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_19_0._onCloseViewFinish, arg_19_0)
	arg_19_0:initChapterEpisodes()
	arg_19_0:refreshModeNode()
end

function var_0_0.onOpenFinish(arg_20_0)
	arg_20_0:playUnlockAnimation(true)
end

function var_0_0.onDestroyView(arg_21_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_21_0.dailyRefresh, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._unlockAniDone, arg_21_0)

	if arg_21_0._uiLoader then
		arg_21_0._uiLoader:dispose()
	end

	if arg_21_0.chapterLayout then
		arg_21_0.chapterLayout:destroyView()

		arg_21_0.chapterLayout = nil
	end

	if arg_21_0._audioScroll then
		arg_21_0._audioScroll:dispose()

		arg_21_0._audioScroll = nil
	end

	if arg_21_0._drag then
		arg_21_0._drag:RemoveDragBeginListener()
		arg_21_0._drag:RemoveDragEndListener()

		arg_21_0._drag = nil
	end

	if arg_21_0._touch then
		arg_21_0._touch:RemoveClickDownListener()

		arg_21_0._touch = nil
	end

	if arg_21_0._episodeListTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._episodeListTweenId)
	end
end

function var_0_0.initChapterEpisodes(arg_22_0)
	arg_22_0._uiLoader = MultiAbLoader.New()

	arg_22_0._uiLoader:addPath(arg_22_0.activityDungeonMo:getLayoutPrefabUrl())
	arg_22_0._uiLoader:startLoad(arg_22_0.onLoadLayoutFinish, arg_22_0)
end

function var_0_0.onLoadLayoutFinish(arg_23_0)
	local var_23_0 = arg_23_0.activityDungeonMo:getLayoutPrefabUrl()
	local var_23_1 = arg_23_0._uiLoader:getAssetItem(var_23_0):GetResource(var_23_0)

	arg_23_0.goChapterContent = gohelper.cloneInPlace(arg_23_0._gochaptercontentitem, "#go_chaptercontent")

	gohelper.setAsLastSibling(arg_23_0.goChapterContent)
	gohelper.setActive(arg_23_0.goChapterContent, true)

	arg_23_0.scrollRect.content = arg_23_0.goChapterContent.transform
	arg_23_0.scrollRect.velocity = Vector2(0, 0)
	arg_23_0.scrollRect.horizontalNormalizedPosition = 0

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
	arg_24_0._imgstorymode.color = arg_24_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story and VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor
	arg_24_0._imghardmode.color = arg_24_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor

	gohelper.setActive(arg_24_0._gostorymodeSelect, arg_24_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_24_0._gostorymodeNormal, arg_24_0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_24_0._gohardmodeSelect, arg_24_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(arg_24_0._gohardmodeNormal, arg_24_0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	arg_24_0:refreshModeLockText()
end

function var_0_0.onModeChange(arg_25_0)
	arg_25_0:refreshModeNode()
	arg_25_0.chapterLayout:playAnimation("switch")
	arg_25_0.chapterLayout:refreshEpisodeNodes()

	if arg_25_0._changeModeCallback then
		arg_25_0._changeModeCallback(arg_25_0)

		arg_25_0._changeModeCallback = nil
	end
end

function var_0_0.refreshModeLockText(arg_26_0)
	local var_26_0 = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_6DungeonEnum.DungeonChapterId.Hard)
	local var_26_1 = ServerTime.now()

	if var_26_1 < var_26_0 then
		local var_26_2 = var_26_0 - var_26_1
		local var_26_3 = Mathf.Floor(var_26_2 / TimeUtil.OneDaySecond)
		local var_26_4 = var_26_2 % TimeUtil.OneDaySecond
		local var_26_5 = Mathf.Floor(var_26_4 / TimeUtil.OneHourSecond)
		local var_26_6 = ActivityModel.instance:getActivityInfo()[VersionActivity1_6Enum.ActivityId.Dungeon]

		if var_26_3 > 0 then
			local var_26_7 = var_26_6:getRemainTimeStr2(var_26_2)

			if var_26_5 > 0 then
				var_26_7 = GameUtil.getSubPlaceholderLuaLang(luaLang("hournum"), {
					var_26_7,
					var_26_5
				})
			end

			arg_26_0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_26_7)
		else
			arg_26_0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_26_6:getRemainTimeStr4(var_26_2))
		end

		gohelper.setActive(arg_26_0._gohardmodelock, true)
		gohelper.setActive(arg_26_0._hardModeLockTip, true)

		return
	end

	local var_26_8, var_26_9 = DungeonModel.instance:chapterIsUnLock(arg_26_0.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not var_26_8 then
		local var_26_10 = DungeonConfig.instance:getEpisodeCO(var_26_9)

		arg_26_0._txtunlocktime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "NS-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_26_10.chapterId, var_26_9))

		gohelper.setActive(arg_26_0._gohardmodelock, true)
		gohelper.setActive(arg_26_0._hardModeLockTip, true)

		return
	end

	gohelper.setActive(arg_26_0._gohardmodelock, false)
	gohelper.setActive(arg_26_0._hardModeLockTip, false)
end

function var_0_0.onClickElement(arg_27_0, arg_27_1)
	if arg_27_1:getElementId() == VersionActivity1_6DungeonEnum.DungeonBossMapElementId then
		AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossEnterClick)
		VersionActivity1_6DungeonController.instance:openDungeonBossView()
	end
end

function var_0_0.showUI(arg_28_0)
	gohelper.setActive(arg_28_0._gomodecontainer, true)
	arg_28_0:showLayout()
end

function var_0_0.hideUI(arg_29_0)
	gohelper.setActive(arg_29_0._gomodecontainer, false)
	arg_29_0:hideLayout()
end

function var_0_0.showLayout(arg_30_0)
	if not arg_30_0.chapterLayout then
		return
	end

	arg_30_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_30_0.chapterLayout.viewGO.transform, arg_30_0.chapterLayout.defaultY, 0.2)
end

function var_0_0.hideLayout(arg_31_0)
	if not arg_31_0.chapterLayout then
		return
	end

	arg_31_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_31_0.chapterLayout.viewGO.transform, -260, 0.2)
end

function var_0_0._onUpdateDungeonInfo(arg_32_0)
	if arg_32_0.chapterLayout then
		arg_32_0.chapterLayout:refreshEpisodeNodes()
	end

	arg_32_0:refreshModeNode()
	arg_32_0:playUnlockAnimation()
end

function var_0_0._onCloseViewFinish(arg_33_0, arg_33_1)
	if arg_33_1 == arg_33_0.viewName then
		return
	end

	arg_33_0:playUnlockAnimation()
end

function var_0_0.onFunUnlockRefreshUI(arg_34_0)
	arg_34_0:refreshModeNode()
	arg_34_0:playUnlockAnimation()
end

function var_0_0.playOnOpenAnimation(arg_35_0)
	arg_35_0.chapterLayout:playAnimation(UIAnimationName.Open)

	if arg_35_0.viewContainer.viewParam.needSelectFocusItem then
		arg_35_0.chapterLayout:setSelectEpisodeId(arg_35_0.activityDungeonMo.episodeId)
	else
		arg_35_0.chapterLayout:playEpisodeItemAnimation("in")
	end
end

function var_0_0.playUnlockAnimation(arg_36_0, arg_36_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_36_0.viewName) then
		return
	end

	if arg_36_0:checkPlayUnLockAnimation() then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(var_0_1), 1)

		local var_36_0 = gohelper.findChildComponent(arg_36_0.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)

		if var_36_0 then
			AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonHardModeUnlock)
			var_36_0:Play(UIAnimationName.Unlock, 0, 0)
			TaskDispatcher.runDelay(arg_36_0._unlockAniDone, arg_36_0, VersionActivity1_6DungeonEnum.HardModeUnlockAnimDuration)

			return
		end
	end

	if arg_36_1 then
		arg_36_0:_unlockAniDone()
	end
end

function var_0_0._unlockAniDone(arg_37_0)
	local var_37_0 = gohelper.findChildComponent(arg_37_0.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)
	local var_37_1 = gohelper.findChild(arg_37_0.viewGO, "#go_switchmodecontainer/#go_hardmode/#unlock")

	var_37_0.enabled = false

	gohelper.setActive(var_37_1, false)

	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_6Enum.ActivityId.Dungeon) then
		return
	end

	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function var_0_0.checkPlayUnLockAnimation(arg_38_0)
	local var_38_0 = var_0_1

	if PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(var_38_0, 0)) == 1 then
		return false
	end

	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_6Enum.ActivityId.Dungeon) then
		return false
	end

	return true
end

return var_0_0
