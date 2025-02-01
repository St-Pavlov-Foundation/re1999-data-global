module("modules.logic.season.view1_6.Season1_6SumViewContainer", package.seeall)

slot0 = class("Season1_6SumViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season1_6SumView.New())

	return slot1
end

return slot0
