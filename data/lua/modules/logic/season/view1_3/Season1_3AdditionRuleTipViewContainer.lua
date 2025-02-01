module("modules.logic.season.view1_3.Season1_3AdditionRuleTipViewContainer", package.seeall)

slot0 = class("Season1_3AdditionRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_3AdditionRuleTipView.New()
	}
end

return slot0
