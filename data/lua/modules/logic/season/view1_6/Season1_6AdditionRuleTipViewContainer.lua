module("modules.logic.season.view1_6.Season1_6AdditionRuleTipViewContainer", package.seeall)

slot0 = class("Season1_6AdditionRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_6AdditionRuleTipView.New()
	}
end

return slot0
