module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapEpisodeView", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapEpisodeView", BaseView)

function slot0.onInitView(slot0)
	slot0._gochaptercontentitem = gohelper.findChild(slot0.viewGO, "#scroll_content/#go_chaptercontentitem")
	slot0._gomodecontainer = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer")
	slot0._btnstorymode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_switchmodecontainer/#go_storymode/#btn_storyMode")
	slot0._btnhardmode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#btn_hardMode")
	slot0._imgstorymode = gohelper.findChildImage(slot0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon")
	slot0._gostorymodeNormal = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_normal")
	slot0._gostorymodeSelect = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_select")
	slot0._imghardmode = gohelper.findChildImage(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon")
	slot0._gohardmodeNormal = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_normal")
	slot0._gohardmodeSelect = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_select")
	slot0._gohardmodelock = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_locked")
	slot0._hardModeLockTip = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock")
	slot0._txtunlocktime = gohelper.findChildText(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstorymode:AddClickListener(slot0.btnStoryModeClick, slot0)
	slot0._btnhardmode:AddClickListener(slot0.btnHardModeClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstorymode:RemoveClickListener()
	slot0._btnhardmode:RemoveClickListener()
end

function slot0.btnStoryModeClick(slot0)
	slot0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function slot0.btnHardModeClick(slot0)
	slot1, slot2, slot3 = slot0:checkHardModeIsOpen()

	if not slot1 then
		GameFacade.showToast(slot2, slot3)

		return
	end

	slot0:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function slot0.checkHardModeIsOpen(slot0)
	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function slot0.changeEpisodeMode(slot0, slot1)
	if slot1 == slot0.activityDungeonMo.mode then
		return
	end

	if not slot0.chapterLayout then
		return
	end

	slot0.scrollRect.velocity = Vector2(0, 0)

	if slot1 == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		slot0.excessiveAnimator:Play("story", 0, 0)
	else
		slot0.excessiveAnimator:Play("hard", 0, 0)
	end

	slot0.activityDungeonMo.mode = slot1

	TaskDispatcher.runDelay(slot0.directChangeMode, slot0, 0.41)
end

function slot0.directChangeMode(slot0)
	slot0.activityDungeonMo:changeMode(slot0.activityDungeonMo.mode)
end

function slot0.dailyRefresh(slot0)
	slot0:refreshModeNode()
	slot0:playUnlockAnimation()
end

function slot0._editableInitView(slot0)
	slot0.scrollRect = gohelper.findChild(slot0.viewGO, "#scroll_content"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0.scrollRect.gameObject, DungeonMapEpisodeAudio, slot0.scrollRect)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.scrollRect.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0.scrollRect.gameObject)

	slot0._touch:AddClickDownListener(slot0._onClickDownHandler, slot0)

	slot0.scrollRect:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = 0.5

	gohelper.setActive(slot0._gochaptercontentitem, false)
	gohelper.setActive(slot0._goexcessive, true)

	slot0.excessiveAnimator = slot0._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	slot0.goScrollRect = gohelper.findChild(slot0.viewGO, "#scroll_content")

	recthelper.setAnchorY(slot0.goScrollRect.transform, -240)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)

	slot0.isPlayedModeUnLockAnimation = PlayerPrefsHelper.getNumber(slot0:getPlayUnlockAnimationKey(), 0) == 1
end

function slot0._onDragBeginHandler(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEndHandler(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDownHandler(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0.playOnOpenAnimation(slot0)
	slot0.chapterLayout:playAnimation(UIAnimationName.Open)

	if slot0.viewContainer.viewParam.needSelectFocusItem then
		slot0.chapterLayout:setSelectEpisodeId(slot0.activityDungeonMo.episodeId)
	else
		slot0.chapterLayout:playEpisodeItemAnimation("in")
	end
end

function slot0.onUpdateParam(slot0)
	slot0:refreshModeNode()
	slot0.chapterLayout:refreshEpisodeNodes()
	slot0:playOnOpenAnimation()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, slot0.hideUI, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, slot0.showUI, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:initChapterEpisodes()
	slot0:refreshModeNode()
end

function slot0.initChapterEpisodes(slot0)
	slot0._uiLoader = MultiAbLoader.New()

	slot0._uiLoader:addPath(slot0.activityDungeonMo:getLayoutPrefabUrl())
	slot0._uiLoader:startLoad(slot0.onLoadLayoutFinish, slot0)
end

function slot0.onLoadLayoutFinish(slot0)
	slot1 = slot0.activityDungeonMo:getLayoutPrefabUrl()
	slot0.goChapterContent = gohelper.cloneInPlace(slot0._gochaptercontentitem, "#go_chaptercontent")

	gohelper.setAsLastSibling(slot0.goChapterContent)
	gohelper.setActive(slot0.goChapterContent, true)

	slot0.scrollRect.content = slot0.goChapterContent.transform
	slot0.scrollRect.velocity = Vector2(0, 0)
	slot0.scrollRect.horizontalNormalizedPosition = 0
	slot0.chapterLayout = slot0.activityDungeonMo:getLayoutClass().New()
	slot0.chapterLayout.viewContainer = slot0.viewContainer
	slot0.chapterLayout.activityDungeonMo = slot0.activityDungeonMo

	slot0.chapterLayout:initView(gohelper.clone(slot0._uiLoader:getAssetItem(slot1):GetResource(slot1), slot0.goChapterContent), {
		goChapterContent = slot0.goChapterContent
	})
	slot0.chapterLayout:refreshEpisodeNodes()
	slot0:playOnOpenAnimation()
end

function slot0.onOpenFinish(slot0)
	slot0:playUnlockAnimation()
end

function slot0.refreshModeNode(slot0)
	slot0._imgstorymode.color = slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story and VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor
	slot0._imghardmode.color = slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor

	gohelper.setActive(slot0._gostorymodeSelect, slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(slot0._gostorymodeNormal, slot0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(slot0._gohardmodeSelect, slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(slot0._gohardmodeNormal, slot0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	slot0:refreshModeLockText()
end

function slot0.onModeChange(slot0)
	slot0:refreshModeNode()
	slot0.chapterLayout:playAnimation("switch")
	slot0.chapterLayout:refreshEpisodeNodes()
end

function slot0.showUI(slot0)
	gohelper.setActive(slot0._gomodecontainer, true)
	slot0:showLayout()
end

function slot0.hideUI(slot0)
	gohelper.setActive(slot0._gomodecontainer, false)
	slot0:hideLayout()
end

function slot0.showLayout(slot0)
	if not slot0.chapterLayout then
		return
	end

	slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.chapterLayout.viewGO.transform, slot0.chapterLayout.defaultY, 0.2)
end

function slot0.hideLayout(slot0)
	if not slot0.chapterLayout then
		return
	end

	slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.chapterLayout.viewGO.transform, -260, 0.2)
end

function slot0._onUpdateDungeonInfo(slot0)
	if slot0.chapterLayout then
		slot0.chapterLayout:refreshEpisodeNodes()
	end

	slot0:playUnlockAnimation()
end

function slot0._onCloseViewFinish(slot0, slot1)
	slot0:playUnlockAnimation()
end

function slot0.playUnlockAnimation(slot0)
	if slot0.isPlayedModeUnLockAnimation then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0:needPlayUnLockAnimation() then
		PlayerPrefsHelper.setNumber(slot0:getPlayUnlockAnimationKey(), 1)

		if gohelper.findChildComponent(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator) then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_explore_open)
			slot1:Play("unlock", 0, 0)
			TaskDispatcher.runDelay(slot0.unlockAnimDone, slot0, VersionActivity1_5DungeonEnum.HardModeUnlockAnimDuration)
		end
	end
end

function slot0.unlockAnimDone(slot0)
	gohelper.findChildComponent(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator).enabled = false

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#unlock"), false)
	slot0:refreshModeLockText()
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function slot0.needPlayUnLockAnimation(slot0)
	if PlayerPrefsHelper.getNumber(slot0:getPlayUnlockAnimationKey(), 0) == 1 then
		return false
	end

	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_5Enum.ActivityId.Dungeon) then
		return false
	end

	return true
end

function slot0.getPlayUnlockAnimationKey(slot0)
	return PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_5EnterController.GetActivityPrefsKey(PlayerPrefsKey.LeiMiTeBeiPlayHardModeUnlockAnimationKey))
end

function slot0.refreshModeLockText(slot0)
	if ServerTime.now() < VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_5DungeonEnum.DungeonChapterId.Hard) then
		slot3 = slot1 - slot2
		slot6 = Mathf.Floor(slot3 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond)
		slot7 = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.Dungeon]

		if Mathf.Floor(slot3 / TimeUtil.OneDaySecond) > 0 then
			slot8 = nil
			slot0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), (not LangSettings.instance:isEn() or string.format("%s%s %s%s", slot4, luaLang("time_day"), slot6, luaLang("time_hour2"))) and string.format("%s%s%s%s", slot4, luaLang("time_day"), slot6, luaLang("time_hour2")))
		else
			slot0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), slot7:getRemainTimeStr2(slot3))
		end

		gohelper.setActive(slot0._gohardmodelock, true)
		gohelper.setActive(slot0._hardModeLockTip, true)

		return
	end

	slot3, slot4 = DungeonModel.instance:chapterIsUnLock(slot0.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not slot3 then
		slot0._txtunlocktime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "RUG-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(DungeonConfig.instance:getEpisodeCO(slot4).chapterId, slot4))

		gohelper.setActive(slot0._gohardmodelock, true)
		gohelper.setActive(slot0._hardModeLockTip, true)

		return
	end

	gohelper.setActive(slot0._gohardmodelock, false)
	gohelper.setActive(slot0._hardModeLockTip, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.directChangeMode, slot0)
	TaskDispatcher.cancelTask(slot0.unlockAnimDone, slot0)
end

function slot0.onDestroyView(slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)

	if slot0._uiLoader then
		slot0._uiLoader:dispose()
	end

	if slot0.chapterLayout then
		slot0.chapterLayout:destroyView()

		slot0.chapterLayout = nil
	end

	if slot0._audioScroll then
		slot0._audioScroll:dispose()

		slot0._audioScroll = nil
	end

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()

		slot0._touch = nil
	end

	if slot0._episodeListTweenId then
		ZProj.TweenHelper.KillById(slot0._episodeListTweenId)
	end
end

return slot0
