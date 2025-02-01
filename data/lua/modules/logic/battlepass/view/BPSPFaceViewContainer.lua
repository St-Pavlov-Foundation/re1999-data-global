module("modules.logic.battlepass.view.BPSPFaceViewContainer", package.seeall)

slot0 = class("BPSPFaceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BPSPFaceView.New()
	}
end

return slot0
