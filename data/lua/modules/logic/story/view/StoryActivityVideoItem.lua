module("modules.logic.story.view.StoryActivityVideoItem", package.seeall)

slot0 = class("StoryActivityVideoItem")

function slot0.ctor(slot0, slot1)
	slot0.viewGO = slot1
end

function slot0.playVideo(slot0, slot1, slot2)
	if slot1 then
		slot0._videoName = string.split(slot1, ".")[1]
	else
		slot0._videoName = nil
	end

	slot2 = slot2 or {}
	slot0._loop = slot2.loop
	slot0._videoStartCallback = slot2.startCallback
	slot0._videoStartCallbackObj = slot2.startCallbackObj
	slot0._videoOutCallback = slot2.outCallback
	slot0._videoOutCallbackObj = slot2.outCallbackObj
	slot0._audioId = slot2.audioId
	slot0._audioNoStopByFinish = slot2.audioNoStopByFinish

	if slot0._videoName then
		if not slot0._videoGo then
			slot0:_build()
		end

		slot0:_playVideo()
	else
		slot0:onVideoStart()
	end
end

function slot0._build(slot0)
	slot0._videoGo = gohelper.create2d(slot0.viewGO, slot0._videoName)
	slot0._avProVideoPlayer = gohelper.onceAddComponent(slot0._videoGo, typeof(ZProj.AvProUGUIPlayer))
	slot0._displauUGUI = gohelper.onceAddComponent(slot0._videoGo, typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	slot0._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop

	slot0._avProVideoPlayer:AddDisplayUGUI(slot0._displauUGUI)
	slot0._avProVideoPlayer:SetEventListener(slot0._onVideoEvent, slot0)
	recthelper.setSize(slot0._videoGo.transform, 2592, 1080)
end

function slot0._playVideo(slot0)
	gohelper.setActive(slot0._videoGo, true)
	slot0._avProVideoPlayer:LoadMedia(langVideoUrl(slot0._videoName))
	StoryModel.instance:setSpecialVideoPlaying(slot0._videoName)
	TaskDispatcher.runDelay(slot0._startVideo, slot0, 0.1)

	if BootNativeUtil.isIOS() then
		TaskDispatcher.runRepeat(slot0._detectPause, slot0, 0.05)
	end
end

function slot0._startVideo(slot0)
	slot0._avProVideoPlayer:Play(slot0._displauUGUI, slot0._loop)
end

function slot0.onVideoStart(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:playAudio(slot0._audioId)
	end

	if slot0._videoStartCallback then
		slot0._videoStartCallback(slot0._videoStartCallbackObj)
	end
end

function slot0.onVideoOut(slot0, slot1)
	slot0:hide(slot1)

	if slot0._videoOutCallback then
		slot0._videoOutCallback(slot0._videoOutCallbackObj)
	end
end

function slot0._onVideoEvent(slot0, slot1, slot2, slot3)
	if slot3 ~= AvProEnum.ErrorCode.None then
		slot0:hide(true)
	end

	if slot2 == AvProEnum.PlayerStatus.FirstFrameReady then
		slot0:onVideoStart()
	end

	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		slot0:onVideoOut(true)
	end
end

function slot0.hide(slot0, slot1)
	if slot0._avProVideoPlayer then
		slot0._avProVideoPlayer:Stop()
	end

	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(slot0._detectPause, slot0)
	end

	if slot1 then
		if not slot0._audioNoStopByFinish then
			slot0:stopAudio()
		end
	else
		slot0:stopAudio()
	end

	gohelper.setActive(slot0._videoGo, false)
end

function slot0._detectPause(slot0)
	if slot0._avProVideoPlayer:IsPaused() then
		slot0._avProVideoPlayer:Play()
	end
end

function slot0.stopAudio(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end
end

function slot0.onDestroy(slot0)
	if slot0._videoName then
		StoryModel.instance:setSpecialVideoEnd(slot0._videoName)
	end

	if slot0._avProVideoPlayer ~= nil then
		slot0._avProVideoPlayer:Clear()

		slot0._avProVideoPlayer = nil
	end

	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(slot0._detectPause, slot0)
	end

	if slot0._videoGo then
		gohelper.destroy(slot0._videoGo)

		slot0._videoGo = nil
	end

	slot0._videoOutCallback = nil
	slot0._videoOutCallbackObj = nil
	slot0._videoStartCallback = nil
	slot0._videoStartCallbackObj = nil

	slot0:stopAudio()
end

return slot0
