module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterView", package.seeall)

slot0 = class("VersionActivity1_6EnterView", VersionActivityEnterBaseViewWithList)
slot1 = {
	orange = 2,
	green = 1,
	yellow = 3
}
slot2 = VersionActivity1_6Enum.ActivityId
slot3 = {
	[slot2.Season] = slot1.green,
	[slot2.Dungeon] = slot1.green,
	[slot2.BossRush] = slot1.orange,
	[slot2.Role1] = slot1.green,
	[slot2.Role2] = slot1.yellow,
	[slot2.Cachot] = slot1.green,
	[slot2.Reactivity] = slot1.yellow,
	[slot2.RoleStory] = slot1.orange,
	[slot2.RoleStory2] = slot1.orange,
	[slot2.Explore] = slot1.green
}
slot4 = {
	[slot2.Role1] = true,
	[slot2.Role2] = true,
	[slot2.RoleStory] = true,
	[slot2.RoleStory2] = true
}
slot5 = 3

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._goBtnReplay = gohelper.findChild(slot0.viewGO, "entrance/#btn_replay")
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
	slot0._goBtnAchievement = gohelper.findChild(slot0.viewGO, "entrance/#btn_achievementpreview")
	slot0._btnachievementpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievementpreview")
	slot0._goBtnAchievementNormal = gohelper.findChild(slot0.viewGO, "entrance/#btn_achievement_normal")
	slot0._btnAchievementNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievement_normal")
	slot0._tabScrollRect = gohelper.findChildScrollRect(slot0.viewGO, "#go_category/#scroll_category")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#go_category/#scroll_category/Viewport/Content")
	slot0._goTabListDownFlag = gohelper.findChild(slot0.viewGO, "#go_category/tips/down")
	slot0._goTabListArrow = gohelper.findChild(slot0.viewGO, "#go_category/arrow")
	slot0._arrowAnimator = slot0._goTabListArrow:GetComponent(typeof(UnityEngine.Animator))

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
	if ActivityConfig.instance:getActivityCo(slot0._curActId) and slot1.achievementGroup and slot2 ~= 0 then
		AchievementController.instance:openAchievementGroupPreView(slot0._curActId)
	else
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			selectType = AchievementEnum.Type.GamePlay
		})
	end
end

