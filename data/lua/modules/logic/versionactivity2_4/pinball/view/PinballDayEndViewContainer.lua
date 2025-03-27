module("modules.logic.versionactivity2_4.pinball.view.PinballDayEndViewContainer", package.seeall)

slot0 = class("PinballDayEndViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PinballDayEndView.New()
	}
end

return slot0
