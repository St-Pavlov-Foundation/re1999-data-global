module("modules.logic.turnback.view.new.view.TurnbackNewBenfitViewContainer", package.seeall)

slot0 = class("TurnbackNewBenfitViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackNewBenfitView.New())

	return slot1
end

return slot0
