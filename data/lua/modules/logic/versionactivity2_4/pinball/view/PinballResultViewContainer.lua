module("modules.logic.versionactivity2_4.pinball.view.PinballResultViewContainer", package.seeall)

slot0 = class("PinballResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PinballResultView.New()
	}
end

return slot0
