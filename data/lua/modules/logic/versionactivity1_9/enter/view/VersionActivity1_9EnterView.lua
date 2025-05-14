module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterView", package.seeall)

local var_0_0 = class("VersionActivity1_9EnterView", VersionActivityEnterBaseViewWithList1_9)
local var_0_1 = 2.1

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._tabScrollRect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnReplayOnClick, arg_2_0)
	arg_2_0._tabScrollRect:AddOnValueChanged(arg_2_0._onScrollChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._tabScrollRect:RemoveOnValueChanged()
end

function var_0_0._btnachievementpreviewOnClick(arg_4_0)
	local var_4_0 = ActivityConfig.instance:getActivityCo(arg_4_0.curActId)
	local var_4_1 = var_4_0 and var_4_0.achievementJumpId

	JumpController.instance:jump(var_4_1)
end

function var_0_0._btnReplayOnClick(arg_5_0)
	local var_5_0 = ActivityModel.instance:getActMO(arg_5_0.curActId)
	local var_5_1 = var_5_0 and var_5_0.config and var_5_0.config.storyId

	if not var_5_1 then
		logError(string.format("act id %s dot config story id", var_5_1))

		return
	end

	local var_5_2 = {}

	var_5_2.isVersionActivityPV = true

	StoryController.instance:playStory(var_5_1, var_5_2)
end

function var_0_0._onScrollChange(arg_6_0)
	local var_6_0 = recthelper.getAnchorY(arg_6_0.rectTrContent)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.activityTabItemList) do
		if iter_6_1:isShowRedDot() and -iter_6_1:getAnchorY() + VersionActivity1_9Enum.RedDotOffsetY - var_6_0 > arg_6_0.viewPortHeight then
			gohelper.setActive(arg_6_0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(arg_6_0.goArrowRedDot, false)
end

function var_0_0._editableInitView(arg_7_0)
	var_0_0.super._editableInitView(arg_7_0)

	arg_7_0.goReplayBtn = arg_7_0._btnreplay.gameObject
	arg_7_0.tabAnim = gohelper.findChildComponent(arg_7_0.viewGO, "#go_tabcontainer", gohelper.Type_Animator)
	arg_7_0.entranceAnim = gohelper.findChildComponent(arg_7_0.viewGO, "entrance", gohelper.Type_Animator)
	arg_7_0.goArrowRedDot = gohelper.findChild(arg_7_0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")
	arg_7_0.rectTrContent = gohelper.findChildComponent(arg_7_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)

	local var_7_0 = gohelper.findChildComponent(arg_7_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	arg_7_0.viewPortHeight = recthelper.getHeight(var_7_0)
	arg_7_0._btnAchievementDict = arg_7_0:getUserDataTb_()

	for iter_7_0, iter_7_1 in pairs(VersionActivity1_9Enum.AchievementBtnType) do
		arg_7_0._btnAchievementDict[iter_7_1] = gohelper.findChildButtonWithAudio(arg_7_0.viewGO, "entrance/" .. iter_7_1)

		arg_7_0:addClickCb(arg_7_0._btnAchievementDict[iter_7_1], arg_7_0._btnachievementpreviewOnClick, arg_7_0)
	end

	arg_7_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_7_0.refreshRedDot, arg_7_0, LuaEventSystem.Low)
end

function var_0_0.refreshRedDot(arg_8_0)
	arg_8_0:_onScrollChange()
end

function var_0_0.onOpen(arg_9_0)
	var_0_0.super.onOpen(arg_9_0)
	arg_9_0:refreshBtnVisible()
	arg_9_0:_onScrollChange()
	arg_9_0:playVideo()
end

function var_0_0.playVideo(arg_10_0)
	if arg_10_0.viewParam.skipOpenAnim then
		arg_10_0.tabAnim:Play(UIAnimationName.Open, 0, 1)
		arg_10_0.entranceAnim:Play(UIAnimationName.Open, 0, 1)
	elseif arg_10_0.viewParam.playVideo then
		arg_10_0.tabAnim:Play(UIAnimationName.Open, 0, 0)
		arg_10_0.entranceAnim:Play(UIAnimationName.Open, 0, 0)

		arg_10_0.tabAnim.speed = 0
		arg_10_0.entranceAnim.speed = 0

		VideoController.instance:openFullScreenVideoView(langVideoUrl("1_9_enter"), nil, var_0_1)
		arg_10_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_10_0.onPlayVideoDone, arg_10_0)
		arg_10_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_10_0.onPlayVideoDone, arg_10_0)
	else
		arg_10_0.tabAnim:Play(UIAnimationName.Open, 0, 0)
		arg_10_0.entranceAnim:Play(UIAnimationName.Open, 0, 0)

		arg_10_0.tabAnim.speed = 1
		arg_10_0.entranceAnim.speed = 1
	end
end

function var_0_0.onPlayVideoDone(arg_11_0)
	arg_11_0.tabAnim.speed = 1
	arg_11_0.entranceAnim.speed = 1

	arg_11_0.tabAnim:Play(UIAnimationName.Open, 0, 0)
	arg_11_0.entranceAnim:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.onSelectActId(arg_12_0, ...)
	var_0_0.super.onSelectActId(arg_12_0, ...)
	arg_12_0:refreshBtnVisible()
end

function var_0_0.refreshBtnVisible(arg_13_0)
	local var_13_0 = VersionActivity1_9Enum.ActId2ShowReplayBtnDict[arg_13_0.curActId]
	local var_13_1 = VersionActivity1_9Enum.ActId2ShowAchievementBtnDict[arg_13_0.curActId]

	gohelper.setActive(arg_13_0.goReplayBtn, var_13_0)
	gohelper.setActive(arg_13_0.goAchievementBtn, var_13_1)

	for iter_13_0, iter_13_1 in pairs(VersionActivity1_9Enum.AchievementBtnType) do
		gohelper.setActive(arg_13_0._btnAchievementDict[iter_13_1], iter_13_1 == var_13_1)
	end

	if var_13_0 or var_13_1 then
		arg_13_0.entranceAnim.speed = 1

		arg_13_0.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.onClickActivity11704(arg_14_0, arg_14_1)
	local var_14_0 = VersionActivity1_9Enum.ActivityId.BossRush
	local var_14_1, var_14_2, var_14_3 = ActivityHelper.getActivityStatusAndToast(var_14_0)

	if var_14_1 == ActivityEnum.ActivityStatus.Normal or var_14_1 == ActivityEnum.ActivityStatus.NotUnlock then
		V1a6_BossRush_StoreModel.instance:checkUpdateStoreNewActivity()
		arg_14_1.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, var_14_0, arg_14_0)
	end

	if var_14_2 then
		GameFacade.showToastWithTableParam(var_14_2, var_14_3)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

return var_0_0
