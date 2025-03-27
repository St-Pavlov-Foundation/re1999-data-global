module("modules.logic.versionactivity2_4.pinball.view.PinballBuildViewContainer", package.seeall)

slot0 = class("PinballBuildViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PinballBuildView.New()
	}
end

return slot0
