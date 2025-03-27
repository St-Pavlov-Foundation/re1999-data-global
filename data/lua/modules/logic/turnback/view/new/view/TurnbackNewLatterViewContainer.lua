module("modules.logic.turnback.view.new.view.TurnbackNewLatterViewContainer", package.seeall)

slot0 = class("TurnbackNewLatterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackNewLatterView.New())

	return slot1
end

return slot0
