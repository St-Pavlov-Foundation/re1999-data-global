module("modules.logic.battlepass.view.BPFaceViewContainer", package.seeall)

slot0 = class("BPFaceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BPFaceView.New()
	}
end

return slot0
