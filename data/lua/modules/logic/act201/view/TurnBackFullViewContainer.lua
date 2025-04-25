module("modules.logic.act201.view.TurnBackFullViewContainer", package.seeall)

slot0 = class("TurnBackFullViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnBackFullView.New())

	return slot1
end

return slot0
