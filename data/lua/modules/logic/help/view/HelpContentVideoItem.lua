module("modules.logic.help.view.HelpContentVideoItem", package.seeall)

local var_0_0 = class("HelpContentVideoItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "#go_center")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_center/ScrollView/Viewport/Content/#txt_desc")
	arg_1_0._btnstoryPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_center/#btn_storyPlay")
	arg_1_0._btnvideoplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_center/#btn_videoplay")
	arg_1_0._gocontentvideo = gohelper.findChild(arg_1_0.viewGO, "#go_contentvideo")
	arg_1_0._govideo = gohelper.findChild(arg_1_0.viewGO, "#go_contentvideo/#go_video")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_contentvideo/#btn_start")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_contentvideo/#go_bottom")
	arg_1_0._btnpaused = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_contentvideo/#go_bottom/#btn_paused")
	arg_1_0._btnfullScreen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen")
	arg_1_0._goiconFull = gohelper.findChild(arg_1_0.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen/#go_iconFull")
	arg_1_0._goiconSmall = gohelper.findChild(arg_1_0.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen/#go_iconSmall")
	arg_1_0._slidertime = gohelper.findChildSlider(arg_1_0.viewGO, "#go_contentvideo/#go_bottom/#slider_time")
	arg_1_0._txtvideoTime = gohelper.findChildText(arg_1_0.viewGO, "#go_contentvideo/#go_bottom/#txt_videoTime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstoryPlay:AddClickListener(arg_2_0._btnstoryPlayOnClick, arg_2_0)
	arg_2_0._btnvideoplay:AddClickListener(arg_2_0._btnvideoplayOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnpaused:AddClickListener(arg_2_0._btnpausedOnClick, arg_2_0)
	arg_2_0._btnfullScreen:AddClickListener(arg_2_0._btnfullScreenOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstoryPlay:RemoveClickListener()
	arg_3_0._btnvideoplay:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnpaused:RemoveClickListener()
	arg_3_0._btnfullScreen:RemoveClickListener()
end

function var_0_0._btnstoryPlayOnClick(arg_4_0)
	if arg_4_0._helpVideoCfg and arg_4_0._helpVideoCfg.storyId ~= 0 then
		StoryController.instance:playStory(arg_4_0._helpVideoCfg.storyId)
	end
end

function var_0_0._btnfullScreenOnClick(arg_5_0)
	arg_5_0:_showFullScreen(arg_5_0._isLastIsFullScreen ~= true)
end

function var_0_0._btnpausedOnClick(arg_6_0)
	if arg_6_0._videoPlayer and arg_6_0._videoPlayer:IsPlaying() then
		arg_6_0._videoPlayer:Pause()
		arg_6_0:_stopSlideTimeTween()
		arg_6_0:_showPlayIcon(true)
	end
end

function var_0_0._btnvideoplayOnClick(arg_7_0)
	arg_7_0:play()
end

function var_0_0._slidertimeOnValueChange(arg_8_0, arg_8_1)
	if arg_8_0._isDotweenSet then
		return
	end

	if arg_8_0._videoPlayer:IsPlaying() then
		arg_8_0._videoPlayer:Pause()
		arg_8_0:_showPlayIcon(true)
	end

	arg_8_0:_stopSlideTimeTween()

	local var_8_0 = arg_8_0._slidertime:GetValue()

	arg_8_0._curTime = arg_8_0._startTime + arg_8_0._duration * var_8_0

	arg_8_0._videoPlayer:Seek(arg_8_0._curTime)
	arg_8_0:_setVoideTime(arg_8_0._curTime, arg_8_0._duration)
end

function var_0_0._btnstartOnClick(arg_9_0)
	if arg_9_0._videoPlayer then
		if arg_9_0._lastVideoId == nil then
			logNormal(":_btnstartOnClick() isnew")
			arg_9_0:play()
		elseif arg_9_0._videoPlayer:IsPaused() then
			logNormal(":_btnstartOnClick() isPaused")
			arg_9_0._videoPlayer:Play()
		elseif arg_9_0._videoPlayer:IsPlaying() then
			logNormal(":_btnstartOnClick() IsPlaying")
			arg_9_0._videoPlayer:Pause()
			arg_9_0:_stopSlideTimeTween()
			arg_9_0:_showPlayIcon(true)
		elseif arg_9_0._videoPlayer:IsFinished() then
			logNormal(":_btnstartOnClick() IsFinished")
			arg_9_0._videoPlayer:Play()
		end
	else
		arg_9_0:play()
		logNormal(":_btnstartOnClick() play")
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._govideoTrs = arg_10_0._govideo.transform
	arg_10_0._gocontentvideoTrs = arg_10_0._gocontentvideo.transform

	gohelper.setActive(arg_10_0._btnpaused, false)

	arg_10_0._goplayIcon = gohelper.findChild(arg_10_0.viewGO, "#go_contentvideo/#btn_start/image")
	arg_10_0._isDotweenSet = false
	arg_10_0._isLastIsFullScreen = false

	gohelper.setActive(arg_10_0._goiconSmall, false)

	local var_10_0 = recthelper.getWidth(arg_10_0._gocontentvideoTrs)
	local var_10_1 = recthelper.getHeight(arg_10_0._gocontentvideoTrs)
	local var_10_2, var_10_3 = recthelper.getAnchor(arg_10_0._gocontentvideoTrs)

	arg_10_0._curRectParam = {
		width = var_10_0,
		height = var_10_1,
		anchorX = var_10_2,
		anchorY = var_10_3
	}
end

function var_0_0._editableAddEvents(arg_11_0)
	arg_11_0._slidertime:AddOnValueChanged(arg_11_0._slidertimeOnValueChange, arg_11_0)
end

function var_0_0._editableRemoveEvents(arg_12_0)
	arg_12_0._slidertime:RemoveOnValueChanged()
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	arg_13_0._helpVideoCfg = arg_13_1
	arg_13_0._startTime = 0
	arg_13_0._duration = 0
	arg_13_0._curTime = 0

	arg_13_0:_refreshUI()

	if arg_13_0._videoPlayer then
		arg_13_0._lastVideoId = nil

		arg_13_0._videoPlayer:Stop()
		arg_13_0:_stopSlideTimeTween()
		gohelper.setActive(arg_13_0._gocontentvideo, false)
	end
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._videoPlayer then
		arg_15_0._videoPlayer:Stop()
		arg_15_0._videoPlayer:Clear()

		arg_15_0._videoPlayer = nil
	end

	arg_15_0:_stopSlideTimeTween()
end

function var_0_0._refreshUI(arg_16_0)
	if arg_16_0._helpVideoCfg then
		arg_16_0._txtdesc.text = arg_16_0._helpVideoCfg.text
	end

	gohelper.setActive(arg_16_0._btnstoryPlay, arg_16_0._helpVideoCfg and arg_16_0._helpVideoCfg.storyId and arg_16_0._helpVideoCfg.storyId ~= 0)
end

function var_0_0.getIsFullScreen(arg_17_0)
	return arg_17_0._isLastIsFullScreen
end

function var_0_0._showFullScreen(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 and true or false

	if arg_18_0._isLastIsFullScreen == var_18_0 then
		return
	end

	arg_18_0._isLastIsFullScreen = var_18_0

	local var_18_1 = arg_18_0._curRectParam.width
	local var_18_2 = arg_18_0._curRectParam.height
	local var_18_3 = arg_18_0._curRectParam.anchorX
	local var_18_4 = arg_18_0._curRectParam.anchorY

	if var_18_0 then
		var_18_3 = 0
		var_18_4 = 0
		var_18_1 = UnityEngine.Screen.width
		var_18_2 = UnityEngine.Screen.height
	end

	recthelper.setSize(arg_18_0._gocontentvideoTrs, var_18_1, var_18_2)
	recthelper.setAnchor(arg_18_0._gocontentvideoTrs, var_18_3, var_18_4)

	if arg_18_0._isInitVideoPlayer then
		recthelper.setSize(arg_18_0._videoPlayerGOTrs, var_18_1, var_18_2)
	end

	gohelper.setActive(arg_18_0._goiconFull, not var_18_0)
	gohelper.setActive(arg_18_0._goiconSmall, var_18_0)

	if arg_18_0._view and arg_18_0._view.viewContainer then
		arg_18_0._view.viewContainer:dispatchEvent(HelpEvent.UIVoideFullScreenChange, var_18_0)
	end
end

function var_0_0._showPlayIcon(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goplayIcon, arg_19_1)
end

function var_0_0._initVideoPlayer(arg_20_0)
	if not arg_20_0._isInitVideoPlayer then
		arg_20_0._isInitVideoPlayer = true
		arg_20_0._videoPlayer, arg_20_0._displauUGUI, arg_20_0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(arg_20_0._govideo)
		arg_20_0._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleToFit
		arg_20_0._videoPlayerGOTrs = arg_20_0._videoPlayerGO.transform

		arg_20_0:_updateVideoSize()
	end
end

function var_0_0._updateVideoSize(arg_21_0)
	arg_21_0:_initVideoPlayer()

	local var_21_0 = recthelper.getWidth(arg_21_0._gocontentvideoTrs)
	local var_21_1 = recthelper.getHeight(arg_21_0._gocontentvideoTrs)

	recthelper.setSize(arg_21_0._videoPlayerGOTrs, var_21_0, var_21_1)
end

function var_0_0.play(arg_22_0)
	arg_22_0:_initVideoPlayer()

	arg_22_0._lastVideoId = arg_22_0._helpVideoCfg.id

	arg_22_0._videoPlayer:Play(arg_22_0._displauUGUI, arg_22_0._helpVideoCfg.videopath, false, arg_22_0._videoStatusUpdate, arg_22_0)
	gohelper.setActive(arg_22_0._gocontentvideo, true)
end

function var_0_0.stop(arg_23_0)
	if arg_23_0._videoPlayer then
		arg_23_0._videoPlayer:Stop()
	end
end

function var_0_0._videoStatusUpdate(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_24_0:_showPlayIcon(true)
	elseif arg_24_2 == AvProEnum.PlayerStatus.FirstFrameReady then
		-- block empty
	elseif arg_24_2 == AvProEnum.PlayerStatus.Started then
		arg_24_0:_showPlayIcon(false)
	elseif arg_24_2 == AvProEnum.PlayerStatus.StartedSeeking then
		-- block empty
	end

	arg_24_0._startTime, arg_24_0._duration, arg_24_0._curTime = arg_24_0._videoPlayer:GetTimeRange(0, 0, 0)

	if arg_24_0._videoPlayer:IsPlaying() then
		arg_24_0:_startSlideTimeTween()
	else
		arg_24_0:_stopSlideTimeTween()
	end

	logNormal(string.format("status:%s name:%s timeRange(%s,%s,%s) ", arg_24_2, AvProEnum.getPlayerStatusEnumName(arg_24_2), arg_24_0._startTime, arg_24_0._duration, arg_24_0._curTime))
end

function var_0_0._stopSlideTimeTween(arg_25_0)
	if arg_25_0._slideTimeTweenId then
		ZProj.TweenHelper.KillById(arg_25_0._slideTimeTweenId)

		arg_25_0._slideTimeTweenId = nil
	end
end

function var_0_0._startSlideTimeTween(arg_26_0)
	arg_26_0:_stopSlideTimeTween()

	local var_26_0 = math.max(0, arg_26_0._curTime - arg_26_0._startTime)
	local var_26_1 = math.max(0, arg_26_0._duration - var_26_0)
	local var_26_2 = 1

	if var_26_1 ~= 0 then
		var_26_2 = var_26_0 / arg_26_0._duration
	end

	logNormal(string.format("time:(%s,%s) ftd(%s,%s,%s) ", var_26_0, arg_26_0._duration, var_26_2, 1, var_26_1))

	arg_26_0._slideTimeTweenId = ZProj.TweenHelper.DOTweenFloat(var_26_2, 1, var_26_1, arg_26_0._onSlideTimeframeCallback, arg_26_0._onOpenTweenFinishCallback, arg_26_0, nil, EaseType.Linear)
end

function var_0_0._onSlideTimeframeCallback(arg_27_0, arg_27_1)
	arg_27_0._isDotweenSet = true

	arg_27_0._slidertime:SetValue(arg_27_1)

	arg_27_0._isDotweenSet = false

	arg_27_0:_setVoideTime(arg_27_0._duration * arg_27_1, arg_27_0._duration)
end

function var_0_0._setVoideTime(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = math.floor(arg_28_1)
	local var_28_1 = math.floor(arg_28_2)

	if arg_28_0._lastRunTime_ ~= var_28_0 or arg_28_0._lastDuration_ ~= var_28_1 then
		arg_28_0._lastRunTime_ = var_28_0
		arg_28_0._lastDuration_ = var_28_1
		arg_28_0._txtvideoTime.text = arg_28_0:_formatTime(var_28_0) .. "/" .. arg_28_0:_formatTime(var_28_1)
	end
end

function var_0_0._formatTime(arg_29_0, arg_29_1)
	local var_29_0, var_29_1, var_29_2 = TimeUtil.secondToHMS(arg_29_1)

	return string.format("%s:%s:%s", arg_29_0:_formatNum(var_29_0), arg_29_0:_formatNum(var_29_1), arg_29_0:_formatNum(var_29_2))
end

function var_0_0._formatNum(arg_30_0, arg_30_1)
	if arg_30_1 >= 10 then
		return arg_30_1
	end

	return "0" .. arg_30_1
end

return var_0_0
