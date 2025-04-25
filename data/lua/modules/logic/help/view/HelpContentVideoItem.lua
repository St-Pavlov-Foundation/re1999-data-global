module("modules.logic.help.view.HelpContentVideoItem", package.seeall)

slot0 = class("HelpContentVideoItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "#go_center")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_center/ScrollView/Viewport/Content/#txt_desc")
	slot0._btnstoryPlay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_center/#btn_storyPlay")
	slot0._btnvideoplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_center/#btn_videoplay")
	slot0._gocontentvideo = gohelper.findChild(slot0.viewGO, "#go_contentvideo")
	slot0._govideo = gohelper.findChild(slot0.viewGO, "#go_contentvideo/#go_video")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_contentvideo/#btn_start")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "#go_contentvideo/#go_bottom")
	slot0._btnpaused = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_contentvideo/#go_bottom/#btn_paused")
	slot0._btnfullScreen = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen")
	slot0._goiconFull = gohelper.findChild(slot0.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen/#go_iconFull")
	slot0._goiconSmall = gohelper.findChild(slot0.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen/#go_iconSmall")
	slot0._slidertime = gohelper.findChildSlider(slot0.viewGO, "#go_contentvideo/#go_bottom/#slider_time")
	slot0._txtvideoTime = gohelper.findChildText(slot0.viewGO, "#go_contentvideo/#go_bottom/#txt_videoTime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstoryPlay:AddClickListener(slot0._btnstoryPlayOnClick, slot0)
	slot0._btnvideoplay:AddClickListener(slot0._btnvideoplayOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnpaused:AddClickListener(slot0._btnpausedOnClick, slot0)
	slot0._btnfullScreen:AddClickListener(slot0._btnfullScreenOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstoryPlay:RemoveClickListener()
	slot0._btnvideoplay:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnpaused:RemoveClickListener()
	slot0._btnfullScreen:RemoveClickListener()
end

function slot0._btnstoryPlayOnClick(slot0)
	if slot0._helpVideoCfg and slot0._helpVideoCfg.storyId ~= 0 then
		StoryController.instance:playStory(slot0._helpVideoCfg.storyId)
	end
end

function slot0._btnfullScreenOnClick(slot0)
	slot0:_showFullScreen(slot0._isLastIsFullScreen ~= true)
end

function slot0._btnpausedOnClick(slot0)
	if slot0._videoPlayer and slot0._videoPlayer:IsPlaying() then
		slot0._videoPlayer:Pause()
		slot0:_stopSlideTimeTween()
		slot0:_showPlayIcon(true)
	end
end

function slot0._btnvideoplayOnClick(slot0)
	slot0:play()
end

function slot0._slidertimeOnValueChange(slot0, slot1)
	if slot0._isDotweenSet then
		return
	end

	if slot0._videoPlayer:IsPlaying() then
		slot0._videoPlayer:Pause()
		slot0:_showPlayIcon(true)
	end

	slot0:_stopSlideTimeTween()

	slot0._curTime = slot0._startTime + slot0._duration * slot0._slidertime:GetValue()

	slot0._videoPlayer:Seek(slot0._curTime)
	slot0:_setVoideTime(slot0._curTime, slot0._duration)
end

function slot0._btnstartOnClick(slot0)
	if slot0._videoPlayer then
		if slot0._lastVideoId == nil then
			logNormal(":_btnstartOnClick() isnew")
			slot0:play()
		elseif slot0._videoPlayer:IsPaused() then
			logNormal(":_btnstartOnClick() isPaused")
			slot0._videoPlayer:Play()
		elseif slot0._videoPlayer:IsPlaying() then
			logNormal(":_btnstartOnClick() IsPlaying")
			slot0._videoPlayer:Pause()
			slot0:_stopSlideTimeTween()
			slot0:_showPlayIcon(true)
		elseif slot0._videoPlayer:IsFinished() then
			logNormal(":_btnstartOnClick() IsFinished")
			slot0._videoPlayer:Play()
		end
	else
		slot0:play()
		logNormal(":_btnstartOnClick() play")
	end
end

function slot0._editableInitView(slot0)
	slot0._govideoTrs = slot0._govideo.transform
	slot0._gocontentvideoTrs = slot0._gocontentvideo.transform

	gohelper.setActive(slot0._btnpaused, false)

	slot0._goplayIcon = gohelper.findChild(slot0.viewGO, "#go_contentvideo/#btn_start/image")
	slot0._isDotweenSet = false
	slot0._isLastIsFullScreen = false

	gohelper.setActive(slot0._goiconSmall, false)

	slot3, slot4 = recthelper.getAnchor(slot0._gocontentvideoTrs)
	slot0._curRectParam = {
		width = recthelper.getWidth(slot0._gocontentvideoTrs),
		height = recthelper.getHeight(slot0._gocontentvideoTrs),
		anchorX = slot3,
		anchorY = slot4
	}
end

function slot0._editableAddEvents(slot0)
	slot0._slidertime:AddOnValueChanged(slot0._slidertimeOnValueChange, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._slidertime:RemoveOnValueChanged()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._helpVideoCfg = slot1
	slot0._startTime = 0
	slot0._duration = 0
	slot0._curTime = 0

	slot0:_refreshUI()

	if slot0._videoPlayer then
		slot0._lastVideoId = nil

		slot0._videoPlayer:Stop()
		slot0:_stopSlideTimeTween()
		gohelper.setActive(slot0._gocontentvideo, false)
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end

	slot0:_stopSlideTimeTween()
end

function slot0._refreshUI(slot0)
	if slot0._helpVideoCfg then
		slot0._txtdesc.text = slot0._helpVideoCfg.text
	end

	gohelper.setActive(slot0._btnstoryPlay, slot0._helpVideoCfg and slot0._helpVideoCfg.storyId and slot0._helpVideoCfg.storyId ~= 0)
end

function slot0.getIsFullScreen(slot0)
	return slot0._isLastIsFullScreen
end

function slot0._showFullScreen(slot0, slot1)
	if slot0._isLastIsFullScreen == (slot1 and true or false) then
		return
	end

	slot0._isLastIsFullScreen = slot2
	slot3 = slot0._curRectParam.width
	slot4 = slot0._curRectParam.height
	slot5 = slot0._curRectParam.anchorX
	slot6 = slot0._curRectParam.anchorY

	if slot2 then
		slot5 = 0
		slot6 = 0
		slot3 = UnityEngine.Screen.width
		slot4 = UnityEngine.Screen.height
	end

	recthelper.setSize(slot0._gocontentvideoTrs, slot3, slot4)
	recthelper.setAnchor(slot0._gocontentvideoTrs, slot5, slot6)

	if slot0._isInitVideoPlayer then
		recthelper.setSize(slot0._videoPlayerGOTrs, slot3, slot4)
	end

	gohelper.setActive(slot0._goiconFull, not slot2)
	gohelper.setActive(slot0._goiconSmall, slot2)

	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:dispatchEvent(HelpEvent.UIVoideFullScreenChange, slot2)
	end
end

function slot0._showPlayIcon(slot0, slot1)
	gohelper.setActive(slot0._goplayIcon, slot1)
end

function slot0._initVideoPlayer(slot0)
	if not slot0._isInitVideoPlayer then
		slot0._isInitVideoPlayer = true
		slot0._videoPlayer, slot0._displauUGUI, slot0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(slot0._govideo)
		slot0._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleToFit
		slot0._videoPlayerGOTrs = slot0._videoPlayerGO.transform

		slot0:_updateVideoSize()
	end
end

function slot0._updateVideoSize(slot0)
	slot0:_initVideoPlayer()
	recthelper.setSize(slot0._videoPlayerGOTrs, recthelper.getWidth(slot0._gocontentvideoTrs), recthelper.getHeight(slot0._gocontentvideoTrs))
end

function slot0.play(slot0)
	slot0:_initVideoPlayer()

	slot0._lastVideoId = slot0._helpVideoCfg.id

	slot0._videoPlayer:Play(slot0._displauUGUI, slot0._helpVideoCfg.videopath, false, slot0._videoStatusUpdate, slot0)
	gohelper.setActive(slot0._gocontentvideo, true)
end

function slot0.stop(slot0)
	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
	end
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		slot0:_showPlayIcon(true)
	elseif slot2 == AvProEnum.PlayerStatus.FirstFrameReady then
		-- Nothing
	elseif slot2 == AvProEnum.PlayerStatus.Started then
		slot0:_showPlayIcon(false)
	elseif slot2 == AvProEnum.PlayerStatus.StartedSeeking then
		-- Nothing
	end

	slot0._startTime, slot0._duration, slot0._curTime = slot0._videoPlayer:GetTimeRange(0, 0, 0)

	if slot0._videoPlayer:IsPlaying() then
		slot0:_startSlideTimeTween()
	else
		slot0:_stopSlideTimeTween()
	end

	logNormal(string.format("status:%s name:%s timeRange(%s,%s,%s) ", slot2, AvProEnum.getPlayerStatusEnumName(slot2), slot0._startTime, slot0._duration, slot0._curTime))
end

function slot0._stopSlideTimeTween(slot0)
	if slot0._slideTimeTweenId then
		ZProj.TweenHelper.KillById(slot0._slideTimeTweenId)

		slot0._slideTimeTweenId = nil
	end
end

function slot0._startSlideTimeTween(slot0)
	slot0:_stopSlideTimeTween()

	slot3 = 1

	if math.max(0, slot0._duration - math.max(0, slot0._curTime - slot0._startTime)) ~= 0 then
		slot3 = slot1 / slot0._duration
	end

	logNormal(string.format("time:(%s,%s) ftd(%s,%s,%s) ", slot1, slot0._duration, slot3, 1, slot2))

	slot0._slideTimeTweenId = ZProj.TweenHelper.DOTweenFloat(slot3, 1, slot2, slot0._onSlideTimeframeCallback, slot0._onOpenTweenFinishCallback, slot0, nil, EaseType.Linear)
end

function slot0._onSlideTimeframeCallback(slot0, slot1)
	slot0._isDotweenSet = true

	slot0._slidertime:SetValue(slot1)

	slot0._isDotweenSet = false

	slot0:_setVoideTime(slot0._duration * slot1, slot0._duration)
end

function slot0._setVoideTime(slot0, slot1, slot2)
	slot4 = math.floor(slot2)

	if slot0._lastRunTime_ ~= math.floor(slot1) or slot0._lastDuration_ ~= slot4 then
		slot0._lastRunTime_ = slot3
		slot0._lastDuration_ = slot4
		slot0._txtvideoTime.text = slot0:_formatTime(slot3) .. "/" .. slot0:_formatTime(slot4)
	end
end

function slot0._formatTime(slot0, slot1)
	slot2, slot3, slot4 = TimeUtil.secondToHMS(slot1)

	return string.format("%s:%s:%s", slot0:_formatNum(slot2), slot0:_formatNum(slot3), slot0:_formatNum(slot4))
end

function slot0._formatNum(slot0, slot1)
	if slot1 >= 10 then
		return slot1
	end

	return "0" .. slot1
end

return slot0
