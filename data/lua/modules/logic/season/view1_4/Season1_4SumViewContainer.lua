module("modules.logic.season.view1_4.Season1_4SumViewContainer", package.seeall)

slot0 = class("Season1_4SumViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season1_4SumView.New())

	return slot1
end

return slot0
