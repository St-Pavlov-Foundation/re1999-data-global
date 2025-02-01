module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterVideoView", package.seeall)

slot0 = class("VersionActivity1_6EnterVideoView", BaseView)
slot1 = 3
slot2 = "videos/1_6_enter.mp4"

function slot0.onInitView(slot0)
	slot0._videoRoot = gohelper.findChild(slot0.viewGO, "#go_video")
end

function slot0.onOpen(slot0)
	slot0._videoPlayer, slot0._displauUGUI, slot0._videoGo = AvProMgr.instance:getVideoPlayer(slot0._videoRoot)

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6EnterViewVideo)
	slot0._videoPlayer:Play(slot0._displauUGUI, langVideoUrl("1_6_enter"), false, slot0._videoStatusUpdate, slot0)

	slot0._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter)).enabled = false

	TaskDispatcher.runDelay(slot0.handleVideoOverTime, slot0, uv0)
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying or slot2 == AvProEnum.PlayerStatus.Error then
		slot0:_stopVideoOverTimeAction()
		slot0:closeThis()
		VersionActivity1_6EnterController.instance:dispatchEvent(VersionActivity1_6EnterEvent.OnEnterVideoFinished)
	end
end

function slot0.handleVideoOverTime(slot0)
	slot0:_stopVideoOverTimeAction()
	slot0:closeThis()
	VersionActivity1_6EnterController.instance:dispatchEvent(VersionActivity1_6EnterEvent.OnEnterVideoFinished)
end

function slot0._stopVideoOverTimeAction(slot0)
	TaskDispatcher.cancelTask(slot0.handleVideoOverTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_stopVideoOverTimeAction()

	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

return slot0
