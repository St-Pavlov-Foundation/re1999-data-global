module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterView", package.seeall)

local var_0_0 = class("VersionActivity1_6EnterView", VersionActivityEnterBaseViewWithList)
local var_0_1 = {
	orange = 2,
	green = 1,
	yellow = 3
}
local var_0_2 = VersionActivity1_6Enum.ActivityId
local var_0_3 = {
	[var_0_2.Season] = var_0_1.green,
	[var_0_2.Dungeon] = var_0_1.green,
	[var_0_2.BossRush] = var_0_1.orange,
	[var_0_2.Role1] = var_0_1.green,
	[var_0_2.Role2] = var_0_1.yellow,
	[var_0_2.Cachot] = var_0_1.green,
	[var_0_2.Reactivity] = var_0_1.yellow,
	[var_0_2.RoleStory] = var_0_1.orange,
	[var_0_2.RoleStory2] = var_0_1.orange,
	[var_0_2.Explore] = var_0_1.green
}
local var_0_4 = {
	[var_0_2.Role1] = true,
	[var_0_2.Role2] = true,
	[var_0_2.RoleStory] = true,
	[var_0_2.RoleStory2] = true
}
local var_0_5 = 3

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._goBtnReplay = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._goBtnAchievement = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_achievementpreview")
	arg_1_0._btnachievementpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievementpreview")
	arg_1_0._goBtnAchievementNormal = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_achievement_normal")
	arg_1_0._btnAchievementNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievement_normal")
	arg_1_0._tabScrollRect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_category/#scroll_category")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#go_category/#scroll_category/Viewport/Content")
	arg_1_0._goTabListDownFlag = gohelper.findChild(arg_1_0.viewGO, "#go_category/tips/down")
	arg_1_0._goTabListArrow = gohelper.findChild(arg_1_0.viewGO, "#go_category/arrow")
	arg_1_0._arrowAnimator = arg_1_0._goTabListArrow:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnReplayOnClick, arg_2_0)
	arg_2_0._btnachievementpreview:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
	arg_2_0._btnAchievementNormal:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
	arg_2_0._tabScrollRect:AddOnValueChanged(arg_2_0._onScrollChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnachievementpreview:RemoveClickListener()
	arg_3_0._btnAchievementNormal:RemoveClickListener()
	arg_3_0._tabScrollRect:RemoveOnValueChanged()
end

function var_0_0._btnachievementpreviewOnClick(arg_4_0)
	local var_4_0 = ActivityConfig.instance:getActivityCo(arg_4_0._curActId)
	local var_4_1 = var_4_0 and var_4_0.achievementGroup

	if var_4_1 and var_4_1 ~= 0 then
		AchievementController.instance:openAchievementGroupPreView(arg_4_0._curActId)
	else
		local var_4_2 = AchievementEnum.Type.GamePlay

		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			selectType = var_4_2
		})
	end
end

function var_0_0._btnReplayOnClick(arg_5_0)
	local var_5_0 = ActivityModel.instance:getActMO(arg_5_0._curActId)
	local var_5_1 = var_5_0 and var_5_0.config and var_5_0.config.storyId

	if not var_5_1 then
		logError(string.format("act id %s dot config story id", var_5_1))

		return
	end

	local var_5_2 = {}

	var_5_2.isVersionActivityPV = true

	StoryController.instance:playStory(var_5_1, var_5_2)
end

function var_0_0._editableInitView(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_6EnterController.instance, VersionActivity1_6EnterEvent.OnEnterVideoFinished, arg_6_0._onFinishEnterVideo, arg_6_0)
end

function var_0_0.onOpen(arg_7_0)
	var_0_0.super.onOpen(arg_7_0)
end

function var_0_0.onOpenFinish(arg_8_0)
	var_0_0.super.onOpenFinish(arg_8_0)

	arg_8_0._scrollHeight = recthelper.getHeight(arg_8_0._tabScrollRect.transform)

	arg_8_0:refreshTabListFlag()

	if arg_8_0._showEnterVideo then
		ViewMgr.instance:openView(ViewName.VersionActivity1_6EnterVideoView)
	end
end

