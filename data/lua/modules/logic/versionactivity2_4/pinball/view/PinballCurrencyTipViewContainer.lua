module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyTipViewContainer", package.seeall)

slot0 = class("PinballCurrencyTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PinballCurrencyTipView.New()
	}
end

return slot0
