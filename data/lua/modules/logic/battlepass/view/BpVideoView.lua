module("modules.logic.battlepass.view.BpVideoView", package.seeall)

slot0 = class("BpVideoView", BaseView)

function slot0.onInitView(slot0)
	slot0._videoGo = gohelper.findChild(slot0.viewGO, "#go_video")
end

function slot0.onOpen(slot0)
	slot0._videoPlayer, slot0._displauUGUI = AvProMgr.instance:getVideoPlayer(slot0._videoGo)

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_admission)
	slot0._videoPlayer:Play(slot0._displauUGUI, "videos/bp_open.mp4", false, slot0._videoStatusUpdate, slot0)
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		if not ViewMgr.instance:isOpen(ViewName.BpChargeView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.closeThis, slot0)
			ViewMgr.instance:openView(ViewName.BpChargeView, {
				first = true
			})
		else
			slot0:closeThis()
		end
	end
end

function slot0.onDestroyView(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.closeThis, slot0)

	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

return slot0
