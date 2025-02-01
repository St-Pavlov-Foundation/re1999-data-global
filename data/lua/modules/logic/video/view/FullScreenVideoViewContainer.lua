module("modules.logic.video.view.FullScreenVideoViewContainer", package.seeall)

slot0 = class("FullScreenVideoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FullScreenVideoView.New()
	}
end

return slot0
