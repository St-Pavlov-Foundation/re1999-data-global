module("modules.logic.versionactivity2_5.enter.view.VersionActivity2_5EnterView", package.seeall)

local var_0_0 = class("VersionActivity2_5EnterView", VersionActivityEnterBaseViewWithListNew)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._scrolltab = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab")
	arg_1_0.goArrowRedDot = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local var_1_0 = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	arg_1_0.viewPortHeight = recthelper.getHeight(var_1_0)
	arg_1_0.rectTrContent = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	arg_1_0._gotabitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	arg_1_0._gotabitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	arg_1_0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, arg_1_0._gotabitem1, VersionActivity2_5EnterViewTabItem1)
	arg_1_0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, arg_1_0._gotabitem2, VersionActivity2_5EnterViewTabItem2)
	arg_1_0:setActivityLineGo(arg_1_0._goline)

	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._btnachievementnormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievement_normal")
	arg_1_0._btnachievementpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievementpreview")
	arg_1_0.goReplayBtn = arg_1_0._btnreplay.gameObject
	arg_1_0.goAchievementBtn = arg_1_0._btnachievementpreview.gameObject

	gohelper.setActive(arg_1_0._btnachievementnormal.gameObject, false)

	arg_1_0.viewAnim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.gosubviewCanvasGroup = gohelper.findChildComponent(arg_1_0.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function var_0_0.childAddEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnreplayOnClick, arg_2_0)
	arg_2_0._btnachievementnormal:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
	arg_2_0._btnachievementpreview:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
	arg_2_0._scrolltab:AddOnValueChanged(arg_2_0._onTabScrollChange, arg_2_0)
	arg_2_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshRedDot, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenView, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseView, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.childRemoveEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnachievementnormal:RemoveClickListener()
	arg_3_0._btnachievementpreview:RemoveClickListener()
	arg_3_0._scrolltab:RemoveOnValueChanged()
	arg_3_0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshRedDot, arg_3_0)
end

function var_0_0._btnreplayOnClick(arg_4_0)
	local var_4_0 = ActivityModel.instance:getActMO(arg_4_0.curActId)
	local var_4_1 = var_4_0 and var_4_0.config and var_4_0.config.storyId

	if not var_4_1 or var_4_1 == 0 then
		logError(string.format("act id %s dot config story id", arg_4_0.curActId))

		return
	end

	local var_4_2 = {}

	var_4_2.isVersionActivityPV = true

	StoryController.instance:playStory(var_4_1, var_4_2)
end

function var_0_0._btnachievementpreviewOnClick(arg_5_0)
	local var_5_0 = ActivityConfig.instance:getActivityCo(arg_5_0.curActId)
	local var_5_1 = var_5_0 and var_5_0.achievementJumpId

	JumpController.instance:jump(var_5_1)
end

function var_0_0._onTabScrollChange(arg_6_0)
	local var_6_0 = recthelper.getAnchorY(arg_6_0.rectTrContent)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.activityTabItemList) do
		if iter_6_1:isShowRedDot() and -iter_6_1:getAnchorY() + VersionActivity2_5Enum.RedDotOffsetY - var_6_0 > arg_6_0.viewPortHeight then
			gohelper.setActive(arg_6_0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(arg_6_0.goArrowRedDot, false)
end

function var_0_0.refreshRedDot(arg_7_0)
	arg_7_0:_onTabScrollChange()
end

function var_0_0.refreshBtnVisible(arg_8_0, arg_8_1)
	local var_8_0 = VersionActivity2_5EnterHelper.GetIsShowReplayBtn(arg_8_0.curActId)
	local var_8_1 = VersionActivity2_5EnterHelper.GetIsShowAchievementBtn(arg_8_0.curActId)

	gohelper.setActive(arg_8_0.goReplayBtn, var_8_0)
	gohelper.setActive(arg_8_0.goAchievementBtn, var_8_1)
end

function var_0_0.onOpen(arg_9_0)
	var_0_0.super.onOpen(arg_9_0)

	if arg_9_0.curActId == VersionActivity2_5Enum.ActivityId.Dungeon then
		arg_9_0.viewAnim:Play("open1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_5Enter.play_ui_tangren_open1)
		arg_9_0:openBgmLeadSinger()
	else
		arg_9_0.viewAnim:Play(UIAnimationName.Open, 0, 0)
		arg_9_0.viewContainer:markPlayedSubViewAnim()
	end
end

function var_0_0._onOpenView(arg_10_0, arg_10_1)
	if arg_10_0.curActId == VersionActivity2_5Enum.ActivityId.Dungeon and arg_10_1 == ViewName.VersionActivity2_5DungeonMapView then
		arg_10_0:closeBgmLeadSinger()
	end
end

function var_0_0._onCloseView(arg_11_0, arg_11_1)
	if arg_11_0.curActId == VersionActivity2_5Enum.ActivityId.Dungeon and ViewHelper.instance:checkViewOnTheTop(arg_11_0.viewName) then
		arg_11_0:openBgmLeadSinger()
	end
end

function var_0_0._setAudioSwitchId(arg_12_0)
	arg_12_0.switchGroupId = arg_12_0.switchGroupId or AudioMgr.instance:getIdFromString("music_vocal_filter")
	arg_12_0.originalStateId = arg_12_0.originalStateId or AudioMgr.instance:getIdFromString("original")
	arg_12_0.accompanimentStateId = arg_12_0.accompanimentStateId or AudioMgr.instance:getIdFromString("accompaniment")
end

function var_0_0.openBgmLeadSinger(arg_13_0)
	arg_13_0:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(arg_13_0.switchGroupId, arg_13_0.originalStateId)
end

function var_0_0.closeBgmLeadSinger(arg_14_0)
	arg_14_0:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(arg_14_0.switchGroupId, arg_14_0.accompanimentStateId)
end

function var_0_0.onClickActivity12502(arg_15_0, arg_15_1)
	local var_15_0 = VersionActivity2_5Enum.ActivityId.Dungeon

	arg_15_0:_generalOnClick(var_15_0, arg_15_1, arg_15_0.openBgmLeadSinger, arg_15_0)
end

function var_0_0.onClickActivity12512(arg_16_0, arg_16_1)
	local var_16_0 = VersionActivity2_5Enum.ActivityId.LiangYue

	arg_16_0:_generalOnClick(var_16_0, arg_16_1, arg_16_0.closeBgmLeadSinger, arg_16_0)
end

function var_0_0._generalOnClick(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0, var_17_1, var_17_2 = ActivityHelper.getActivityStatusAndToast(arg_17_1)

	if var_17_0 == ActivityEnum.ActivityStatus.Normal or var_17_0 == ActivityEnum.ActivityStatus.NotUnlock then
		if arg_17_3 then
			arg_17_3(arg_17_4)
		end

		arg_17_2.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, arg_17_1, arg_17_0)
	end

	if var_17_1 then
		GameFacade.showToastWithTableParam(var_17_1, var_17_2)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

return var_0_0
