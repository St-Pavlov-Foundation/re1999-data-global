module("modules.logic.video.view.FullScreenVideoView", package.seeall)

slot0 = class("FullScreenVideoView", BaseView)
slot0.DefaultMaxDuration = 3

function slot0.onInitView(slot0)
	slot0._govideo = gohelper.findChild(slot0.viewGO, "#go_video")
end

function slot0.onOpen(slot0)
	slot0.videoDone = false
	slot0.videoPlayer, slot0.displayUGUI, slot0.videoGo = AvProMgr.instance:getVideoPlayer(slot0._govideo)

	if slot0.viewParam.videoAudio then
		AudioMgr.instance:trigger(slot0.viewParam.videoAudio)
	end

	slot0.videoPlayer:Play(slot0.displayUGUI, slot0.viewParam.videoPath, false, slot0.videoStatusUpdate, slot0)

	slot0.doneCb = slot0.viewParam.doneCb
	slot0.doneCbObj = slot0.viewParam.doneCbObj
	slot0.videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter)).enabled = false

	TaskDispatcher.runDelay(slot0.onVideoOverTime, slot0, slot0.viewParam.videoDuration or uv0.DefaultMaxDuration)
end

function slot0.videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		slot0:onPlayVideoDone()
	elseif slot2 == AvProEnum.PlayerStatus.Closing then
		slot0:onPlayVideoDone()
	end
end

function slot0.onPlayVideoDone(slot0)
	if slot0.videoDone then
		return
	end

	slot0.videoDone = true

	TaskDispatcher.cancelTask(slot0.onVideoOverTime, slot0)
	slot0:closeThis()

	if slot0.doneCb then
		slot0.doneCb(slot0.doneCbObj)
	end

	slot0.doneCb = nil
	slot0.doneCbObj = nil

	VideoController.instance:dispatchEvent(VideoEvent.OnVideoPlayFinished)
end

function slot0.onVideoOverTime(slot0)
	slot0:onPlayVideoDone()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.onVideoOverTime, slot0)

	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

return slot0
