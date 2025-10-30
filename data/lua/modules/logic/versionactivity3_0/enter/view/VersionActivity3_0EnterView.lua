module("modules.logic.versionactivity3_0.enter.view.VersionActivity3_0EnterView", package.seeall)

local var_0_0 = class("VersionActivity3_0EnterView", VersionActivityEnterBaseViewWithListNew)
local var_0_1 = 2.1

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._scrolltab = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab")
	arg_1_0._scroll = arg_1_0._scrolltab:GetComponent(gohelper.Type_ScrollRect)
	arg_1_0.goArrowRedDot = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local var_1_0 = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	arg_1_0.viewPortHeight = recthelper.getHeight(var_1_0)
	arg_1_0.viewPortWidth = recthelper.getWidth(var_1_0)
	arg_1_0.rectTrContent = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	arg_1_0._gotabitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	arg_1_0._gotabitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	arg_1_0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, arg_1_0._gotabitem1, VersionActivity3_0EnterViewTabItem1)
	arg_1_0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, arg_1_0._gotabitem2, VersionActivity3_0EnterViewTabItem2)
	arg_1_0:setActivityLineGo(arg_1_0._goline)

	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._btnachievementnormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievement_normal")
	arg_1_0._btnachievementpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievementpreview")
	arg_1_0.goReplayBtn = arg_1_0._btnreplay.gameObject
	arg_1_0.goAchievementBtn = arg_1_0._btnachievementpreview.gameObject
	arg_1_0.viewAnim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.gosubviewCanvasGroup = gohelper.findChildComponent(arg_1_0.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function var_0_0.childAddEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnreplayOnClick, arg_2_0)
	arg_2_0._btnachievementnormal:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
	arg_2_0._btnachievementpreview:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
	arg_2_0._scrolltab:AddOnValueChanged(arg_2_0._onTabScrollChange, arg_2_0)
	arg_2_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshRedDot, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.childRemoveEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnachievementnormal:RemoveClickListener()
	arg_3_0._btnachievementpreview:RemoveClickListener()
	arg_3_0._scrolltab:RemoveOnValueChanged()
	arg_3_0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshRedDot, arg_3_0)
end

function var_0_0.moveContent(arg_4_0, arg_4_1)
	local var_4_0 = recthelper.getWidth(arg_4_0._scrolltab.transform)
	local var_4_1 = recthelper.getWidth(arg_4_0.rectTrContent)
	local var_4_2 = -(recthelper.getAnchorX(arg_4_1.go.transform) - recthelper.getWidth(arg_4_1.go.transform) / 2)
	local var_4_3 = math.min(0, math.max(var_4_0 - var_4_1, var_4_2))

	recthelper.setAnchorX(arg_4_0.rectTrContent, var_4_3)
end

function var_0_0._btnreplayOnClick(arg_5_0)
	local var_5_0 = ActivityModel.instance:getActMO(arg_5_0.curActId)
	local var_5_1 = var_5_0 and var_5_0.config and var_5_0.config.storyId

	if not var_5_1 or var_5_1 == 0 then
		logError(string.format("act id %s dot config story id", arg_5_0.curActId))

		return
	end

	local var_5_2 = {}

	var_5_2.isVersionActivityPV = true

	StoryController.instance:playStory(var_5_1, var_5_2)
end

function var_0_0._btnachievementpreviewOnClick(arg_6_0)
	local var_6_0 = ActivityConfig.instance:getActivityCo(arg_6_0.curActId)
	local var_6_1 = var_6_0 and var_6_0.achievementJumpId

	JumpController.instance:jump(var_6_1)
end

function var_0_0._onTabScrollChange(arg_7_0)
	if arg_7_0._scroll.horizontal then
		arg_7_0:_checkHorizontalScroll()
	else
		arg_7_0:_checkVerticalScroll()
	end
end

