module("modules.logic.versionactivity2_5.dungeon.view.map.VersionActivity2_5DungeonMapEpisodeView", package.seeall)

slot0 = class("VersionActivity2_5DungeonMapEpisodeView", BaseView)
slot1 = 0.5
slot2 = -240
slot3 = 0.41
slot4 = 1.7
slot5 = 0
slot6 = 1
slot7 = 0.2
slot8 = -260

function slot0.onInitView(slot0)
	slot0.goScrollRect = gohelper.findChild(slot0.viewGO, "#scroll_content")
	slot0.scrollRect = gohelper.findChild(slot0.viewGO, "#scroll_content"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0.scrollRect.gameObject, DungeonMapEpisodeAudio, slot0.scrollRect)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.scrollRect.gameObject)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0.scrollRect.gameObject)
	slot0._gochaptercontentitem = gohelper.findChild(slot0.viewGO, "#scroll_content/#go_chaptercontentitem")
	slot0._btnstorymode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_switchmodecontainer/#go_storymode/#btn_storyMode")
	slot0._gostorymodeNormal = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_normal")
	slot0._gostorymodeSelect = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_select")
	slot0._hardModeBtnAnimator = gohelper.findChildComponent(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)
	slot0._btnhardmode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#btn_hardMode")
	slot0._gohardmodeNormal = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_normal")
	slot0._gohardmodeSelect = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_select")
	slot0._gohardmodelock = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_locked")
	slot0._hardModeLockTip = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock")
	slot0._txtHardModeUnlockTime = gohelper.findChildText(slot0.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")
	slot0.excessiveAnimator = slot0._goexcessive:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnClickElement, slot0.hideUI, slot0)
	slot0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnHideInteractUI, slot0.showUI, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0._btnstorymode:AddClickListener(slot0.btnStoryModeClick, slot0)
	slot0._btnhardmode:AddClickListener(slot0.btnHardModeClick, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)
	slot0._touch:AddClickDownListener(slot0._onClickDownHandler, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnClickElement, slot0.hideUI, slot0)
	slot0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnHideInteractUI, slot0.showUI, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0._btnstorymode:RemoveClickListener()
	slot0._btnhardmode:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._touch:RemoveClickDownListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gochaptercontentitem, false)
	gohelper.setActive(slot0._goexcessive, true)
	recthelper.setAnchorY(slot0.goScrollRect.transform, uv0)

	slot0.scrollRect:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = uv1
end

function slot0.onUpdateParam(slot0)
	slot0:refreshModeNode()
	slot0.chapterLayout:refreshEpisodeNodes()
	slot0:playOnOpenAnimation()
end

function slot0.onOpen(slot0)
	slot0:initChapterEpisodes()
	slot0:refreshModeNode()
	TaskDispatcher.runRepeat(slot0.refreshModeLockText, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.onOpenFinish(slot0)
	slot0:playUnlockAnimation(true)
end

function slot0.refreshModeNode(slot0)
	slot3 = VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(slot0._gostorymodeSelect, slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(slot0._gostorymodeNormal, slot1 ~= slot2)
	gohelper.setActive(slot0._gohardmodeSelect, slot1 == slot3)
	gohelper.setActive(slot0._gohardmodeNormal, slot1 ~= slot3)
	slot0:refreshModeLockText()
end

function slot0.initChapterEpisodes(slot0)
	slot0._uiLoader = MultiAbLoader.New()

	slot0._uiLoader:addPath(slot0.activityDungeonMo:getLayoutPrefabUrl())
	slot0._uiLoader:startLoad(slot0.onLoadLayoutFinish, slot0)
end

function slot0.onLoadLayoutFinish(slot0)
	slot0.goChapterContent = gohelper.cloneInPlace(slot0._gochaptercontentitem, "#go_chaptercontent")

	gohelper.setAsLastSibling(slot0.goChapterContent)
	gohelper.setActive(slot0.goChapterContent, true)

	slot0.scrollRect.content = slot0.goChapterContent.transform
	slot0.scrollRect.velocity = Vector2(0, 0)
	slot0.scrollRect.horizontalNormalizedPosition = 0
	slot1 = slot0.activityDungeonMo:getLayoutPrefabUrl()
	slot0.chapterLayout = slot0.activityDungeonMo:getLayoutClass().New()
	slot0.chapterLayout.viewContainer = slot0.viewContainer
	slot0.chapterLayout.activityDungeonMo = slot0.activityDungeonMo

	slot0.chapterLayout:initView(gohelper.clone(slot0._uiLoader:getAssetItem(slot1):GetResource(slot1), slot0.goChapterContent), {
		goChapterContent = slot0.goChapterContent
	})
	slot0.chapterLayout:refreshEpisodeNodes()
	slot0:playOnOpenAnimation()
end

function slot0.refreshModeLockText(slot0)
	if ServerTime.now() < VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity2_5DungeonEnum.DungeonChapterId.Hard) then
		slot3 = slot1 - slot2
		slot6 = Mathf.Floor(slot3 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond)

		if Mathf.Floor(slot3 / TimeUtil.OneDaySecond) > 0 then
			if slot6 > 0 then
				slot8 = GameUtil.getSubPlaceholderLuaLang(luaLang("hournum"), {
					ActivityModel.instance:getActivityInfo()[VersionActivity2_5Enum.ActivityId.Dungeon]:getRemainTimeStr2(slot3),
					slot6
				})
			end

			slot0._txtHardModeUnlockTime.text = string.format(luaLang("seasonmainview_timeopencondition"), slot8)
		else
			slot0._txtHardModeUnlockTime.text = string.format(luaLang("seasonmainview_timeopencondition"), slot7:getRemainTimeStr4(slot3))
		end

		gohelper.setActive(slot0._hardModeLockTip, true)
		gohelper.setActive(slot0._gohardmodelock, true)
	else
		slot3, slot4 = DungeonModel.instance:chapterIsUnLock(slot0.activityDungeonMo.activityDungeonConfig.hardChapterId)

		if slot3 then
			gohelper.setActive(slot0._hardModeLockTip, false)
			gohelper.setActive(slot0._gohardmodelock, false)
		else
			slot5 = DungeonConfig.instance:getEpisodeCO(slot4)
			slot0._txtHardModeUnlockTime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), DungeonConfig.instance:getChapterCO(slot5.chapterId).chapterIndex .. "-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot5.chapterId, slot4))

			gohelper.setActive(slot0._hardModeLockTip, true)
			gohelper.setActive(slot0._gohardmodelock, true)
		end
	end
