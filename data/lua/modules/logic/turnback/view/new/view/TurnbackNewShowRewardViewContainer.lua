module("modules.logic.turnback.view.new.view.TurnbackNewShowRewardViewContainer", package.seeall)

slot0 = class("TurnbackNewShowRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackNewShowRewardView.New())

	return slot1
end

return slot0
