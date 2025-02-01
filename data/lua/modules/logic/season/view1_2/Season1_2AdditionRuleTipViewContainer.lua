module("modules.logic.season.view1_2.Season1_2AdditionRuleTipViewContainer", package.seeall)

slot0 = class("Season1_2AdditionRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_2AdditionRuleTipView.New()
	}
end

return slot0
