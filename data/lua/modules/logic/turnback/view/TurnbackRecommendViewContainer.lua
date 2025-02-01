module("modules.logic.turnback.view.TurnbackRecommendViewContainer", package.seeall)

slot0 = class("TurnbackRecommendViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TurnbackRecommendView.New()
	}
end

return slot0
