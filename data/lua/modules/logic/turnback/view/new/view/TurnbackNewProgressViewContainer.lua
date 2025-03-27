module("modules.logic.turnback.view.new.view.TurnbackNewProgressViewContainer", package.seeall)

slot0 = class("TurnbackNewProgressViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackNewProgressView.New())

	return slot1
end

return slot0