function var_0_0._checkHorizontalScroll(arg_8_0)
	local var_8_0 = recthelper.getAnchorX(arg_8_0.rectTrContent)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.activityTabItemList) do
		if iter_8_1:isShowRedDot() and -iter_8_1:getAnchorX() + iter_8_1:getWidth() / 2 - VersionActivity3_0Enum.RedDotOffsetX - var_8_0 < -arg_8_0.viewPortWidth then
			gohelper.setActive(arg_8_0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(arg_8_0.goArrowRedDot, false)
end

function var_0_0._checkVerticalScroll(arg_9_0)
	local var_9_0 = recthelper.getAnchorY(arg_9_0.rectTrContent)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.activityTabItemList) do
		if iter_9_1:isShowRedDot() and -iter_9_1:getAnchorY() + VersionActivity3_0Enum.RedDotOffsetY - var_9_0 > arg_9_0.viewPortHeight then
			gohelper.setActive(arg_9_0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(arg_9_0.goArrowRedDot, false)
end

function var_0_0.refreshRedDot(arg_10_0)
	arg_10_0:_onTabScrollChange()
end

function var_0_0.refreshBtnVisible(arg_11_0, arg_11_1)
	local var_11_0 = VersionActivity3_0EnterHelper.GetIsShowReplayBtn(arg_11_0.curActId)
	local var_11_1 = VersionActivity3_0EnterHelper.GetIsShowAchievementBtn(arg_11_0.curActId)

	gohelper.setActive(arg_11_0.goReplayBtn, var_11_0)
	gohelper.setActive(arg_11_0.goAchievementBtn, var_11_1)
end

function var_0_0.onOpen(arg_12_0)
	var_0_0.super.onOpen(arg_12_0)

	local var_12_0 = arg_12_0.viewParam.jumpActId

	if var_12_0 and arg_12_0.activityTabItemList then
		local var_12_1 = arg_12_0:_getActTabIndex(var_12_0) or VersionActivityEnterHelper.getTabIndex(arg_12_0.activitySettingList, var_12_0)
		local var_12_2 = 0
		local var_12_3 = 3
		local var_12_4 = #arg_12_0.activityTabItemList or 1
		local var_12_5 = var_12_1 <= var_12_3 and 0 or var_12_1 >= var_12_4 - var_12_3 and 1 or GameUtil.clamp(var_12_1 / var_12_4, 0, 1)

		arg_12_0._scrolltab.horizontalNormalizedPosition = var_12_5
	end
end

function var_0_0._getActTabIndex(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.activityTabItemList) do
		if iter_13_1.actId == arg_13_1 then
			return gohelper.getSibling(iter_13_1.go)
		end
	end

	return 0
end

function var_0_0._playOpenAnim(arg_14_0, arg_14_1)
	if not string.nilorempty(arg_14_1) then
		arg_14_0.viewAnim:Play(arg_14_1, 0, 0)
	else
		arg_14_0.viewAnim:Play(UIAnimationName.Open, 0, 0)
		arg_14_0.viewContainer:markPlayedSubViewAnim()
	end
end

local var_0_2 = 5

function var_0_0.playVideo(arg_15_0)
	if arg_15_0.viewParam and arg_15_0.viewParam.playVideo then
		AudioMgr.instance:trigger(AudioEnum3_0.VersionActivity3_0Enter.play_ui_lushang_open_1)

		arg_15_0.viewAnim.speed = 0

		VideoController.instance:openFullScreenVideoView(langVideoUrl(VersionActivity3_0Enum.EnterAnimVideoName), nil, var_0_2)
		TimeUtil.setDayFirstLoginRed(VersionActivity3_0Enum.EnterVideoDayKey)
		arg_15_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_15_0.onPlayVideoDone, arg_15_0)
		arg_15_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_15_0.onPlayVideoDone, arg_15_0)
	else
		arg_15_0.viewAnim.speed = 1

		arg_15_0:_playOpenAnim()
	end
end

function var_0_0.onPlayVideoDone(arg_16_0)
	arg_16_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_16_0.onPlayVideoDone, arg_16_0)
	arg_16_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_16_0.onPlayVideoDone, arg_16_0)

	arg_16_0.viewAnim.speed = 1

	arg_16_0:_playOpenAnim("open1")
end

return var_0_0
