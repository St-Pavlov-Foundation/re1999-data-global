module("modules.logic.season.view1_4.Season1_4AdditionRuleTipViewContainer", package.seeall)

slot0 = class("Season1_4AdditionRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_4AdditionRuleTipView.New()
	}
end

return slot0
