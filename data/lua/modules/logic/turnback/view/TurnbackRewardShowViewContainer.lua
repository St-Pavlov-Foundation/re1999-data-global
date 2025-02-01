module("modules.logic.turnback.view.TurnbackRewardShowViewContainer", package.seeall)

slot0 = class("TurnbackRewardShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackRewardShowView.New())

	return slot1
end

return slot0
