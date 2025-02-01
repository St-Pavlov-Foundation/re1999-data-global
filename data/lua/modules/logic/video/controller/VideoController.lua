module("modules.logic.video.controller.VideoController", package.seeall)

slot0 = class("VideoController", BaseController)

function slot0.openFullScreenVideoView(slot0, slot1, slot2, slot3, slot4, slot5)
	ViewMgr.instance:openView(ViewName.FullScreenVideoView, {
		videoPath = slot1,
		videoAudio = slot2,
		videoDuration = slot3,
		doneCb = slot4,
		doneCbObj = slot5
	})
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
