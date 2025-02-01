module("modules.logic.versionactivity2_0.enter.view.VersionActivity2_0EnterView", package.seeall)

slot0 = class("VersionActivity2_0EnterView", VersionActivityEnterBaseViewWithListNew)
slot1 = 2.1

function slot0._editableInitView(slot0)
	slot0._scrolltab = gohelper.findChildScrollRect(slot0.viewGO, "#go_tabcontainer/#scroll_tab")
	slot0.goArrowRedDot = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")
	slot0.viewPortHeight = recthelper.getHeight(gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform))
	slot0.rectTrContent = gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	slot0._gotabitem1 = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	slot0._gotabitem2 = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	slot0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, slot0._gotabitem1, VersionActivity2_0EnterViewTabItem1)
	slot0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, slot0._gotabitem2, VersionActivity2_0EnterViewTabItem2)
	slot0:setActivityLineGo(slot0._goline)

	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
	slot0._btnachievementpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievementpreview")
	slot0.goReplayBtn = slot0._btnreplay.gameObject
	slot0.goAchievementBtn = slot0._btnachievementpreview.gameObject
	slot0.entranceAnim = gohelper.findChildComponent(slot0.viewGO, "entrance", gohelper.Type_Animator)
	slot0.tabAnim = gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer", gohelper.Type_Animator)
	slot0.viewAnim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.gosubviewCanvasGroup = gohelper.findChildComponent(slot0.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
end

function slot0.childAddEvents(slot0)
	slot0._btnreplay:AddClickListener(slot0._btnreplayOnClick, slot0)
	slot0._btnachievementpreview:AddClickListener(slot0._btnachievementpreviewOnClick, slot0)
	slot0._scrolltab:AddOnValueChanged(slot0._onTabScrollChange, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.selectAct, slot0, LuaEventSystem.Low)
end

function slot0.childRemoveEvents(slot0)
	slot0._btnreplay:RemoveClickListener()
	slot0._btnachievementpreview:RemoveClickListener()
	slot0._scrolltab:RemoveOnValueChanged()
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0)
	slot0:removeEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.selectAct, slot0, LuaEventSystem.Low)
end

function slot0._btnreplayOnClick(slot0)
	if not ActivityModel.instance:getActMO(slot0.curActId) or not slot1.config or not slot1.config.storyId or slot2 == 0 then
		logError(string.format("act id %s dot config story id", slot0.curActId))

		return
	end

	StoryController.instance:playStory(slot2, {
		isVersionActivityPV = true
	})
end

function slot0._btnachievementpreviewOnClick(slot0)
	JumpController.instance:jump(ActivityConfig.instance:getActivityCo(slot0.curActId) and slot1.achievementJumpId)
end

function slot0._onTabScrollChange(slot0)
	for slot5, slot6 in ipairs(slot0.activityTabItemList) do
		if slot6:isShowRedDot() and slot0.viewPortHeight < -slot6:getAnchorY() + VersionActivity2_0Enum.RedDotOffsetY - recthelper.getAnchorY(slot0.rectTrContent) then
			gohelper.setActive(slot0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(slot0.goArrowRedDot, false)
end

function slot0.playVideo(slot0)
	slot0.tabAnim:Play(UIAnimationName.Open, 0, 0)
	slot0.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	slot0.viewAnim:Play("open1", 0, 0)

	if slot0.viewParam.playVideo then
		slot0.tabAnim.speed = 0
		slot0.entranceAnim.speed = 0
		slot0.gosubviewCanvasGroup.alpha = 0

		VideoController.instance:openFullScreenVideoView(VersionActivity2_0Enum.EnterAnimVideoPath, nil, uv0)
		slot0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, slot0.onPlayVideoDone, slot0)
		slot0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, slot0.onPlayVideoDone, slot0)
	else
		slot0.tabAnim.speed = 1
		slot0.entranceAnim.speed = 1
		slot0.gosubviewCanvasGroup.alpha = 1

		slot0:onPlayVideoDone()
	end
end

function slot0.onPlayVideoDone(slot0)
	slot0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, slot0.onPlayVideoDone, slot0)
	slot0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, slot0.onPlayVideoDone, slot0)

	slot0.tabAnim.speed = 1

	slot0.tabAnim:Play(UIAnimationName.Open, 0, 0)

	slot0.entranceAnim.speed = 1

	slot0.entranceAnim:Play(UIAnimationName.Open, 0, 0)

	slot0.gosubviewCanvasGroup.alpha = 1
end

function slot0.refreshRedDot(slot0)
	slot0:_onTabScrollChange()
end

function slot0.refreshBtnVisible(slot0, slot1)
	gohelper.setActive(slot0.goReplayBtn, VersionActivity2_0EnterHelper.GetIsShowReplayBtn(slot0.curActId))
	gohelper.setActive(slot0.goAchievementBtn, VersionActivity2_0EnterHelper.GetIsShowAchievementBtn(slot0.curActId))

	if slot1 then
		return
	end

	if slot2 or slot3 then
		slot0.entranceAnim.speed = 1

		slot0.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0.selectAct(slot0)
	slot0.viewAnim:Play(UIAnimationName.Open, 0, 0)
	slot0.viewContainer:markPlayedSubViewAnim()
end

return slot0
