module("modules.logic.versionactivity2_4.pinball.view.PinballUpgradeViewContainer", package.seeall)

slot0 = class("PinballUpgradeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PinballUpgradeView.New()
	}
end

return slot0
