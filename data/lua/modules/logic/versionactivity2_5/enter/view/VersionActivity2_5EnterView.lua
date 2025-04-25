module("modules.logic.versionactivity2_5.enter.view.VersionActivity2_5EnterView", package.seeall)

slot0 = class("VersionActivity2_5EnterView", VersionActivityEnterBaseViewWithListNew)

function slot0._editableInitView(slot0)
	slot0._scrolltab = gohelper.findChildScrollRect(slot0.viewGO, "#go_tabcontainer/#scroll_tab")
	slot0.goArrowRedDot = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")
	slot0.viewPortHeight = recthelper.getHeight(gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform))
	slot0.rectTrContent = gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	slot0._gotabitem1 = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	slot0._gotabitem2 = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	slot0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, slot0._gotabitem1, VersionActivity2_5EnterViewTabItem1)
	slot0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, slot0._gotabitem2, VersionActivity2_5EnterViewTabItem2)
	slot0:setActivityLineGo(slot0._goline)

	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
	slot0._btnachievementnormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievement_normal")
	slot0._btnachievementpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievementpreview")
	slot0.goReplayBtn = slot0._btnreplay.gameObject
	slot0.goAchievementBtn = slot0._btnachievementpreview.gameObject

	gohelper.setActive(slot0._btnachievementnormal.gameObject, false)

	slot0.viewAnim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.gosubviewCanvasGroup = gohelper.findChildComponent(slot0.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function slot0.childAddEvents(slot0)
	slot0._btnreplay:AddClickListener(slot0._btnreplayOnClick, slot0)
	slot0._btnachievementnormal:AddClickListener(slot0._btnachievementpreviewOnClick, slot0)
	slot0._btnachievementpreview:AddClickListener(slot0._btnachievementpreviewOnClick, slot0)
	slot0._scrolltab:AddOnValueChanged(slot0._onTabScrollChange, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0, LuaEventSystem.Low)
end

function slot0.childRemoveEvents(slot0)
	slot0._btnreplay:RemoveClickListener()
	slot0._btnachievementnormal:RemoveClickListener()
	slot0._btnachievementpreview:RemoveClickListener()
	slot0._scrolltab:RemoveOnValueChanged()
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0)
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
		if slot6:isShowRedDot() and slot0.viewPortHeight < -slot6:getAnchorY() + VersionActivity2_5Enum.RedDotOffsetY - recthelper.getAnchorY(slot0.rectTrContent) then
			gohelper.setActive(slot0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(slot0.goArrowRedDot, false)
end

function slot0.refreshRedDot(slot0)
	slot0:_onTabScrollChange()
end

function slot0.refreshBtnVisible(slot0, slot1)
	gohelper.setActive(slot0.goReplayBtn, VersionActivity2_5EnterHelper.GetIsShowReplayBtn(slot0.curActId))
	gohelper.setActive(slot0.goAchievementBtn, VersionActivity2_5EnterHelper.GetIsShowAchievementBtn(slot0.curActId))
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	if slot0.curActId == VersionActivity2_5Enum.ActivityId.Dungeon then
		slot0.viewAnim:Play("open1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_5Enter.play_ui_tangren_open1)
		slot0:openBgmLeadSinger()
	else
		slot0.viewAnim:Play(UIAnimationName.Open, 0, 0)
		slot0.viewContainer:markPlayedSubViewAnim()
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot0.curActId == VersionActivity2_5Enum.ActivityId.Dungeon and slot1 == ViewName.VersionActivity2_5DungeonMapView then
		slot0:closeBgmLeadSinger()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot0.curActId == VersionActivity2_5Enum.ActivityId.Dungeon and ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:openBgmLeadSinger()
	end
end

function slot0._setAudioSwitchId(slot0)
	slot0.switchGroupId = slot0.switchGroupId or AudioMgr.instance:getIdFromString("music_vocal_filter")
	slot0.originalStateId = slot0.originalStateId or AudioMgr.instance:getIdFromString("original")
	slot0.accompanimentStateId = slot0.accompanimentStateId or AudioMgr.instance:getIdFromString("accompaniment")
end

function slot0.openBgmLeadSinger(slot0)
	slot0:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.originalStateId)
end

function slot0.closeBgmLeadSinger(slot0)
	slot0:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.accompanimentStateId)
end

function slot0.onClickActivity12502(slot0, slot1)
	slot0:_generalOnClick(VersionActivity2_5Enum.ActivityId.Dungeon, slot1, slot0.openBgmLeadSinger, slot0)
end

function slot0.onClickActivity12512(slot0, slot1)
	slot0:_generalOnClick(VersionActivity2_5Enum.ActivityId.LiangYue, slot1, slot0.closeBgmLeadSinger, slot0)
end

function slot0._generalOnClick(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7 = ActivityHelper.getActivityStatusAndToast(slot1)

	if slot5 == ActivityEnum.ActivityStatus.Normal or slot5 == ActivityEnum.ActivityStatus.NotUnlock then
		if slot3 then
			slot3(slot4)
		end

		slot2.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, slot1, slot0)
	end

	if slot6 then
		GameFacade.showToastWithTableParam(slot6, slot7)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

return slot0
