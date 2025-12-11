module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterView", package.seeall)

local var_0_0 = class("VersionActivity3_1EnterView", VersionActivityFixedEnterView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._scrolltab = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab")
	arg_1_0.goArrowRedDot = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local var_1_0 = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	arg_1_0.viewPortHeight = recthelper.getHeight(var_1_0)
	arg_1_0.rectTrContent = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	arg_1_0._gotabitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	arg_1_0._gotabitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	arg_1_0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, arg_1_0._gotabitem1, VersionActivity3_1EnterViewTabItem1)
	arg_1_0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, arg_1_0._gotabitem2, VersionActivity3_1EnterViewTabItem2)
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

function var_0_0.onOpen(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.tabLevelSetting) do
		local var_2_0 = iter_2_1.go

		gohelper.setActive(var_2_0, false)
	end

	gohelper.setActive(arg_2_0._goActivityLine, false)
	arg_2_0:initViewParam()
	arg_2_0:createActivityTabItem()

	if arg_2_0.curActId == VersionActivity3_1Enum.ActivityId.Dungeon and not arg_2_0.viewParam.isExitFight then
		arg_2_0:playVideo()
	end

	arg_2_0:refreshUI()
	arg_2_0:refreshRedDot()
	arg_2_0:refreshBtnVisible(true)
end

local var_0_1 = 8

function var_0_0.playVideo(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._playOpen1Anim, arg_3_0)

	if arg_3_0.viewParam and arg_3_0.viewParam.playVideo then
		arg_3_0.viewAnim:Play("open1", 0, 0)

		arg_3_0.viewAnim.speed = 0
		arg_3_0.cgviewgo = arg_3_0.viewGO:GetComponent(gohelper.Type_CanvasGroup)

		if arg_3_0.cgviewgo then
			arg_3_0.cgviewgo.interactable = false
		end

		arg_3_0.gosubviewCanvasGroup.alpha = 0

		AudioMgr.instance:trigger(AudioEnum3_1.VersionActivity3_1Enter.play_ui_mingdi_video)
		VideoController.instance:openFullScreenVideoView(langVideoUrl(VersionActivity3_1Enum.EnterAnimVideoName), nil, var_0_1)
		TimeUtil.setDayFirstLoginRed(VersionActivity3_1Enum.EnterVideoDayKey)
		arg_3_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_3_0.onPlayVideoDone, arg_3_0)
		arg_3_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_3_0.onPlayVideoDone, arg_3_0)
		arg_3_0:addEventCb(VideoController.instance, VideoEvent.OnVideoStarted, arg_3_0._delayPlayOpen1Anim, arg_3_0)
	else
		arg_3_0.viewAnim.speed = 1

		arg_3_0:_playOpenAnim()
	end
end

function var_0_0.onPlayVideoDone(arg_4_0)
	arg_4_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_4_0.onPlayVideoDone, arg_4_0)
	arg_4_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_4_0.onPlayVideoDone, arg_4_0)

	arg_4_0.gosubviewCanvasGroup.alpha = 1

	if arg_4_0.cgviewgo then
		arg_4_0.cgviewgo.interactable = true
	end

	if arg_4_0.viewAnim.speed == 1 then
		return
	end

	arg_4_0:_playOpen1Anim()
end

function var_0_0._delayPlayOpen1Anim(arg_5_0)
	if arg_5_0.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(arg_5_0._playOpen1Anim, arg_5_0, 4)
	arg_5_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoStarted, arg_5_0._delayPlayOpen1Anim, arg_5_0)
end

function var_0_0._playOpen1Anim(arg_6_0)
	arg_6_0.gosubviewCanvasGroup.alpha = 1
	arg_6_0.viewAnim.speed = 1

	arg_6_0:_playOpenAnim("open1")
end

function var_0_0._playOpenAnim(arg_7_0, arg_7_1)
	if not string.nilorempty(arg_7_1) then
		arg_7_0.viewAnim:Play(arg_7_1, 0, 0)
	else
		arg_7_0.viewAnim:Play(UIAnimationName.Open, 0, 0)
		arg_7_0.viewContainer:markPlayedSubViewAnim()
	end
end

function var_0_0.onDestroyView(arg_8_0)
	var_0_0.super.onDestroyView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._playOpen1Anim, arg_8_0)
end

return var_0_0
