module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterView", package.seeall)

slot0 = class("VersionActivity1_7EnterView", VersionActivityEnterBaseViewWithList1_7)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
	slot0._btnachievementpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievementpreview")
	slot0._btnAchievementNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievement_normal")
	slot0._tabScrollRect = gohelper.findChildScrollRect(slot0.viewGO, "#go_tabcontainer/#scroll_tab")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnreplay:AddClickListener(slot0._btnReplayOnClick, slot0)
	slot0._btnachievementpreview:AddClickListener(slot0._btnachievementpreviewOnClick, slot0)
	slot0._btnAchievementNormal:AddClickListener(slot0._btnachievementpreviewOnClick, slot0)
	slot0._tabScrollRect:AddOnValueChanged(slot0._onScrollChange, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnreplay:RemoveClickListener()
	slot0._btnachievementpreview:RemoveClickListener()
	slot0._btnAchievementNormal:RemoveClickListener()
	slot0._tabScrollRect:RemoveOnValueChanged()
end

function slot0._btnachievementpreviewOnClick(slot0)
	JumpController.instance:jump(ActivityConfig.instance:getActivityCo(slot0.curActId) and slot1.achievementJumpId)
end

function slot0._btnReplayOnClick(slot0)
	if not (ActivityModel.instance:getActMO(slot0.curActId) and slot1.config and slot1.config.storyId) then
		logError(string.format("act id %s dot config story id", slot2))

		return
	end

	StoryController.instance:playStory(slot2, {
		isVersionActivityPV = true
	})
end

function slot0._onScrollChange(slot0)
	for slot5, slot6 in ipairs(slot0.activityTabItemList) do
		if slot6:isShowRedDot() and slot0.viewPortHeight < -slot6:getAnchorY() + VersionActivity1_7Enum.RedDotOffsetY - recthelper.getAnchorY(slot0.rectTrContent) then
			gohelper.setActive(slot0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(slot0.goArrowRedDot, false)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.goReplayBtn = slot0._btnreplay.gameObject
	slot0.goAchievementBtn = slot0._btnachievementpreview.gameObject
	slot0.tabAnim = gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer", gohelper.Type_Animator)
	slot0.entranceAnim = gohelper.findChildComponent(slot0.viewGO, "entrance", gohelper.Type_Animator)
	slot0.goArrowRedDot = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")
	slot0.rectTrContent = gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	slot0.viewPortHeight = recthelper.getHeight(gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform))

	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0, LuaEventSystem.Low)
end

function slot0.refreshRedDot(slot0)
	slot0:_onScrollChange()
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:refreshBtnVisible()
	slot0:_onScrollChange()
	slot0:playVideo()
end

function slot0.playVideo(slot0)
	if slot0.viewParam.skipOpenAnim then
		slot0.tabAnim:Play(UIAnimationName.Open, 0, 1)
		slot0.entranceAnim:Play(UIAnimationName.Open, 0, 1)
	elseif slot0.viewParam.playVideo then
		slot0.tabAnim:Play(UIAnimationName.Open, 0, 0)
		slot0.entranceAnim:Play(UIAnimationName.Open, 0, 0)

		slot0.tabAnim.speed = 0
		slot0.entranceAnim.speed = 0

		VideoController.instance:openFullScreenVideoView(langVideoUrl("1_7_enter"), nil, 2.1)
		slot0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, slot0.onPlayVideoDone, slot0)
		slot0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, slot0.onPlayVideoDone, slot0)
	else
		slot0.tabAnim:Play(UIAnimationName.Open, 0, 0)
		slot0.entranceAnim:Play(UIAnimationName.Open, 0, 0)

		slot0.tabAnim.speed = 1
		slot0.entranceAnim.speed = 1
	end
end

function slot0.onPlayVideoDone(slot0)
	slot0.tabAnim.speed = 1
	slot0.entranceAnim.speed = 1

	slot0.tabAnim:Play(UIAnimationName.Open, 0, 0)
	slot0.entranceAnim:Play(UIAnimationName.Open, 0, 0)
end

function slot0.onSelectActId(slot0, ...)
	uv0.super.onSelectActId(slot0, ...)
	slot0:refreshBtnVisible()
end

function slot0.refreshBtnVisible(slot0)
	slot1 = VersionActivity1_7Enum.ActId2ShowReplayBtnDict[slot0.curActId]

	gohelper.setActive(slot0.goReplayBtn, slot1)
	gohelper.setActive(slot0.goAchievementBtn, VersionActivity1_7Enum.ActId2ShowAchievementBtnDict[slot0.curActId])

	if slot1 or slot2 then
		slot0.entranceAnim.speed = 1

		slot0.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0.onClickActivity11704(slot0, slot1)
	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_7Enum.ActivityId.BossRush)

	if slot3 == ActivityEnum.ActivityStatus.Normal or slot3 == ActivityEnum.ActivityStatus.NotUnlock then
		V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
		slot1.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, slot2, slot0)
	end

	if slot4 then
		GameFacade.showToastWithTableParam(slot4, slot5)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

return slot0
