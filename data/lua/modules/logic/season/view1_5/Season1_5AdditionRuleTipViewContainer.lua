module("modules.logic.season.view1_5.Season1_5AdditionRuleTipViewContainer", package.seeall)

slot0 = class("Season1_5AdditionRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_5AdditionRuleTipView.New()
	}
end

return slot0
