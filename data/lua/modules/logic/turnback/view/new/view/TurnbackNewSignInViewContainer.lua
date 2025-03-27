module("modules.logic.turnback.view.new.view.TurnbackNewSignInViewContainer", package.seeall)

slot0 = class("TurnbackNewSignInViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackNewSignInView.New())

	return slot1
end

return slot0
