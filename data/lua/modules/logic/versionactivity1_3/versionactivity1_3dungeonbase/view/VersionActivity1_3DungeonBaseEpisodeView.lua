module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseEpisodeView", package.seeall)

slot0 = class("VersionActivity1_3DungeonBaseEpisodeView", BaseView)

function slot0.onInitView(slot0)
	slot0._gochaptercontentitem = gohelper.findChild(slot0.viewGO, "#scroll_content/#go_chaptercontentitem")
	slot0._btnstorymode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#btn_storyMode")
	slot0._btnhardmode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#btn_hardMode")
	slot0._gohardmodelock = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock")
	slot0._imgstorymode = gohelper.findChildImage(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon")
	slot0._gostorymodeNormal = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/go_normal")
	slot0._gostorymodeSelect = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/go_select")
	slot0._imghardmode = gohelper.findChildImage(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon")
	slot0._gohardmodeNormal = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/go_normal")
	slot0._gohardmodeSelect = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/go_select")
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
	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(VersionActivity1_3Enum.ActivityId.Dungeon)
end

function slot0.changeEpisodeMode(slot0, slot1)
	if slot1 == slot0.activityDungeonMo.mode then
		return
	end

	if slot0.waitChangeMode == slot1 then
		return
	end

	if not slot0.chapterLayout then
		return
	end

	slot0.scrollRect.velocity = Vector2(0, 0)

	if slot1 == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		slot0.excessiveAnimator:Play("story")
	else
		slot0.excessiveAnimator:Play("hard")
	end

	slot0.waitChangeMode = slot1

	TaskDispatcher.cancelTask(slot0.directChangeMode, slot0)
	TaskDispatcher.runDelay(slot0.directChangeMode, slot0, 0.41)
end

function slot0.directChangeMode(slot0)
	if slot0.waitChangeMode and slot0.activityDungeonMo then
		slot0.activityDungeonMo:changeMode(slot0.waitChangeMode)

		slot0.waitChangeMode = nil
	end
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

	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
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
	slot0.activityDungeonMo = slot0.viewContainer.versionActivityDungeonBaseMo

	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0.setEpisodeListVisible, slot0)
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
	slot0:playUnlockAnimation(true)
end

function slot0.refreshModeNode(slot0)
	slot0._imgstorymode.color = slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story and VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor
	slot0._imghardmode.color = slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor

	gohelper.setActive(slot0._gostorymodeSelect, slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(slot0._gostorymodeNormal, slot0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(slot0._gohardmodeSelect, slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(slot0._gohardmodeNormal, slot0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function slot0.onModeChange(slot0)
	slot0:refreshModeNode()
	slot0.chapterLayout:playAnimation("switch")
	slot0.chapterLayout:refreshEpisodeNodes()
end

function slot0.setEpisodeListVisible(slot0, slot1)
	if not slot0.chapterLayout then
		return
	end

	if slot1 then
		slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.chapterLayout.viewGO.transform, slot0.chapterLayout.defaultY, 0.2)
	else
		slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.chapterLayout.viewGO.transform, -260, slot2)
	end
end

function slot0._onUpdateDungeonInfo(slot0)
	if slot0.chapterLayout then
		slot0.chapterLayout:refreshEpisodeNodes()
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == slot0.viewName then
		return
	end

	slot0:playUnlockAnimation()
end

function slot0.playUnlockAnimation(slot0, slot1)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0:needPlayUnLockAnimation() then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.LeiMiTeBeiPlayHardModeUnlockAnimationKey)), 1)

		if gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode") and SLFramework.AnimatorPlayer.Get(slot2) then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_explore_open)
			slot3:Play("unlock", slot0._unlockDone, slot0)

			return
		end
	end

	if slot1 then
		slot0:_unlockDone()
	end
end

function slot0._unlockDone(slot0)
	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_3Enum.ActivityId.Dungeon) then
		return
	end

	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function slot0.needPlayUnLockAnimation(slot0)
	if PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.LeiMiTeBeiPlayHardModeUnlockAnimationKey)), 0) == 1 then
		return false
	end

	if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_3Enum.ActivityId.Dungeon) then
		return false
	end

	return true
end

function slot0.onDestroyView(slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	TaskDispatcher.cancelTask(slot0.directChangeMode, slot0)

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