function var_0_0._onFinishEnterVideo(arg_9_0)
	arg_9_0:playOpenAnimation()
	AudioMgr.instance:trigger(arg_9_0._curActId == VersionActivity1_6Enum.ActivityId.Dungeon and AudioEnum.UI.Act1_6EnterViewMainActTabSelect or AudioEnum.UI.Act1_6EnterViewTabSelect)
end

function var_0_0.onDestroyView(arg_10_0)
	var_0_0.super.onDestroyView(arg_10_0)
end

function var_0_0.everyMinuteCall(arg_11_0)
	var_0_0.super.everyMinuteCall(arg_11_0)
end

function var_0_0._onScrollChange(arg_12_0, arg_12_1)
	arg_12_0:refreshTabListArrow()

	if not arg_12_0._redDotItems or #arg_12_0._redDotItems == 0 then
		if arg_12_0._goTabListArrow.activeSelf then
			arg_12_0._arrowAnimator:Play(UIAnimationName.Idle)
		end

		return
	end

	arg_12_0:refreshTabListFlag()
end

function var_0_0.initViewParam(arg_13_0)
	var_0_0.super.initViewParam(arg_13_0)

	arg_13_0._showEnterVideo = arg_13_0.viewParam.enterVideo
end

local var_0_6 = 5
local var_0_7 = 150

function var_0_0.refreshTabListFlag(arg_14_0)
	arg_14_0._contentHeight = recthelper.getHeight(arg_14_0._goContent.transform)

	if (arg_14_0.showItemNum or 0) <= var_0_6 then
		gohelper.setActive(arg_14_0._goTabListDownFlag, false)
		gohelper.setActive(arg_14_0._goTabListArrow, false)
	else
		local var_14_0 = 0

		for iter_14_0, iter_14_1 in ipairs(arg_14_0._redDotItems) do
			local var_14_1 = iter_14_1.rootGo.transform.localPosition.y

			var_14_0 = math.min(var_14_1, var_14_0)
		end

		local var_14_2 = math.abs(var_14_0)
		local var_14_3 = arg_14_0._goContent.transform.localPosition.y
		local var_14_4 = var_14_2 - arg_14_0._scrollHeight - var_14_3 > var_0_7 / 2

		if var_14_4 then
			arg_14_0._arrowAnimator:Play(UIAnimationName.Loop)
		else
			arg_14_0._arrowAnimator:Play(UIAnimationName.Idle)
		end

		gohelper.setActive(arg_14_0._goTabListDownFlag, var_14_4)
	end
end

function var_0_0.refreshTabListArrow(arg_15_0)
	arg_15_0._contentHeight = recthelper.getHeight(arg_15_0._goContent.transform)

	if (arg_15_0.showItemNum or 0) <= var_0_6 then
		gohelper.setActive(arg_15_0._goTabListDownFlag, false)
		gohelper.setActive(arg_15_0._goTabListArrow, false)
	else
		local var_15_0 = arg_15_0._goContent.transform.localPosition.y
		local var_15_1 = arg_15_0._contentHeight - arg_15_0._scrollHeight - var_15_0

		gohelper.setActive(arg_15_0._goTabListArrow, var_15_1 > 0)
	end
end

function var_0_0._refreshTabs(arg_16_0, arg_16_1)
	arg_16_0.viewContainer:selectActTab(arg_16_1)
end

function var_0_0.onCreateActivityItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.actId

	arg_17_1:setShowRemainDayToggle(var_0_4[var_17_0], var_0_5)

	local var_17_1 = arg_17_0["onCreateActivityItem" .. var_17_0]

	if var_17_1 then
		var_17_1(arg_17_0, arg_17_1)
	end
end

