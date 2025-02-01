module("modules.logic.turnback.view.TurnbackPopupBeginnerViewContainer", package.seeall)

slot0 = class("TurnbackPopupBeginnerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackPopupBeginnerView.New())

	return slot1
end

return slot0
