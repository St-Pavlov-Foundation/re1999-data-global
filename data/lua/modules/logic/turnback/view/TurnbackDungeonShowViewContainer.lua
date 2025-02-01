module("modules.logic.turnback.view.TurnbackDungeonShowViewContainer", package.seeall)

slot0 = class("TurnbackDungeonShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackDungeonShowView.New())

	return slot1
end

return slot0