function var_0_0.onRefreshTabView(arg_18_0, arg_18_1, arg_18_2)
	var_0_0.super.onRefreshTabView(arg_18_0)

	local var_18_0 = arg_18_0.activityItemList[arg_18_1].actId
	local var_18_1, var_18_2 = ActivityConfig.instance:getActivityTabButtonState(var_18_0)

	gohelper.setActive(arg_18_0._goBtnReplay, var_18_1)

	if var_18_2 then
		gohelper.setActive(arg_18_0._goBtnAchievement, var_18_0 == VersionActivity1_6Enum.ActivityId.Dungeon)
		gohelper.setActive(arg_18_0._goBtnAchievementNormal, var_18_0 ~= VersionActivity1_6Enum.ActivityId.Dungeon)
	else
		gohelper.setActive(arg_18_0._goBtnAchievement, false)
		gohelper.setActive(arg_18_0._goBtnAchievementNormal, false)
	end

	if not arg_18_2 then
		AudioMgr.instance:trigger(var_18_0 == VersionActivity1_6Enum.ActivityId.Dungeon and AudioEnum.UI.Act1_6EnterViewMainActTabSelect or AudioEnum.UI.Act1_6EnterViewTabSelect)
	end
end

function var_0_0.onFocusToTab(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.rootGo
	local var_19_1 = gohelper.getSibling(var_19_0)
	local var_19_2 = arg_19_0._goContent.transform.localPosition

	arg_19_0._goContent.transform.localPosition = Vector3(var_19_2.x, (var_19_1 - 1) * var_0_7, var_19_2.z)
end

function var_0_0.onRefreshActivityTabIcon(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.actId
	local var_20_1 = ActivityConfig.instance:getActivityTabBgPathes(var_20_0)

	if var_20_1 and #var_20_1 == 2 then
		local var_20_2 = var_20_1[1]
		local var_20_3 = var_20_1[2]

		UISpriteSetMgr.instance:setV1a6EnterSprite(arg_20_1.imageIcons.select, var_20_2, true)
		UISpriteSetMgr.instance:setV1a6EnterSprite(arg_20_1.imageIcons.normal, var_20_3, true)
	end
end

function var_0_0.setSelectActId(arg_21_0, arg_21_1)
	VersionActivity1_6EnterController.instance:setSelectActId(arg_21_1)
end

function var_0_0.refreshTabSelectState(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_2 then
		return
	end

	local var_22_0 = arg_22_1.actId
	local var_22_1 = var_0_3[var_22_0]
	local var_22_2 = {
		gohelper.findChild(arg_22_1.go_selected, "eff/1"),
		gohelper.findChild(arg_22_1.go_selected, "eff/2"),
		gohelper.findChild(arg_22_1.go_selected, "eff/3")
	}

	for iter_22_0, iter_22_1 in ipairs(var_22_2) do
		gohelper.setActive(iter_22_1, iter_22_0 == var_22_1)
	end
end

function var_0_0.checkActivityCanClickFunc11602(arg_23_0, arg_23_1)
	return true
end

function var_0_0.checkStatusFunc11602(arg_24_0)
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.DungeonStore)
end

function var_0_0.checkStatusFunc11600(arg_25_0)
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.SeasonStore)
end

function var_0_0.checkActivityCanClickFunc11600(arg_26_0)
	local var_26_0, var_26_1, var_26_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.SeasonStore)

	if arg_26_0:CheckActivityStatusClickAble(var_26_0) then
		return true
	else
		if var_26_1 then
			GameFacade.showToastWithTableParam(var_26_1, var_26_2)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end
end

function var_0_0.checkStatusFunc11104(arg_27_0)
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.ReactivityStore)
end

function var_0_0.checkActivityCanClickFunc11104(arg_28_0)
	local var_28_0, var_28_1, var_28_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.ReactivityStore)

	if arg_28_0:CheckActivityStatusClickAble(var_28_0) then
		return true
	else
		if var_28_1 then
			GameFacade.showToastWithTableParam(var_28_1, var_28_2)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end
end

function var_0_0.onClickActivity11610(arg_29_0)
	if V1a6_CachotModel.instance:isReallyOpen() then
		RogueRpc.instance:sendGetRogueStateRequest()
	end
end

function var_0_0.onCreateActivityItem11605(arg_30_0, arg_30_1)
	arg_30_1.redDotUid = VersionActivity1_6Enum.ActivityId.Role1
end

function var_0_0.onCreateActivityItem11606(arg_31_0, arg_31_1)
	arg_31_1.redDotUid = VersionActivity1_6Enum.ActivityId.Role2
end

return var_0_0
