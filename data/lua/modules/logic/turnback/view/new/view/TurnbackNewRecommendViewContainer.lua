module("modules.logic.turnback.view.new.view.TurnbackNewRecommendViewContainer", package.seeall)

slot0 = class("TurnbackNewRecommendViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackNewRecommendView.New())

	return slot1
end

return slot0