end

function slot0.onModeChange(slot0)
	slot0:refreshModeNode()
	slot0.chapterLayout:playAnimation("switch")
	slot0.chapterLayout:refreshEpisodeNodes()
end

function slot0.showUI(slot0)
	slot0:setLayoutVisible(true)
end

function slot0.hideUI(slot0)
	slot0:setLayoutVisible(false)
end

function slot0.setLayoutVisible(slot0, slot1)
	if not slot0.chapterLayout then
		return
	end

	if slot0._episodeListTweenId then
		ZProj.TweenHelper.KillById(slot0._episodeListTweenId)

		slot0._episodeListTweenId = nil
	end

	slot2 = slot0.chapterLayout.viewGO.transform
	slot3 = uv0

	if slot1 then
		slot3 = slot0.chapterLayout.defaultY
	end

	slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot2, slot3, uv1)
end

function slot0._onUpdateDungeonInfo(slot0)
	if slot0.chapterLayout then
		slot0.chapterLayout:refreshEpisodeNodes()
	end

	slot0:refreshModeNode()
	slot0:playUnlockAnimation()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == slot0.viewName then
		return
	end

	slot0:playUnlockAnimation()
end

function slot0.dailyRefresh(slot0)
	slot0:refreshModeNode()
	slot0:playUnlockAnimation()
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
	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(VersionActivity2_5Enum.ActivityId.Dungeon)
end

function slot0.changeEpisodeMode(slot0, slot1)
	if not slot0.chapterLayout or slot1 == slot0.activityDungeonMo.mode then
		return
	end

	slot0.scrollRect.velocity = Vector2(0, 0)

	if slot1 == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		slot0.excessiveAnimator:Play("story")
	else
		slot0.excessiveAnimator:Play("hard")
	end

	slot0.activityDungeonMo.mode = slot1

	TaskDispatcher.runDelay(slot0.directChangeMode, slot0, uv0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
end

function slot0.directChangeMode(slot0)
	slot0.activityDungeonMo:changeMode(slot0.activityDungeonMo.mode)
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

function slot0.playUnlockAnimation(slot0, slot1)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0:IsNeedPlayHardModeUnlockAnimation() then
		VersionActivity2_5DungeonController.instance:savePlayerPrefs(VersionActivity2_5DungeonEnum.PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim, uv0)

		if slot0._hardModeBtnAnimator then
			slot0._hardModeBtnAnimator:Play(UIAnimationName.Unlock, 0, 0)
			TaskDispatcher.runDelay(slot0._unlockAniDone, slot0, uv1)

			return
		end
	end

	if slot1 then
		slot0:_unlockAniDone()
	end
end

function slot0.IsNeedPlayHardModeUnlockAnimation(slot0)
	slot1 = false

	if VersionActivity2_5DungeonController.instance:getPlayerPrefs(VersionActivity2_5DungeonEnum.PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim, uv0) ~= uv1 and VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity2_5Enum.ActivityId.Dungeon) then
		slot1 = true
	end

	return slot1
end

function slot0._unlockAniDone(slot0)
	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity2_5Enum.ActivityId.Dungeon) then
		return
	end

	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshModeLockText, slot0)
	TaskDispatcher.cancelTask(slot0.directChangeMode, slot0)
	TaskDispatcher.cancelTask(slot0._unlockAniDone, slot0)

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

	if slot0._episodeListTweenId then
		ZProj.TweenHelper.KillById(slot0._episodeListTweenId)
	end
end

return slot0
