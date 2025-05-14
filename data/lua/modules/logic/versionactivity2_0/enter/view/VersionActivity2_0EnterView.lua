module("modules.logic.versionactivity2_0.enter.view.VersionActivity2_0EnterView", package.seeall)

local var_0_0 = class("VersionActivity2_0EnterView", VersionActivityEnterBaseViewWithListNew)
local var_0_1 = 2.1

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._scrolltab = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab")
	arg_1_0.goArrowRedDot = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local var_1_0 = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	arg_1_0.viewPortHeight = recthelper.getHeight(var_1_0)
	arg_1_0.rectTrContent = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	arg_1_0._gotabitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	arg_1_0._gotabitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	arg_1_0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, arg_1_0._gotabitem1, VersionActivity2_0EnterViewTabItem1)
	arg_1_0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, arg_1_0._gotabitem2, VersionActivity2_0EnterViewTabItem2)
	arg_1_0:setActivityLineGo(arg_1_0._goline)

	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._btnachievementpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievementpreview")
	arg_1_0.goReplayBtn = arg_1_0._btnreplay.gameObject
	arg_1_0.goAchievementBtn = arg_1_0._btnachievementpreview.gameObject
	arg_1_0.entranceAnim = gohelper.findChildComponent(arg_1_0.viewGO, "entrance", gohelper.Type_Animator)
	arg_1_0.tabAnim = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer", gohelper.Type_Animator)
	arg_1_0.viewAnim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.gosubviewCanvasGroup = gohelper.findChildComponent(arg_1_0.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.childAddEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnreplayOnClick, arg_2_0)
	arg_2_0._btnachievementpreview:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
	arg_2_0._scrolltab:AddOnValueChanged(arg_2_0._onTabScrollChange, arg_2_0)
	arg_2_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshRedDot, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_2_0.selectAct, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.childRemoveEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnachievementpreview:RemoveClickListener()
	arg_3_0._scrolltab:RemoveOnValueChanged()
	arg_3_0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_3_0.selectAct, arg_3_0, LuaEventSystem.Low)
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
		if iter_6_1:isShowRedDot() and -iter_6_1:getAnchorY() + VersionActivity2_0Enum.RedDotOffsetY - var_6_0 > arg_6_0.viewPortHeight then
			gohelper.setActive(arg_6_0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(arg_6_0.goArrowRedDot, false)
end

function var_0_0.playVideo(arg_7_0)
	arg_7_0.tabAnim:Play(UIAnimationName.Open, 0, 0)
	arg_7_0.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	arg_7_0.viewAnim:Play("open1", 0, 0)

	if arg_7_0.viewParam.playVideo then
		arg_7_0.tabAnim.speed = 0
		arg_7_0.entranceAnim.speed = 0
		arg_7_0.gosubviewCanvasGroup.alpha = 0

		VideoController.instance:openFullScreenVideoView(VersionActivity2_0Enum.EnterAnimVideoPath, nil, var_0_1)
		arg_7_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_7_0.onPlayVideoDone, arg_7_0)
		arg_7_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_7_0.onPlayVideoDone, arg_7_0)
	else
		arg_7_0.tabAnim.speed = 1
		arg_7_0.entranceAnim.speed = 1
		arg_7_0.gosubviewCanvasGroup.alpha = 1

		arg_7_0:onPlayVideoDone()
	end
end

function var_0_0.onPlayVideoDone(arg_8_0)
	arg_8_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_8_0.onPlayVideoDone, arg_8_0)
	arg_8_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_8_0.onPlayVideoDone, arg_8_0)

	arg_8_0.tabAnim.speed = 1

	arg_8_0.tabAnim:Play(UIAnimationName.Open, 0, 0)

	arg_8_0.entranceAnim.speed = 1

	arg_8_0.entranceAnim:Play(UIAnimationName.Open, 0, 0)

	arg_8_0.gosubviewCanvasGroup.alpha = 1
end

function var_0_0.refreshRedDot(arg_9_0)
	arg_9_0:_onTabScrollChange()
end

function var_0_0.refreshBtnVisible(arg_10_0, arg_10_1)
	local var_10_0 = VersionActivity2_0EnterHelper.GetIsShowReplayBtn(arg_10_0.curActId)
	local var_10_1 = VersionActivity2_0EnterHelper.GetIsShowAchievementBtn(arg_10_0.curActId)

	gohelper.setActive(arg_10_0.goReplayBtn, var_10_0)
	gohelper.setActive(arg_10_0.goAchievementBtn, var_10_1)

	if arg_10_1 then
		return
	end

	if var_10_0 or var_10_1 then
		arg_10_0.entranceAnim.speed = 1

		arg_10_0.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.selectAct(arg_11_0)
	arg_11_0.viewAnim:Play(UIAnimationName.Open, 0, 0)
	arg_11_0.viewContainer:markPlayedSubViewAnim()
end

return var_0_0