function slot0._btnReplayOnClick(slot0)
	if not (ActivityModel.instance:getActMO(slot0._curActId) and slot1.config and slot1.config.storyId) then
		logError(string.format("act id %s dot config story id", slot2))

		return
	end

	StoryController.instance:playStory(slot2, {
		isVersionActivityPV = true
	})
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0:addEventCb(VersionActivity1_6EnterController.instance, VersionActivity1_6EnterEvent.OnEnterVideoFinished, slot0._onFinishEnterVideo, slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
end

function slot0.onOpenFinish(slot0)
	uv0.super.onOpenFinish(slot0)

	slot0._scrollHeight = recthelper.getHeight(slot0._tabScrollRect.transform)

	slot0:refreshTabListFlag()

	if slot0._showEnterVideo then
		ViewMgr.instance:openView(ViewName.VersionActivity1_6EnterVideoView)
	end
end

function slot0._onFinishEnterVideo(slot0)
	slot0:playOpenAnimation()
	AudioMgr.instance:trigger(slot0._curActId == VersionActivity1_6Enum.ActivityId.Dungeon and AudioEnum.UI.Act1_6EnterViewMainActTabSelect or AudioEnum.UI.Act1_6EnterViewTabSelect)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0.everyMinuteCall(slot0)
	uv0.super.everyMinuteCall(slot0)
end

function slot0._onScrollChange(slot0, slot1)
	slot0:refreshTabListArrow()

	if not slot0._redDotItems or #slot0._redDotItems == 0 then
		if slot0._goTabListArrow.activeSelf then
			slot0._arrowAnimator:Play(UIAnimationName.Idle)
		end

		return
	end

	slot0:refreshTabListFlag()
end

function slot0.initViewParam(slot0)
	uv0.super.initViewParam(slot0)

	slot0._showEnterVideo = slot0.viewParam.enterVideo
end

slot6 = 5
slot7 = 150

function slot0.refreshTabListFlag(slot0)
	slot0._contentHeight = recthelper.getHeight(slot0._goContent.transform)

	if (slot0.showItemNum or 0) <= uv0 then
		gohelper.setActive(slot0._goTabListDownFlag, false)
		gohelper.setActive(slot0._goTabListArrow, false)
	else
		for slot6, slot7 in ipairs(slot0._redDotItems) do
			slot2 = math.min(slot7.rootGo.transform.localPosition.y, 0)
		end

		if math.abs(slot2) - slot0._scrollHeight - slot0._goContent.transform.localPosition.y > uv1 / 2 then
			slot0._arrowAnimator:Play(UIAnimationName.Loop)
		else
			slot0._arrowAnimator:Play(UIAnimationName.Idle)
		end

		gohelper.setActive(slot0._goTabListDownFlag, slot6)
	end
end

function slot0.refreshTabListArrow(slot0)
	slot0._contentHeight = recthelper.getHeight(slot0._goContent.transform)

	if (slot0.showItemNum or 0) <= uv0 then
		gohelper.setActive(slot0._goTabListDownFlag, false)
		gohelper.setActive(slot0._goTabListArrow, false)
	else
		gohelper.setActive(slot0._goTabListArrow, slot0._contentHeight - slot0._scrollHeight - slot0._goContent.transform.localPosition.y > 0)
	end
end

function slot0._refreshTabs(slot0, slot1)
	slot0.viewContainer:selectActTab(slot1)
end

function slot0.onCreateActivityItem(slot0, slot1)
	slot2 = slot1.actId

	slot1:setShowRemainDayToggle(uv0[slot2], uv1)

	if slot0["onCreateActivityItem" .. slot2] then
		slot3(slot0, slot1)
	end
end

function slot0.onRefreshTabView(slot0, slot1, slot2)
	uv0.super.onRefreshTabView(slot0)

	slot5, slot6 = ActivityConfig.instance:getActivityTabButtonState(slot0.activityItemList[slot1].actId)

	gohelper.setActive(slot0._goBtnReplay, slot5)

	if slot6 then
		gohelper.setActive(slot0._goBtnAchievement, slot4 == VersionActivity1_6Enum.ActivityId.Dungeon)
		gohelper.setActive(slot0._goBtnAchievementNormal, slot4 ~= VersionActivity1_6Enum.ActivityId.Dungeon)
	else
		gohelper.setActive(slot0._goBtnAchievement, false)
		gohelper.setActive(slot0._goBtnAchievementNormal, false)
	end

	if not slot2 then
		AudioMgr.instance:trigger(slot4 == VersionActivity1_6Enum.ActivityId.Dungeon and AudioEnum.UI.Act1_6EnterViewMainActTabSelect or AudioEnum.UI.Act1_6EnterViewTabSelect)
	end
end

function slot0.onFocusToTab(slot0, slot1)
	slot4 = slot0._goContent.transform.localPosition
	slot0._goContent.transform.localPosition = Vector3(slot4.x, (gohelper.getSibling(slot1.rootGo) - 1) * uv0, slot4.z)
end

function slot0.onRefreshActivityTabIcon(slot0, slot1)
	if ActivityConfig.instance:getActivityTabBgPathes(slot1.actId) and #slot3 == 2 then
		UISpriteSetMgr.instance:setV1a6EnterSprite(slot1.imageIcons.select, slot3[1], true)
		UISpriteSetMgr.instance:setV1a6EnterSprite(slot1.imageIcons.normal, slot3[2], true)
	end
end

function slot0.setSelectActId(slot0, slot1)
	VersionActivity1_6EnterController.instance:setSelectActId(slot1)
end

function slot0.refreshTabSelectState(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	for slot9, slot10 in ipairs({
		gohelper.findChild(slot1.go_selected, "eff/1"),
		gohelper.findChild(slot1.go_selected, "eff/2"),
		gohelper.findChild(slot1.go_selected, "eff/3")
	}) do
		gohelper.setActive(slot10, slot9 == uv0[slot1.actId])
	end
end

function slot0.checkActivityCanClickFunc11602(slot0, slot1)
	return true
end

function slot0.checkStatusFunc11602(slot0)
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.DungeonStore)
end

function slot0.checkStatusFunc11600(slot0)
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.SeasonStore)
end

function slot0.checkActivityCanClickFunc11600(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.SeasonStore)

	if slot0:CheckActivityStatusClickAble(slot1) then
		return true
	else
		if slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end
end

function slot0.checkStatusFunc11104(slot0)
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.ReactivityStore)
end

function slot0.checkActivityCanClickFunc11104(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.ReactivityStore)

	if slot0:CheckActivityStatusClickAble(slot1) then
		return true
	else
		if slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end
end

function slot0.onClickActivity11610(slot0)
	if V1a6_CachotModel.instance:isReallyOpen() then
		RogueRpc.instance:sendGetRogueStateRequest()
	end
end

function slot0.onCreateActivityItem11605(slot0, slot1)
	slot1.redDotUid = VersionActivity1_6Enum.ActivityId.Role1
end

function slot0.onCreateActivityItem11606(slot0, slot1)
	slot1.redDotUid = VersionActivity1_6Enum.ActivityId.Role2
end

return slot0
