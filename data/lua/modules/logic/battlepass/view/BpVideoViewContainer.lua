module("modules.logic.battlepass.view.BpVideoViewContainer", package.seeall)

slot0 = class("BpVideoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BpVideoView.New()
	}
end

return slot0
